using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using FactorioEventDataValidator.Data;
using System.Linq;
using System.IO;

namespace FactorioEventDataValidator
{
    public static class Generator
    {
        // yes these should be config vars, but idc
        public const string SourceLuaDir = "../../../Lua";
        public const string TargetLuaDir = "FinishedMod";
        public const string ModName = "RaiseEventProtection";
        public const string ValidatorFile = "protection.lua";
        public const string ValidatorsFile = "validators.lua";
        public const string InfoFile = "info.json";
        public static readonly List<string> IncludeFiles = new List<string>()
        {
            //".vscode/launch.json",
            //".vscode/settings.json",
            "filters.lua",
            "all-entity-types.lua",
            "changelog.txt",
            "LICENSE",
            "locale/en/RaiseEventProtection.cfg",
        };
        


        public static void Generate(List<EventDefinition> events, List<ConceptDefinition> concepts, string gameVersion)
        {
            List<ContentType> contentTypes = new List<ContentType>();
            void AddContentType(ContentType ct)
            {
                if (ct.type == ContentTypeType.Concept)
                    return;
                contentTypes.Add(ct);
                if (ct is ContentTypeArray cta)
                    AddContentType(cta.elemType);
                else if (ct is ContentTypeDictionary ctd)
                {
                    AddContentType(ctd.keyType);
                    AddContentType(ctd.valueType);
                }
                else if (ct is ContentTypeLazyLoadedValue ctl)
                    AddContentType(ctl.lazyValueType);
            }
            events.ForEach(ed => ed.contents.ForEach(ec => AddContentType(ec.type)));

            // types needed for hardcoded concepts
            new List<string>() {
                "i__double",
                "i__int",
                "i__float",
                "i__uint",
                "a__luatileprototype",
                //"n__tileposition", // concepts are defined sepereatly, so this is just here for completeness
            }.ForEach(s => contentTypes.Add(ContentType.AllTypes[s])); // this will just throw if it does not exist
            if (!contentTypes.Any(ct => ct.Id == "r__i__string"))
            {
                contentTypes.Add(new ContentTypeArray()
                {
                    readableName = "array of string",
                    elemType = contentTypes.First(ct => ct.Id == "i__string"),
                });
            }

            contentTypes = contentTypes.Distinct().ToList();


            DirectoryInfo sourceDir = new DirectoryInfo(SourceLuaDir);
            DirectoryInfo targetDir = new DirectoryInfo(Path.Combine(TargetLuaDir, ModName + "_" + gameVersion));
            if (!targetDir.Exists)
                targetDir.Create();

            string validatorSource = File.ReadAllText(Path.Combine(sourceDir.FullName, ValidatorFile));
            validatorSource = PreProcess(validatorSource);
            StringBuilder sb = new StringBuilder();
            Resolve(sb, validatorSource, new List<(Dictionary<string, string> labels, Resolver subResolver)>()
            {
                (new Dictionary<string, string>()
                {
                    { "mod_name", ModName },
                },
                t => t switch
                {
                    "ignore_event" => events.Where(ed => ed.contents.Count == 0).Select(ed => (new Dictionary<string, string>()
                    {
                        { "event_name", ed.name },
                    },
                    (Resolver)null)).ToList(),

                    _ => throw new Exception("You sir have a tag '" + t + "' which is invalid, please elaborate."),
                })
            });
            File.WriteAllText(Path.Combine(targetDir.FullName, ValidatorFile), RemoveTrailingSpaces(sb.ToString()));
            sb.Clear();

            string validatorsSource = File.ReadAllText(Path.Combine(sourceDir.FullName, ValidatorsFile));
            validatorsSource = PreProcess(validatorsSource);
            Resolve(sb, validatorsSource, new List<(Dictionary<string, string> labels, Resolver subResolver)>()
            {
                (new Dictionary<string, string>()
                {
                    { "mod_name", ModName },
                },
                t => t switch
                {
                    "concept_validator" => concepts.Select(cd => (new Dictionary<string, string>()
                    {
                        { "concept_name", cd.name },
                    },
                    (Resolver)(t => cd.Resolvers.ContainsKey(t) ? cd.Resolvers[t] : null)
                    )).ToList(),

                    "type_validator" => contentTypes.Select(ct => (new Dictionary<string, string>()
                    {
                        { "type_id", ct.Id },
                        { "type_name", ct.readableName },
                    },
                    ct.Resolver)).ToList(),

                    "event_validator" => events.Where(ed => ed.contents.Count != 0).Select(ed => (new Dictionary<string, string>()
                    {
                        { "event_name", ed.name },
                    },
                    (Resolver)(t2 =>
                    {
                        List<(Dictionary<string, string> labels, Resolver subResolver)> result;
                        switch (t2)
                        {
                            case "field":
                                result = ed.contents.Select(ec => (new Dictionary<string, string>()
                                {
                                    { "field_name", ec.name },
                                    { "field_type_id", ec.type.Id },
                                    { "field_type_name", ec.type.readableName },
                                },
                                (Resolver)(t3 => t3 switch
                                {
                                    "required" => ec.optional ? null : new List<(Dictionary<string, string> labels, Resolver subResolver)>() { (null, null) },
                                    "optional" => ec.optional ? new List<(Dictionary<string, string> labels, Resolver subResolver)>() { (null, null) } : null,
                                    _ => null,
                                })
                                )).ToList();
                                break;
                            default:
                                if (ed.Resolvers.ContainsKey(t2))
                                    result = ed.Resolvers[t2];
                                else
                                    result = null;
                                break;
                        };
                        return result;
                    })
                    )).ToList(),

                    _ => throw new Exception("You sir have a tag '" + t + "' which is invalid, please elaborate."),
                })
            });
            File.WriteAllText(Path.Combine(targetDir.FullName, ValidatorsFile), RemoveBlankLines(RemoveTrailingSpaces(sb.ToString())));
            sb.Clear();

            File.WriteAllText(
                Path.Combine(targetDir.FullName, InfoFile),
                File.ReadAllText(Path.Combine(sourceDir.FullName, InfoFile))
                    .Replace("{{mod_name}}", ModName)
                    .Replace("{{version}}", gameVersion)
                    .Replace("{{factorio_version}}", Regex.Replace(gameVersion, @"\.[^.]+\z", ""))
                );

            foreach (string filename in IncludeFiles)
            {
                string source = Path.Combine(sourceDir.FullName, filename);
                string dest = Path.Combine(targetDir.FullName, filename);
                if (!Directory.Exists(Path.GetDirectoryName(dest)))
                    Directory.CreateDirectory(Path.GetDirectoryName(dest));
                File.WriteAllText(dest, File.ReadAllText(source).Replace("{{mod_name}}", ModName));
            }
        }

