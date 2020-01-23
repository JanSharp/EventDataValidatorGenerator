using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using FactorioEventDataValidator.Data;
using System.IO;
using System.Linq;

namespace FactorioEventDataValidator
{
    public static class EventSpecificDefinitions
    {
        public const string SourceLuaDir = Generator.SourceLuaDir;
        public const string FileName = "event-specific-definitions.txt";

        public static void ReadAndAddDefinitions(List<EventDefinition> events)
        {
            DirectoryInfo sourceDir = new DirectoryInfo(SourceLuaDir);
            string input = File.ReadAllText(Path.Combine(sourceDir.FullName, FileName));
            int pos = 0;

            bool hasMapping = TryParseDefinition(input, out Definition mapping, ref pos);
            if (!hasMapping || mapping.name != "[mapping]")
                throw new Exception("Event specific definitions missing [mapping].");

            Dictionary<string, Definition> definitions = new Dictionary<string, Definition>();
            while (TryParseDefinition(input, out Definition def, ref pos))
                definitions.Add(def.name, def);

            foreach (EventDefinition itemEvent in events)
            {
                Definition definition = definitions.ContainsKey(itemEvent.name) ? definitions[itemEvent.name] : new Definition(itemEvent.name, new List<Tag>());
                EventContent playerIndex = itemEvent.contents.FirstOrDefault(ec => ec.name == "player_index");
                if (playerIndex != null)
                    definition.tags.Add(new Tag("player_index", new List<string>() { "player_index" }, playerIndex.optional ? new List<Tag>() { new Tag("optional", new List<string>(), new List<Tag>()) } : new List<Tag>()));
                EventContent surfaceIndex = itemEvent.contents.FirstOrDefault(ec => ec.name == "surface_index");
                if (surfaceIndex != null)
                    definition.tags.Add(new Tag("surface_index", new List<string>() { "surface_index" }, surfaceIndex.optional ? new List<Tag>() { new Tag("optional", new List<string>(), new List<Tag>()) } : new List<Tag>()));
                itemEvent.eventSpecificResolvers = definition.Create(mapping);
            }
        }

        static readonly Regex BlankRegex = new Regex(@"\G(?>\s+|--\[\[[^]]*\]\])*", RegexOptions.Compiled);
        static readonly Regex NameRegex = new Regex(@"\G(?>\z(?<end>)|(?<name>\S+)\s*)", RegexOptions.Compiled);
        static readonly Regex TagRegex = new Regex(@"\G\s*(?>;(?<end>)|<(?<tag>[^>]+)>\s*(?>\u0022(?<var>[^\u0022]*)\u0022\s*)*)", RegexOptions.Compiled);

        static bool TryParseDefinition(string input, out Definition result, ref int pos)
        {
            pos += BlankRegex.Match(input, pos).Length;
            Match match = NameRegex.Match(input, pos);
            pos += match.Length;
            if (match.Groups["end"].Success)
            {
                result = null;
                return false;
            }
            result = new Definition(match.Groups["name"].Value, ParseTags(input, ref pos));
            return true;
        }

        static List<Tag> ParseTags(string input, ref int pos)
        {
            List<Tag> result = new List<Tag>();
            while (TryParseTag(input, out Tag tag, ref pos))
                result.Add(tag);
            return result;
        }
        static bool TryParseTag(string input, out Tag result, ref int pos)
        {
            Match match = TagRegex.Match(input, pos);
            pos += match.Length;
            if (!match.Success || match.Groups["end"].Success)
            {
                result = null;
                return false;
            }
            result = new Tag(match.Groups["tag"].Value, match.Groups["var"].Captures.Cast<Capture>().Select(c => c.Value).ToList(), ParseTags(input, ref pos));
            return true;
        }


        class Definition
        {
            public string name;
            public List<Tag> tags;

            public Definition(string name, List<Tag> tags)
            {
                this.name = name;
                this.tags = tags;
            }

            public Tag GetTag(string name) => tags.First(t => t.name == name);

            public Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>> Create(Definition mapping)
            {
                return tags.GroupBy(t => t.name).ToDictionary(g => g.Key, g => g.Select(t => t.Create(mapping.GetTag(g.Key))).ToList());
            }
        }

        class Tag
        {
            public string name;
            public List<string> variables;
            public List<Tag> subTags;

            public Tag(string name, List<string> variables, List<Tag> subTags)
            {
                this.name = name;
                this.variables = variables;
                this.subTags = subTags;
            }

            public IEnumerable<Tag> GetSubTags(string name) => subTags.Where(t => t.name == name);

            public (Dictionary<string, string> labels, Generator.Resolver subResolver) Create(Tag mapping)
            {
                Dictionary<string, string> lables = variables.Select((v, i) => (v, i)).ToDictionary(v => mapping.variables[v.i], v => v.v);
                Generator.Resolver resolver = t => subTags.Any(st => st.name == t) ? GetSubTags(t).Select(st => st.Create(mapping.GetSubTags(t).First())).ToList() : null;
                return (lables, resolver);
            }
        }
    }
}
