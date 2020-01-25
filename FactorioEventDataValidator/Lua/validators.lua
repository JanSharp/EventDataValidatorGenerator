
-- https://gist.github.com/justarandomgeek/3f4a3672dd3e98a301a8dfb531babf01#file-luaobjecttype-lua-L7

local function lua_object_type(obj)
  local t = rawget(obj, "luaObjectType")
  if t == nil then
    --[[No way to avoid a pcall unfortunately]]
    local success, help = pcall(function(obj) return obj.help() end, obj)
    if not success then
      --[[Extract type from error message]]
      t = string.sub(help, 1, string.find(help, " ") - 1)
    else
      --[[Extract type from help message]]
      t = string.sub(help, 10, string.find(help, ":") - 1)
    end
    rawset(obj, "luaObjectType", t)
  end
  return t
end

local isluaobjectmagic = "802384732948701238470123"
local function advanced_type(obj)
  local typ = type(obj)
  if typ == "table" and obj.isluaobject == isluaobjectmagic then
    return lua_object_type(obj), true
  end
  return typ, false
end

local function evaluate_full_field_name(field_name, field_names)
  -- field_names is a table of names, but for performance reasons that table only gets
  -- created if there are nested type checks (so for checking 'entity' it would be nil, but for
  -- 'position.x' it would be a table {"position", "x"})
  --
  -- if a value in field_names is not a string, or the string is not a valid lua identifier
  -- (like if it contains a dash '-' or something) it will be put in square brackets
  -- but the first name is guaranteed to be a valid identifier
  --
  -- the full field name string only needs to be evaluated for errors,
  -- so who cares about performance in this function

  if field_names then
    for i, v in next, field_names, 1 do -- save to skip 1 like this, since it will always be there
      if type(v) ~= "string" then
        v = tostring(v)
      end
      if string.match(v, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
        field_names[i] = "." .. v
      else
        field_names[i] = '["' .. v .. '"]'
      end
    end
    return table.concat(field_names)
  else
    return field_name
  end
end

-- from here on everything is generated (some of it "generated", but still)
-- predefine all locals so that the upvalues link correctly
--<type_validator>
--[[!local {{type_id}}]] --[[!]]
--</type_validator>

--<concept_validator>
--[[!local n__{{concept_name}}]] --[[!]]
--</concept_validator>

-- concepts (and 'Waypoint')
--[[!]]
-- these types must also be hard coded defined in C# (Generator.cs)
local i__double
local i__int
--[[!]]

local values_for_signalid_type = {
  ["item"] = true,
  ["fluid"] = true,
  ["virtual"] = true,
}

--<concept_validator>
function n__--[[!{{concept_name}}]] --[[!]](data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value

  --<basic_type_check>
  local data_type = advanced_type(data)
  if data_type ~= "{{type_name}}" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "{{concept_display_name}}", data_type},
    }
  end
  --</basic_type_check>

  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end

  --<field>
  value = data["{{field_name}}"]
  field_names[field_name_count] = "{{field_name}}"

  --<required>
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "{{field_type_name}}"},
    }
  end
  --</required>

  --<optional>
  if value then
  --</optional>

    --[[!{{field_type_id}}]] _ --[[!]](value, source_mod_name, event_name, nil, field_names, field_name_count)

  --<optional>
  end
  --</optional>

  --<player_index>
  value = data["{{player_index_field_name}}"]
  field_names[field_name_count] = "{{player_index_field_name}}"
  --<optional>
  if value then
  --</optional>
    if not game.get_player(value) then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, event_name},
        {"raise-event-protection.field-with-invalid-value-simple", evaluate_full_field_name(field_name, field_names), "player index"},
      }
    end
  --<optional>
  end
  --</optional>
  --</player_index>

  --<signalid>
  -- the value of type is in value already in this case
  if not values_for_signalid_type[value] then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-must-be-one-of", evaluate_full_field_name(field_name, field_names), "item, fluid, virtual"},
    }
  end
  --</signalid>

  --</field>

  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
--</concept_validator>

-- type validators