        public delegate List<(Dictionary<string, string> labels, Resolver subResolver)> Resolver(string tag);

        static readonly Regex PreProcessRegex = new Regex(@"--\[\[!(.*?)\]\].*?--\[\[!\]\]", RegexOptions.Singleline | RegexOptions.Compiled);
        static string PreProcess(string source) => PreProcessRegex.Replace(source, @"$1");

        static readonly Regex RemoveBlankLinesRegex = new Regex(@"^\s*?\n", RegexOptions.Multiline | RegexOptions.Compiled);
        static string RemoveBlankLines(string source) => RemoveBlankLinesRegex.Replace(source, "");

        static readonly Regex RemoveTrailingSpacesRegex = new Regex(@"[^\n\S]+\n", RegexOptions.RightToLeft | RegexOptions.Compiled);
        static string RemoveTrailingSpaces(string source) => RemoveTrailingSpacesRegex.Replace(source, "\n");

        static readonly Regex ResolveRegex = new Regex(@"\G(?<text>.*?)(?:--<\s*(?<tag>\w+)(?>\s+(?<attribute>\w+)=\u0022(?<attrValue>[^\u0022]*)\u0022)*\s*(?:/>|>\s*(?<tagContent>.*?)--</\k<tag>>)|\z)", RegexOptions.Singleline | RegexOptions.Compiled);
        static void Resolve(StringBuilder sb, string toResolve, List<(Dictionary<string, string> labels, Resolver subResolver)> resolveData)
        {
            foreach (var itemResolveData in resolveData ?? new List<(Dictionary<string, string> labels, Resolver subResolver)>())
            {
                string currentToResolve = toResolve;
                foreach (var kvp in itemResolveData.labels ?? new Dictionary<string, string>())
                    currentToResolve = currentToResolve.Replace("{{" + kvp.Key + "}}", kvp.Value);

                foreach (Match itemMatch in ResolveRegex.Matches(currentToResolve))
                {
                    sb.Append(itemMatch.Groups["text"].Value);
                    if (itemMatch.Groups["tag"].Success)
                    {
                        Resolve(sb, itemMatch.Groups["tagContent"].Value, itemResolveData.subResolver(itemMatch.Groups["tag"].Value));
                    }
                }
            }
        }
    }
}
