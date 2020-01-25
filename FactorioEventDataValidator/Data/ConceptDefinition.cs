using System;
using System.Collections.Generic;
using System.Text;

namespace FactorioEventDataValidator.Data
{
    public class ConceptDefinition : ICustomDefinition
    {
        public string name;

        public Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>> Resolvers { get; set; }

        public ConceptDefinition()
        {
            Resolvers = new Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>>();
        }
    }
}