--<type_validator>
function --[[!{{type_id}}]] _ --[[!]](value, source_mod_name, event_name, field_name, field_names, field_name_count)
  --[[!]] local value_type --[[just so that there are no warnings about redefined locals in here]] --[[!]]

  --<lazy>
  --[[!{{lazy_type_id}}]] _ --[[!]](value.get(), source_mod_name, event_name, field_name, field_names, field_name_count)
  --</lazy>

  --<array>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "{{type_name}}", value_type},
    }
  end
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  local array_length = 0
  for i, v in ipairs(value) do
    field_names[field_name_count] = i
    --[[!{{array_elem_type_id}}]] _ --[[!]](v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "{{type_name}}"},
    }
  end
  --</array>


  --<dictionary>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "{{type_name}}", value_type},
    }
  end
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  local key_string
  for k, v in pairs(value) do
    key_string = tostring(k)
    field_names[field_name_count] = "[__key__] " .. key_string
    --[[!{{dict_key_type_id}}]] _ --[[!]](k, source_mod_name, event_name, nil, field_names, field_name_count)
    field_names[field_name_count] = "[__value__] " .. key_string
    --[[!{{dict_value_type_id}}]] _ --[[!]](v, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  --</dictionary>


  --<builtin_or_luaobj>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "{{type_string}}" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "{{type_name}}", value_type},
    }
  end

  --<min_check>
  if value < --[[!{{min_value}}]] 0 --[[!]] then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "{{type_name}}", "{{min_value}}", "{{max_value}}"},
    }
  end
  --</min_check>

  --<max_check>
  if value > --[[!{{max_value}}]] 0 --[[!]] then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "{{type_name}}", "{{min_value}}", "{{max_value}}"},
    }
  end
  --</max_check>

  --<integer_check>
  if value % 1 ~= 0 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-non-integer-value", evaluate_full_field_name(field_name, field_names), "{{type_name}}"},
    }
  end
  --</integer_check>

  --</builtin_or_luaobj>


  --<defines>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "{{type_name}}", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    --<check>
    value == --[[!{{define_name}}]] nil --[[!]] or
    --</check>
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "{{type_name}}", "{{type_name}}"},
    }
  end
  --</defines>
end
--</type_validator>



-- event data validators


--<event_validator>
--<type_check>
--<multiple>
local types_for_--[[!{{event_name}}]] --[[!]] = {
  --<type_name>
  ["{{type_name_in_collection}}"] = true,
  --</type_name>
}
--</multiple>
--</type_check>
--</event_validator>

return {
  --<event_validator>
  [defines.events["{{event_name}}"]] = function(data, source_mod_name)
    local value
    --<field>
    value = data["{{field_name}}"]

    --<required>
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "{{event_name}}"},
        {"raise-event-protection.field-missing", "{{field_name}}", "{{field_type_name}}"},
      }
    end
    --</required>

    --<optional>
    if value then
    --</optional>

      --[[!{{field_type_id}}]] _ --[[!]](value, source_mod_name, "{{event_name}}", "{{field_name}}")

    --<optional>
    end
    --</optional>

    --</field>

    --<type_check>
    local e = data["{{field_name_to_check}}"]
    local e_type
    --<optional>
    if e then
    --</optional>
      e_type = e.type
      --<single>
      if e_type ~= "{{expected_type}}" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "{{event_name}}"},
          {"raise-event-protection.field-with-wrong-type", "{{field_name_to_check}}", "{{expected_type}}", "{{expected_type}}"},
        }
      end
      --</single>
      --<multiple>
      if not types_for_--[[!{{event_name}}]] --[[!]][e_type] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "{{event_name}}"},
          {"raise-event-protection.field-with-wrong-type", "{{field_name_to_check}}", "{{expected_type}}", "{{expected_type}}"},
        }
      end
      --</multiple>
    --<optional>
    end
    --</optional>
    --</type_check>

    --<player_index>
    value = data["{{player_index_field_name}}"]
    --<optional>
    if value then
    --</optional>
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "{{event_name}}"},
         {"raise-event-protection.field-with-invalid-value-simple", "{{player_index_field_name}}", "player index"},
        }
      end
    --<optional>
    end
    --</optional>
    --</player_index>

    --<surface_index>
    value = data["{{surface_index_field_name}}"]
    --<optional>
    if value then
    --</optional>
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "{{event_name}}"},
          {"raise-event-protection.field-with-invalid-value-simple", "{{surface_index_field_name}}", "surface index"},
        }
      end
    --<optional>
    end
    --</optional>
    --</surface_index>

    --<localed_return_for_filters>
    --[[!return e, e_type]] --[[!]]
    --</localed_return_for_filters>

    --<full_return_for_filters>
    --[[!local]] --[[!]] e = data["{{entity_field_name}}"]
    return e, e.type
    --</full_return_for_filters>
  end,
  --</event_validator>
}
