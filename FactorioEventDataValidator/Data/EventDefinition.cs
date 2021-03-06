﻿using System;
using System.Collections.Generic;
using System.Text;

namespace FactorioEventDataValidator.Data
{
    public class EventDefinition : ICustomDefinition
    {
        public string name;
        public string description;
        //public bool filterable;

        public Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>> Resolvers { get; set; }

        public List<EventContent> contents;

        public EventDefinition()
        {
            Resolvers = new Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>>();
        }
    }
}
