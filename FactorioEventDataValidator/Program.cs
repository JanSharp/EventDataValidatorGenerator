using System; 
using System.Threading.Tasks;
using System.Net.Http;
using System.Xml;
using System.Xml.Linq;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;
using System.Collections.Generic;
using FactorioEventDataValidator.Data;

namespace FactorioEventDataValidator
{
    public class Program
    {
        public static readonly HttpClient Client = new HttpClient();

        static async Task Main(string[] args)
        {
            string gameVersion = args[0];
            string namedHtmlEntities = File.ReadAllText("NamedHtmlEntities.txt");

            string definesHtml = "<!DOCTYPE html [" + namedHtmlEntities + "]>"
                + Regex.Replace(await Client.GetStringAsync(string.Format("https://lua-api.factorio.com/{0}/defines.html", gameVersion)), @"^<!DOCTYPE[^>]*?>", "");

            var hi = XElement.Parse(definesHtml);
            ParseDefinesDefinition(XElement.Parse(definesHtml).Element("body"));
            var hi2 = ContentType.AllTypes;


            string eventsHtml = "<!DOCTYPE html [" + namedHtmlEntities + "]>"
                + Regex.Replace(await Client.GetStringAsync(string.Format("https://lua-api.factorio.com/{0}/events.html", gameVersion)), @"^<!DOCTYPE[^>]*?>", "");

            List<EventDefinition> eventDefinitions = XElement.Parse(eventsHtml)
                .Element("body")
                .Elements()
                .Where(e => HasClassXElement(e, "element"))
                .Skip(1) // skip "All Events" because 'name' and 'tick' are always overwritten by the game, therefore always valid
                .Select(e => ParseEventDefinition(e))
                .ToList();
            EventSpecificDefinitions.ReadAndAddDefinitions(eventDefinitions, out List<ConceptDefinition> concepts);

            //File.WriteAllText("definesHtml.txt", definesHtml);
            //File.WriteAllText("eventsHtml.txt", eventsHtml);

            Generator.Generate(eventDefinitions, concepts, gameVersion);
        }

        static void ParseDefinesDefinition(XElement definition)
        {
            XElement content = GetClassXElement(definition, "element-content") ?? definition; // ?? definition just to make it work with the very fisrt call
            XElement briefMembers = GetClassXElement(content, "brief-members");
            var elements = content.Elements().Where(e => HasClassXElement(e, "element"));
            if (elements.Any())
                foreach (XElement subDef in elements)
                    ParseDefinesDefinition(subDef);
            else
                ContentType.Add(new ContentTypeDefines()
                {
                    readableName = definition.Attribute("id").Value,
                    mainName = definition.Attribute("id").Value.Replace(".", "__"),
                    defineNames = briefMembers.Elements().Select(e => e.Attribute("id").Value).ToArray(),
                });
        }


        static EventDefinition ParseEventDefinition(XElement definition)
        {
            definition = GetClassXElement(definition, "element");
            XElement content = GetClassXElement(definition, "element-content");
            List<EventContent> contents = new List<EventContent>();

            EventDefinition result = new EventDefinition()
            {
                contents = contents,
                name = definition.Attribute("id").Value,
                //description = content.Value,
                //filterable = content.Value.Contains("Can be filtered using"),
            };

            XElement detail = GetClassXElement(content, "detail");
            if (detail != null)
            {
                XElement detailContent = GetClassXElement(detail, "detail-content");
                foreach (XElement itemContent in detailContent.Elements())
                {
                    contents.Add(new EventContent()
                    {
                        type = GetContentType(GetClassXElement(itemContent, "param-type")),
                        name = GetClassXElement(itemContent, "param-name").Value,
                        //description = Regex.Match(itemContent.Value, @"::\s*(.*)").Groups.Cast<Group>().Last().Captures.First().Value,
                        optional = (GetClassXElement(itemContent, "opt") != null || itemContent.Value.Contains("or nil")) ? true : false,
                    });
                }
            }
            return result;
        }

        static ContentType GetContentType(XElement typeElem)
        {
            string valueTrimmed = typeElem.Value.Trim();
            if (valueTrimmed.StartsWith("array of"))
                return ContentType.GetArray(GetContentType(GetClassXElement(typeElem, "param-type")));
            if (valueTrimmed.StartsWith("dictionary"))
                return ContentType.GetDictionary(
                    GetContentType(GetClassXElement(typeElem, "param-type")),
                    GetContentType(GetClassXElement(typeElem, "param-type", c => c.Skip(1))));

            XElement refElem = typeElem.Element("a");
            if (refElem == null) // edge case where the type is defined locally on the events page - hard coded
            {
                return valueTrimmed switch
                {
                    "Waypoint" => ContentType.Get("Concepts.html#Waypoint"), // hard coded in ContentType.AllTypes
                    _ => throw new Exception("Missing hard coded defintion for '" + valueTrimmed + "'."),
                };
            }
            string typeString = refElem.Attribute("href").Value;
            if (typeString == "LuaLazyLoadedValue.html")
                return ContentType.GetLazy(GetContentType(GetClassXElement(typeElem, "param-type")));
            return ContentType.Get(typeString);
        }

        static bool HasClassXElement(XElement e, string className) => e.Attribute("class")?.Value == className;
        static XElement GetClassXElement(XElement e, string className) => e.Elements().FirstOrDefault(e => e.Attribute("class")?.Value == className);
        static XElement GetClassXElement(XElement e, string className, Func<IEnumerable<XElement>, IEnumerable<XElement>> modifier) =>
            modifier(e.Elements()).FirstOrDefault(e => e.Attribute("class")?.Value == className);
    }
}
