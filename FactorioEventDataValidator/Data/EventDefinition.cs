using System;
using System.Collections.Generic;
using System.Text;

namespace FactorioEventDataValidator.Data
{
    public class EventDefinition
    {
        public string name;
        public string description;
        //public bool filterable;

        public Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>> eventSpecificResolvers;

        public List<EventContent> contents;

        public EventDefinition()
        {
            eventSpecificResolvers = new Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>>();
        }
    }
}
