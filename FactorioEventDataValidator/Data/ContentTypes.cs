using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FactorioEventDataValidator.Data
{
    public class ContentTypeDefines : ContentType
    {
        public string mainName;
        public string[] defineNames;

        public override string Id => GetIdPrefix(ContentTypeType.Defines) + mainName;

        public ContentTypeDefines()
            : base(ContentTypeType.Defines)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "defines" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (null, t2 => t2 switch
                {
                    "check" => defineNames.Select(n => (new Dictionary<string, string>() { { "define_name", n } }, (Generator.Resolver)null)).ToList(),
                    _ => null,
                })
            },
            _ => null,
        };
    }

    public class ContentTypeBuiltin : ContentType
    {
        public string name;
        public string typeString; // the id string of the Lua type (returned by 'type(...)')
        // these 2 will just get null checked an ToStringed()
        public object maxValue; // for 'number' types, even then optional
        public object minValue; // for 'number' types, even then optional
        public bool integer;

        public override string Id => GetIdPrefix(ContentTypeType.Builtin) + name;

        public ContentTypeBuiltin()
            : base(ContentTypeType.Builtin)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "builtin_or_luaobj" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (new Dictionary<string, string>() {
                    { "type_string", typeString },
                    { "min_value", minValue?.ToString() ?? "" },
                    { "max_value", maxValue?.ToString() ?? "" },
                },
                t2 => t2 switch
                {
                    "min_check" => minValue == null ? null : new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>() { (null, null) },
                    "max_check" => maxValue == null ? null : new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>() { (null, null) },
                    "integer_check" => integer ? new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>() { (null, null) } : null,
                    _ => null,
                })
            },
            _ => null,
        };
    }

    public class ContentTypeLuaObject : ContentType
    {
        public string name;

        public override string Id => GetIdPrefix(ContentTypeType.LuaObject) + name;

        public ContentTypeLuaObject()
            : base(ContentTypeType.LuaObject)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "builtin_or_luaobj" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (new Dictionary<string, string>() {
                    { "type_string", readableName },
                },
                t2 => null)
            },
            _ => null,
        };
    }

    public class ContentTypeConcept : ContentType
    {
        public string name;

        public override string Id => GetIdPrefix(ContentTypeType.Concept) + name;

        public ContentTypeConcept()
            : base(ContentTypeType.Concept)
        { }

        public override Generator.Resolver Resolver => throw new Exception("Asking for a Concepts Resolver? They are hard coded man.");
    }

    public class ContentTypeArray : ContentType
    {
        public ContentType elemType;

        public override string Id => GetIdPrefix(ContentTypeType.Array) + elemType.Id;

        public ContentTypeArray()
            : base(ContentTypeType.Array)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "array" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (new Dictionary<string, string>() {
                    { "array_elem_type_id", elemType.Id },
                },
                t2 => null)
            },
            _ => null,
        };
    }

    public class ContentTypeDictionary : ContentType
    {
        public ContentType keyType;
        public ContentType valueType;

        public override string Id => GetIdPrefix(ContentTypeType.Dictionary) + "k__" + keyType.Id + "__v__" + valueType.Id;

        public ContentTypeDictionary()
            : base(ContentTypeType.Dictionary)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "dictionary" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (new Dictionary<string, string>() {
                    { "dict_key_type_id", keyType.Id },
                    { "dict_value_type_id", valueType.Id },
                },
                t2 => null)
            },
            _ => null,
        };
    }

    public class ContentTypeLazyLoadedValue : ContentType
    {
        public ContentType lazyValueType;

        public override string Id => GetIdPrefix(ContentTypeType.LazyLoadedValue) + lazyValueType.Id;

        public ContentTypeLazyLoadedValue()
            : base(ContentTypeType.LazyLoadedValue)
        { }

        public override Generator.Resolver Resolver => t => t switch
        {
            "lazy" => new List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>()
            {
                (new Dictionary<string, string>(){
                    { "lazy_type_id", lazyValueType.Id },
                },
                t2 => null)
            },
            _ => null,
        };
    }
}
