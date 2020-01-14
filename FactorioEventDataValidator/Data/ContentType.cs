using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Linq;

namespace FactorioEventDataValidator.Data
{
    public abstract class ContentType
    {
        public static readonly Dictionary<string, ContentType> AllTypes = new Dictionary<string, ContentType>()
        {
            #region Builtin
            { "i__float", new ContentTypeBuiltin() { // note that float does not have validation, but nobody should rely on a floats precision anyway imo
                readableName = "float",
                name = "float",
                typeString = "number",
            } },
            { "i__double", new ContentTypeBuiltin() {
				readableName = "double",
                name = "double",
                typeString = "number",
            } },
            { "i__int", new ContentTypeBuiltin() {
				readableName = "int",
                name = "int",
                typeString = "number",
                minValue = -2147483648,
                maxValue = 2147483647,
                integer = true,
            } },
            { "i__int8", new ContentTypeBuiltin() {
				readableName = "int8",
                name = "int8",
                typeString = "number",
                minValue = -128,
                maxValue = 127,
                integer = true,
            } },
            { "i__uint", new ContentTypeBuiltin() {
				readableName = "uint",
                name = "uint",
                typeString = "number",
                minValue = 0,
                maxValue = 4294967295,
                integer = true,
            } },
            { "i__uint8", new ContentTypeBuiltin() {
				readableName = "uint8",
                name = "uint8",
                typeString = "number",
                minValue = 0,
                maxValue = 255,
                integer = true,
            } },
            { "i__uint16", new ContentTypeBuiltin() {
                readableName = "uint16",
                name = "uint16",
                typeString = "number",
                minValue = 0,
                maxValue = 65535,
                integer = true,
            } },
            { "i__uint64", new ContentTypeBuiltin() {
				readableName = "uint64",
                name = "uint64",
                typeString = "number",
                minValue = 0,
                maxValue = 18446744073709551615,
                integer = true,
            } },
            { "i__string", new ContentTypeBuiltin() {
				readableName = "string",
                name = "string",
                typeString = "string",
            } },
            { "i__boolean", new ContentTypeBuiltin() {
				readableName = "boolean",
                name = "boolean",
                typeString = "boolean",
            } },
            { "i__table", new ContentTypeBuiltin() {
				readableName = "table",
                name = "table",
                typeString = "table",
            } },
            #endregion

            //#region Custom Builtin
            //{ "i__whole_double", new ContentTypeBuiltin() {
            //    readableName = "whole double",
            //    name = "whole_double",
            //    typeString = "number",
            //    integer = true,
            //} },
            //#endregion

            #region Concepts
            { "n__position", new ContentTypeConcept() { readableName = "Position", name = "position" } },
            { "n__chunkposition", new ContentTypeConcept() { readableName = "ChunkPosition", name = "chunkposition" } },
            { "n__tileposition", new ContentTypeConcept() { readableName = "TilePosition", name = "tileposition" } },
            { "n__simpleitemstack", new ContentTypeConcept() { readableName = "SimpleItemStack", name = "simpleitemstack" } },
            { "n__oldtileandposition", new ContentTypeConcept() { readableName = "OldTileAndPosition", name = "oldtileandposition" } },
            { "n__boundingbox", new ContentTypeConcept() { readableName = "BoundingBox", name = "boundingbox" } },
            { "n__tags", new ContentTypeConcept() { readableName = "Tags", name = "tags" } },
            { "n__localisedstring", new ContentTypeConcept() { readableName = "LocalisedString", name = "localisedstring" } },
            { "n__displayresolution", new ContentTypeConcept() { readableName = "DisplayResolution", name = "displayresolution" } },
            { "n__signalid", new ContentTypeConcept() { readableName = "SignalID", name = "signalid" } },
            #endregion

            #region Special (treated as Concepts)
            { "n__waypoint", new ContentTypeConcept() { readableName = "Waypoint", name = "waypoint" } },
            #endregion
        };

        // (new ContentTypeBuiltin.+\n.+?name = "(\w+)".*(\n.+?)*})

        public readonly ContentTypeType type;
        public string readableName;
        public abstract string Id { get; }

        public ContentType(ContentTypeType type)
        {
            this.type = type;
        }


        public abstract Generator.Resolver Resolver { get; }

        static readonly Regex RefRegex = new Regex(@"(?>(?<page>[^#]+)(?>#(?<id>.+))?)");
        static ContentTypeType PageTypeMap(string page) => page switch
        {
            "Builtin-Types.html" => ContentTypeType.Builtin,
            "Concepts.html" => ContentTypeType.Concept,
            "defines.html" => ContentTypeType.Defines,
            _ => ContentTypeType.LuaObject,
        };
        public static ContentType Get(string fullLink)
        {
            Match match = RefRegex.Match(fullLink);
            string page = match.Groups["page"].Value;
            string linkInPage = match.Groups["id"].Success ? match.Groups["id"].Value : null;
            ContentTypeType type = PageTypeMap(page);
            string pageName = page[0..^5 /*5 = .html*/];
            string name = (linkInPage ?? pageName).Replace(".", "__").ToLower();
            string id = GetIdPrefix(type) + name;

            if (AllTypes.TryGetValue(id, out ContentType result))
                return result;

            if (type != ContentTypeType.LuaObject) // only LuaObjects should get here
                throw new Exception("Missing hard coded concept '" + id + "'.");
            result = new ContentTypeLuaObject() { readableName = pageName, name = name };
            AllTypes.Add(id, result);
            return result;
            //throw new Exception("Missing (hard coded?) content type for " + fullLink + ".");
        }
        public static ContentType GetArray(ContentType elemType)
        {
            string id = GetIdPrefix(ContentTypeType.Array) + elemType.Id;
            if (AllTypes.TryGetValue(id, out ContentType result))
                return result;
            result = new ContentTypeArray() { readableName = "array of " + elemType.readableName, elemType = elemType };
            AllTypes.Add(id, result);
            return result;
        }
        public static ContentType GetDictionary(ContentType keyType, ContentType valueType)
        {
            string id = GetIdPrefix(ContentTypeType.Dictionary) + "k__" + keyType.Id + "__v__" + valueType.Id;
            if (AllTypes.TryGetValue(id, out ContentType result))
                return result;
            result = new ContentTypeDictionary() { readableName = "dictionary " + keyType.readableName + " -> " + valueType.readableName, keyType = keyType, valueType = valueType };
            AllTypes.Add(id, result);
            return result;
        }
        public static ContentType GetLazy(ContentType lazyValueType)
        {
            string id = GetIdPrefix(ContentTypeType.LazyLoadedValue) + lazyValueType.Id;
            if (AllTypes.TryGetValue(id, out ContentType result))
                return result;
            result = new ContentTypeLazyLoadedValue() { readableName = "LuaLazyLoadedValue (" + lazyValueType.readableName + ")", lazyValueType = lazyValueType };
            AllTypes.Add(id, result);
            return result;
        }

        public static void Add(ContentType ct) => AllTypes.Add(ct.Id, ct);

        protected static string GetIdPrefix(ContentTypeType contentTypeType) =>
            char.ToLower(contentTypeType.ToString()[2]) + "__";
    }
}
