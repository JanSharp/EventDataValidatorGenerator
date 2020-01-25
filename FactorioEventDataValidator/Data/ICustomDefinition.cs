using System;
using System.Collections.Generic;
using System.Text;

namespace FactorioEventDataValidator.Data
{
    interface ICustomDefinition
    {
        Dictionary<string, List<(Dictionary<string, string> labels, Generator.Resolver subResolver)>> Resolvers { get; set; }
    }
}
