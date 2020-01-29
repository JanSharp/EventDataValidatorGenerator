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
      if type(v) == "string" then
        if string.match(v, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
          field_names[i] = "." .. v
        else
          field_names[i] = '["' .. v .. '"]'
        end
      else
        field_names[i] = '[' .. tostring(v) .. ']'
      end
    end
    return table.concat(field_names)
  else
    return field_name
  end
end
-- from here on everything is generated (some of it "generated", but still)
-- predefine all locals so that the upvalues link correctly
local i__uint
local f__defines__behavior_result
local a__luasurface
local a__luaforce
local i__boolean
local a__luaentity
local r__n__tileposition
local a__luaunitgroup
local a__luaitemstack
local a__luaitemprototype
local a__luacustomcharttag
local i__string
local r__n__chunkposition
local a__luadamageprototype
local i__float
local a__luainventory
local a__luaguielement
local f__defines__mouse_button_type
local f__defines__gui_type
local a__luaequipment
local a__luaplayer
local a__luatechnology
local a__luaentityprototype
local r__a__luaentity
local r__a__luatile
local a__luatile
local r__n__oldtileandposition
local a__luatileprototype
local a__luarecipe
local i__double
local a__luaequipmentgrid
local f__defines__direction
local z__c__k__i__uint__v__a__luaentity
local c__k__i__uint__v__a__luaentity
local r__n__waypoint
local a__luatrain
local f__defines__train_state
local i__int
local r__i__string
local n__position
local n__chunkposition
local n__tileposition
local n__boundingbox
local n__simpleitemstack
local n__oldtileandposition
local n__tags
local n__displayresolution
local n__localisedstring
local n__signalid
local n__waypoint
-- concepts (and 'Waypoint')
local values_for_signalid_type = {
  ["item"] = true,
  ["fluid"] = true,
  ["virtual"] = true,
}
local values_for_n__tags = {
  ["string"] = true,
  ["boolean"] = true,
  ["number"] = true,
}
function n__position(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "Position", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["x"]
  field_names[field_name_count] = "x"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "double"},
    }
  end
    i__double(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["y"]
  field_names[field_name_count] = "y"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "double"},
    }
  end
    i__double(value, source_mod_name, event_name, nil, field_names, field_name_count)
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__chunkposition(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "ChunkPosition", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["x"]
  field_names[field_name_count] = "x"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "int"},
    }
  end
    i__int(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["y"]
  field_names[field_name_count] = "y"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "int"},
    }
  end
    i__int(value, source_mod_name, event_name, nil, field_names, field_name_count)
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__tileposition(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "TilePosition", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["x"]
  field_names[field_name_count] = "x"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "int"},
    }
  end
    i__int(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["y"]
  field_names[field_name_count] = "y"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "int"},
    }
  end
    i__int(value, source_mod_name, event_name, nil, field_names, field_name_count)
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__boundingbox(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "BoundingBox", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["left_top"]
  field_names[field_name_count] = "left_top"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "Position"},
    }
  end
    n__position(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["right_top"]
  field_names[field_name_count] = "right_top"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "Position"},
    }
  end
    n__position(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["orientation"]
  field_names[field_name_count] = "orientation"
  if value then
    i__float(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__simpleitemstack(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "SimpleItemStack", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["name"]
  field_names[field_name_count] = "name"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "string"},
    }
  end
    i__string(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["count"]
  field_names[field_name_count] = "count"
  if value then
    i__uint(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  value = data["health"]
  field_names[field_name_count] = "health"
  if value then
    i__float(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  value = data["durability"]
  field_names[field_name_count] = "durability"
  if value then
    i__double(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  value = data["ammo"]
  field_names[field_name_count] = "ammo"
  if value then
    i__double(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  value = data["tags"]
  field_names[field_name_count] = "tags"
  if value then
    r__i__string(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__oldtileandposition(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "OldTileAndPosition", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["old_tile"]
  field_names[field_name_count] = "old_tile"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "LuaTilePrototype"},
    }
  end
    a__luatileprototype(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["position"]
  field_names[field_name_count] = "position"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "TilePosition"},
    }
  end
    n__tileposition(value, source_mod_name, event_name, nil, field_names, field_name_count)
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__tags(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "Tags", data_type},
    }
  end
  -- modified copy paste from dictionary validation
  local value_type = advanced_type(data)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "Tags", value_type},
    }
  end
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  local key_string
  for k, v in pairs(data) do
    key_string = tostring(k)
    field_names[field_name_count] = key_string
    i__string(k, source_mod_name, event_name, nil, field_names, field_name_count)
    value_type = advanced_type(v)
    if not values_for_n__tags[value_type] then
      if value_type == "table" then
        n__tags(v, source_mod_name, event_name, nil, field_names, field_name_count)
      else
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, event_name},
          {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "[string, boolean, number, table]", value_type},
        }
      end
    end
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__displayresolution(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "DisplayResolution", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["width"]
  field_names[field_name_count] = "width"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "uint"},
    }
  end
    i__uint(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["height"]
  field_names[field_name_count] = "height"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "uint"},
    }
  end
    i__uint(value, source_mod_name, event_name, nil, field_names, field_name_count)
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__localisedstring(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  -- modified copy paste from array validation
  local value_type = advanced_type(data)
  if value_type == "string" then return end
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LocalisedString", value_type},
    }
  end
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  local first_value = data[1]
  field_names[field_name_count] = 1
  if not first_value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "string"},
    }
  end
  i__string(first_value, source_mod_name, event_name, nil, field_names, field_name_count)
  local array_length = 0
  local not_first = false
  for i, v in ipairs(data) do
    if not_first then
      field_names[field_name_count] = i
      n__localisedstring(v, source_mod_name, event_name, nil, field_names, field_name_count)
      array_length = i
    else
      not_first = true
    end
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(data) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "LocalisedString"},
    }
  end
end
function n__signalid(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "SignalID", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["name"]
  field_names[field_name_count] = "name"
  if value then
    i__string(value, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  value = data["type"]
  field_names[field_name_count] = "type"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "string"},
    }
  end
    i__string(value, source_mod_name, event_name, nil, field_names, field_name_count)
  -- the value of type is in value already in this case
  if not values_for_signalid_type[value] then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-must-be-one-of", evaluate_full_field_name(field_name, field_names), "item, fluid, virtual"},
    }
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function n__waypoint(data, source_mod_name, event_name, field_name, field_names, field_name_count)
  local data_type = advanced_type(data)
  if data_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "WayPoint", data_type},
    }
  end
  local value
  if not field_names then
    field_names = {field_name}
    field_name_count = 2
  else
    field_name_count = field_name_count + 1
  end
  value = data["player_index"]
  field_names[field_name_count] = "player_index"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "uint"},
    }
  end
    i__uint(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["waypoint_index"]
  field_names[field_name_count] = "waypoint_index"
  if not value then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-missing", evaluate_full_field_name(field_name, field_names), "uint"},
    }
  end
    i__uint(value, source_mod_name, event_name, nil, field_names, field_name_count)
  value = data["player_index"]
    field_names[field_name_count] = "player_index"
    if not game.get_player(value) then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, event_name},
        {"raise-event-protection.field-with-invalid-value-simple", evaluate_full_field_name(field_name, field_names), "player index"},
      }
    end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
-- type validators
function i__uint(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "uint", value_type},
    }
  end
  if value < 0 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "uint", "0", "4294967295"},
    }
  end
  if value > 4294967295 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "uint", "0", "4294967295"},
    }
  end
  if value % 1 ~= 0 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-non-integer-value", evaluate_full_field_name(field_name, field_names), "uint"},
    }
  end
end
function f__defines__behavior_result(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "defines.behavior_result", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.behavior_result.in_progress or
    value == defines.behavior_result.fail or
    value == defines.behavior_result.success or
    value == defines.behavior_result.deleted or
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "defines.behavior_result", "defines.behavior_result"},
    }
  end
end
function a__luasurface(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaSurface" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaSurface", value_type},
    }
  end
end
function a__luaforce(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaForce" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaForce", value_type},
    }
  end
end
function i__boolean(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "boolean" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "boolean", value_type},
    }
  end
end
function a__luaentity(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEntity" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaEntity", value_type},
    }
  end
end
function r__n__tileposition(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of TilePosition", value_type},
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
    n__tileposition(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of TilePosition"},
    }
  end
end
function a__luaunitgroup(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaUnitGroup" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaUnitGroup", value_type},
    }
  end
end
function a__luaitemstack(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaItemStack" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaItemStack", value_type},
    }
  end
end
function a__luaitemprototype(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaItemPrototype" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaItemPrototype", value_type},
    }
  end
end
function a__luacustomcharttag(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaCustomChartTag" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaCustomChartTag", value_type},
    }
  end
end
function i__string(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "string" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "string", value_type},
    }
  end
end
function r__n__chunkposition(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of ChunkPosition", value_type},
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
    n__chunkposition(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of ChunkPosition"},
    }
  end
end
function a__luadamageprototype(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaDamagePrototype" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaDamagePrototype", value_type},
    }
  end
end
function i__float(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "float", value_type},
    }
  end
end
function a__luainventory(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaInventory" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaInventory", value_type},
    }
  end
end
function a__luaguielement(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaGuiElement" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaGuiElement", value_type},
    }
  end
end
function f__defines__mouse_button_type(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "defines.mouse_button_type", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.mouse_button_type.none or
    value == defines.mouse_button_type.left or
    value == defines.mouse_button_type.right or
    value == defines.mouse_button_type.middle or
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "defines.mouse_button_type", "defines.mouse_button_type"},
    }
  end
end
function f__defines__gui_type(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "defines.gui_type", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.gui_type.none or
    value == defines.gui_type.entity or
    value == defines.gui_type.research or
    value == defines.gui_type.controller or
    value == defines.gui_type.production or
    value == defines.gui_type.item or
    value == defines.gui_type.bonus or
    value == defines.gui_type.trains or
    value == defines.gui_type.achievement or
    value == defines.gui_type.blueprint_library or
    value == defines.gui_type.equipment or
    value == defines.gui_type.logistic or
    value == defines.gui_type.other_player or
    value == defines.gui_type.kills or
    value == defines.gui_type.permissions or
    value == defines.gui_type.tutorials or
    value == defines.gui_type.custom or
    value == defines.gui_type.server_management or
    value == defines.gui_type.player_management or
    value == defines.gui_type.tile or
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "defines.gui_type", "defines.gui_type"},
    }
  end
end
function a__luaequipment(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEquipment" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaEquipment", value_type},
    }
  end
end
function a__luaplayer(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaPlayer" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaPlayer", value_type},
    }
  end
end
function a__luatechnology(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTechnology" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaTechnology", value_type},
    }
  end
end
function a__luaentityprototype(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEntityPrototype" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaEntityPrototype", value_type},
    }
  end
end
function r__a__luaentity(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of LuaEntity", value_type},
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
    a__luaentity(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of LuaEntity"},
    }
  end
end
function r__a__luatile(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of LuaTile", value_type},
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
    a__luatile(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of LuaTile"},
    }
  end
end
function a__luatile(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTile" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaTile", value_type},
    }
  end
end
function r__n__oldtileandposition(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of OldTileAndPosition", value_type},
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
    n__oldtileandposition(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of OldTileAndPosition"},
    }
  end
end
function a__luatileprototype(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTilePrototype" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaTilePrototype", value_type},
    }
  end
end
function a__luarecipe(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaRecipe" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaRecipe", value_type},
    }
  end
end
function i__double(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "double", value_type},
    }
  end
end
function a__luaequipmentgrid(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEquipmentGrid" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaEquipmentGrid", value_type},
    }
  end
end
function f__defines__direction(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "defines.direction", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.direction.north or
    value == defines.direction.northeast or
    value == defines.direction.east or
    value == defines.direction.southeast or
    value == defines.direction.south or
    value == defines.direction.southwest or
    value == defines.direction.west or
    value == defines.direction.northwest or
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "defines.direction", "defines.direction"},
    }
  end
end
function z__c__k__i__uint__v__a__luaentity(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  c__k__i__uint__v__a__luaentity(value.get(), source_mod_name, event_name, field_name, field_names, field_name_count)
end
function c__k__i__uint__v__a__luaentity(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "dictionary uint -> LuaEntity", value_type},
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
    i__uint(k, source_mod_name, event_name, nil, field_names, field_name_count)
    field_names[field_name_count] = "[__value__] " .. key_string
    a__luaentity(v, source_mod_name, event_name, nil, field_names, field_name_count)
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
end
function r__n__waypoint(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of Waypoint", value_type},
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
    n__waypoint(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of Waypoint"},
    }
  end
end
function a__luatrain(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTrain" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "LuaTrain", value_type},
    }
  end
end
function f__defines__train_state(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "defines.train_state", value_type},
    }
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.train_state.on_the_path or
    value == defines.train_state.path_lost or
    value == defines.train_state.no_schedule or
    value == defines.train_state.no_path or
    value == defines.train_state.arrive_signal or
    value == defines.train_state.wait_signal or
    value == defines.train_state.arrive_station or
    value == defines.train_state.wait_station or
    value == defines.train_state.manual_control_stop or
    value == defines.train_state.manual_control or
    false)
  then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-value", evaluate_full_field_name(field_name, field_names), "defines.train_state", "defines.train_state"},
    }
  end
end
function i__int(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "int", value_type},
    }
  end
  if value < -2147483648 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "int", "-2147483648", "2147483647"},
    }
  end
  if value > 2147483647 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-value-out-of-range", evaluate_full_field_name(field_name, field_names), "int", "-2147483648", "2147483647"},
    }
  end
  if value % 1 ~= 0 then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-non-integer-value", evaluate_full_field_name(field_name, field_names), "int"},
    }
  end
end
function r__i__string(value, source_mod_name, event_name, field_name, field_names, field_name_count)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-wrong-type", evaluate_full_field_name(field_name, field_names), "array of string", value_type},
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
    i__string(v, source_mod_name, event_name, nil, field_names, field_name_count)
    array_length = i
  end
  field_names[field_name_count] = nil
  field_name_count = field_name_count - 1
  if array_length ~= table_size(value) then
    error{"",
      {"raise-event-protection.error-prefix", source_mod_name, event_name},
      {"raise-event-protection.field-with-invalid-array", evaluate_full_field_name(field_name, field_names), "array of string"},
    }
  end
end
-- event data validators
local types_for_on_gui_checked_state_changed = {
  ["checkbox"] = true,
  ["radiobutton"] = true,
}
local types_for_on_gui_selection_state_changed = {
  ["drop-down"] = true,
  ["list-box"] = true,
}
local types_for_on_gui_text_changed = {
  ["textfield"] = true,
  ["text-box"] = true,
}
local types_for_on_pre_ghost_deconstructed = {
  ["entity-ghost"] = true,
  ["tile_ghost"] = true,
}
return {
  [defines.events["on_ai_command_completed"]] = function(data, source_mod_name)
    local value
    value = data["unit_number"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_ai_command_completed"},
        {"raise-event-protection.field-missing", "unit_number", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_ai_command_completed", "unit_number")
    value = data["result"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_ai_command_completed"},
        {"raise-event-protection.field-missing", "result", "defines.behavior_result"},
      }
    end
      f__defines__behavior_result(value, source_mod_name, "on_ai_command_completed", "result")
  end,
  [defines.events["on_area_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source_surface"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "source_surface", "LuaSurface"},
      }
    end
      a__luasurface(value, source_mod_name, "on_area_cloned", "source_surface")
    value = data["source_area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "source_area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_area_cloned", "source_area")
    value = data["destination_surface"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "destination_surface", "LuaSurface"},
      }
    end
      a__luasurface(value, source_mod_name, "on_area_cloned", "destination_surface")
    value = data["destination_area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "destination_area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_area_cloned", "destination_area")
    value = data["destination_force"]
    if value then
      a__luaforce(value, source_mod_name, "on_area_cloned", "destination_force")
    end
    value = data["clone_tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "clone_tiles", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_tiles")
    value = data["clone_entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "clone_entities", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_entities")
    value = data["clone_decoratives"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "clone_decoratives", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_decoratives")
    value = data["clear_destination_entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "clear_destination_entities", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clear_destination_entities")
    value = data["clear_destination_decoratives"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_area_cloned"},
        {"raise-event-protection.field-missing", "clear_destination_decoratives", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clear_destination_decoratives")
  end,
  [defines.events["on_biter_base_built"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_biter_base_built"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_biter_base_built", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "unit-spawner" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_biter_base_built"},
          {"raise-event-protection.field-with-wrong-type", "entity", "unit-spawner", "unit-spawner"},
        }
      end
  end,
  [defines.events["on_brush_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source_offset"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "source_offset", "TilePosition"},
      }
    end
      n__tileposition(value, source_mod_name, "on_brush_cloned", "source_offset")
    value = data["destination_offset"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "destination_offset", "TilePosition"},
      }
    end
      n__tileposition(value, source_mod_name, "on_brush_cloned", "destination_offset")
    value = data["source_surface"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "source_surface", "LuaSurface"},
      }
    end
      a__luasurface(value, source_mod_name, "on_brush_cloned", "source_surface")
    value = data["source_positions"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "source_positions", "array of TilePosition"},
      }
    end
      r__n__tileposition(value, source_mod_name, "on_brush_cloned", "source_positions")
    value = data["destination_surface"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "destination_surface", "LuaSurface"},
      }
    end
      a__luasurface(value, source_mod_name, "on_brush_cloned", "destination_surface")
    value = data["destination_force"]
    if value then
      a__luaforce(value, source_mod_name, "on_brush_cloned", "destination_force")
    end
    value = data["clone_tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "clone_tiles", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_tiles")
    value = data["clone_entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "clone_entities", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_entities")
    value = data["clone_decoratives"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "clone_decoratives", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_decoratives")
    value = data["clear_destination_entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "clear_destination_entities", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clear_destination_entities")
    value = data["clear_destination_decoratives"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_brush_cloned"},
        {"raise-event-protection.field-missing", "clear_destination_decoratives", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clear_destination_decoratives")
  end,
  [defines.events["on_build_base_arrived"]] = function(data, source_mod_name)
    local value
    value = data["unit"]
    if value then
      a__luaentity(value, source_mod_name, "on_build_base_arrived", "unit")
    end
    value = data["group"]
    if value then
      a__luaunitgroup(value, source_mod_name, "on_build_base_arrived", "group")
    end
    local e = data["unit"]
    local e_type
    if e then
      e_type = e.type
      if e_type ~= "unit" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_build_base_arrived"},
          {"raise-event-protection.field-with-wrong-type", "unit", "unit", "unit"},
        }
      end
    end
  end,
  [defines.events["on_built_entity"]] = function(data, source_mod_name)
    local value
    value = data["created_entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_built_entity"},
        {"raise-event-protection.field-missing", "created_entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_built_entity", "created_entity")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_built_entity"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_built_entity", "player_index")
    value = data["stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_built_entity"},
        {"raise-event-protection.field-missing", "stack", "LuaItemStack"},
      }
    end
      a__luaitemstack(value, source_mod_name, "on_built_entity", "stack")
    value = data["item"]
    if value then
      a__luaitemprototype(value, source_mod_name, "on_built_entity", "item")
    end
    value = data["tags"]
    if value then
      n__tags(value, source_mod_name, "on_built_entity", "tags")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_built_entity"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    local e = data["created_entity"]
    return e, e.type
  end,
  [defines.events["on_cancelled_deconstruction"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_cancelled_deconstruction"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_cancelled_deconstruction", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_cancelled_deconstruction", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_cancelled_deconstruction"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_cancelled_upgrade"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_cancelled_upgrade"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_cancelled_upgrade", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_cancelled_upgrade", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_cancelled_upgrade"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_character_corpse_expired"]] = function(data, source_mod_name)
    local value
    value = data["corpse"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_character_corpse_expired"},
        {"raise-event-protection.field-missing", "corpse", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_character_corpse_expired", "corpse")
    local e = data["corpse"]
    local e_type
      e_type = e.type
      if e_type ~= "character-corpse" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_character_corpse_expired"},
          {"raise-event-protection.field-with-wrong-type", "corpse", "character-corpse", "character-corpse"},
        }
      end
  end,
  [defines.events["on_chart_tag_added"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_added"},
        {"raise-event-protection.field-missing", "tag", "LuaCustomChartTag"},
      }
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_added", "tag")
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_added"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_added", "force")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_added", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_added"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_chart_tag_modified"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
        {"raise-event-protection.field-missing", "tag", "LuaCustomChartTag"},
      }
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_modified", "tag")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_modified", "player_index")
    end
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_modified", "force")
    value = data["old_text"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
        {"raise-event-protection.field-missing", "old_text", "string"},
      }
    end
      i__string(value, source_mod_name, "on_chart_tag_modified", "old_text")
    value = data["old_icon"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
        {"raise-event-protection.field-missing", "old_icon", "SignalID"},
      }
    end
      n__signalid(value, source_mod_name, "on_chart_tag_modified", "old_icon")
    value = data["old_player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_modified", "old_player_index")
    end
    value = data["old_player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
         {"raise-event-protection.field-with-invalid-value-simple", "old_player_index", "player index"},
        }
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_modified"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_chart_tag_removed"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_removed"},
        {"raise-event-protection.field-missing", "tag", "LuaCustomChartTag"},
      }
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_removed", "tag")
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_removed"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_removed", "force")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_removed", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_chart_tag_removed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_chunk_charted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_charted"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_chunk_charted", "surface_index")
    value = data["position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_charted"},
        {"raise-event-protection.field-missing", "position", "ChunkPosition"},
      }
    end
      n__chunkposition(value, source_mod_name, "on_chunk_charted", "position")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_charted"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_chunk_charted", "area")
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_charted"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_chunk_charted", "force")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_charted"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_chunk_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_deleted"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_chunk_deleted", "surface_index")
    value = data["positions"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_deleted"},
        {"raise-event-protection.field-missing", "positions", "array of ChunkPosition"},
      }
    end
      r__n__chunkposition(value, source_mod_name, "on_chunk_deleted", "positions")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_deleted"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_chunk_generated"]] = function(data, source_mod_name)
    local value
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_generated"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_chunk_generated", "area")
    value = data["position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_generated"},
        {"raise-event-protection.field-missing", "position", "ChunkPosition"},
      }
    end
      n__chunkposition(value, source_mod_name, "on_chunk_generated", "position")
    value = data["surface"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_chunk_generated"},
        {"raise-event-protection.field-missing", "surface", "LuaSurface"},
      }
    end
      a__luasurface(value, source_mod_name, "on_chunk_generated", "surface")
  end,
  [defines.events["on_combat_robot_expired"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_combat_robot_expired"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_combat_robot_expired", "robot")
    value = data["owner"]
    if value then
      a__luaentity(value, source_mod_name, "on_combat_robot_expired", "owner")
    end
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "combat-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_combat_robot_expired"},
          {"raise-event-protection.field-with-wrong-type", "robot", "combat-robot", "combat-robot"},
        }
      end
  end,
  [defines.events["on_console_chat"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_console_chat", "player_index")
    end
    value = data["message"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_console_chat"},
        {"raise-event-protection.field-missing", "message", "string"},
      }
    end
      i__string(value, source_mod_name, "on_console_chat", "message")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_console_chat"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_console_command"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_console_command", "player_index")
    end
    value = data["command"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_console_command"},
        {"raise-event-protection.field-missing", "command", "string"},
      }
    end
      i__string(value, source_mod_name, "on_console_command", "command")
    value = data["parameters"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_console_command"},
        {"raise-event-protection.field-missing", "parameters", "string"},
      }
    end
      i__string(value, source_mod_name, "on_console_command", "parameters")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_console_command"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_cutscene_waypoint_reached"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_cutscene_waypoint_reached"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_cutscene_waypoint_reached", "player_index")
    value = data["waypoint_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_cutscene_waypoint_reached"},
        {"raise-event-protection.field-missing", "waypoint_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_cutscene_waypoint_reached", "waypoint_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_cutscene_waypoint_reached"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_difficulty_settings_changed"]] = function(data, source_mod_name)
    local value
    value = data["old_recipe_difficulty"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_difficulty_settings_changed"},
        {"raise-event-protection.field-missing", "old_recipe_difficulty", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_difficulty_settings_changed", "old_recipe_difficulty")
    value = data["old_technology_difficulty"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_difficulty_settings_changed"},
        {"raise-event-protection.field-missing", "old_technology_difficulty", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_difficulty_settings_changed", "old_technology_difficulty")
  end,
  [defines.events["on_entity_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_cloned"},
        {"raise-event-protection.field-missing", "source", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_cloned", "source")
    value = data["destination"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_cloned"},
        {"raise-event-protection.field-missing", "destination", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_cloned", "destination")
  end,
  [defines.events["on_entity_damaged"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_damaged"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_damaged", "entity")
    value = data["damage_type"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_damaged"},
        {"raise-event-protection.field-missing", "damage_type", "LuaDamagePrototype"},
      }
    end
      a__luadamageprototype(value, source_mod_name, "on_entity_damaged", "damage_type")
    value = data["original_damage_amount"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_damaged"},
        {"raise-event-protection.field-missing", "original_damage_amount", "float"},
      }
    end
      i__float(value, source_mod_name, "on_entity_damaged", "original_damage_amount")
    value = data["final_damage_amount"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_damaged"},
        {"raise-event-protection.field-missing", "final_damage_amount", "float"},
      }
    end
      i__float(value, source_mod_name, "on_entity_damaged", "final_damage_amount")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_entity_damaged", "cause")
    end
    value = data["force"]
    if value then
      a__luaforce(value, source_mod_name, "on_entity_damaged", "force")
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_entity_died"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_died"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_died", "entity")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_entity_died", "cause")
    end
    value = data["loot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_died"},
        {"raise-event-protection.field-missing", "loot", "LuaInventory"},
      }
    end
      a__luainventory(value, source_mod_name, "on_entity_died", "loot")
    value = data["force"]
    if value then
      a__luaforce(value, source_mod_name, "on_entity_died", "force")
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_entity_renamed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_entity_renamed", "player_index")
    end
    value = data["by_script"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_renamed"},
        {"raise-event-protection.field-missing", "by_script", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_entity_renamed", "by_script")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_renamed"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_renamed", "entity")
    value = data["old_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_renamed"},
        {"raise-event-protection.field-missing", "old_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_entity_renamed", "old_name")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_entity_renamed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_entity_settings_pasted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_entity_settings_pasted", "player_index")
    value = data["source"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "source", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_settings_pasted", "source")
    value = data["destination"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "destination", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_settings_pasted", "destination")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_entity_settings_pasted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_entity_spawned"]] = function(data, source_mod_name)
    local value
    value = data["spawner"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_spawned"},
        {"raise-event-protection.field-missing", "spawner", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_spawned", "spawner")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_entity_spawned"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_entity_spawned", "entity")
    local e = data["spawner"]
    local e_type
      e_type = e.type
      if e_type ~= "unit-spawner" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_entity_spawned"},
          {"raise-event-protection.field-with-wrong-type", "spawner", "unit-spawner", "unit-spawner"},
        }
      end
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_entity_spawned"},
          {"raise-event-protection.field-with-wrong-type", "entity", "unit", "unit"},
        }
      end
  end,
  [defines.events["on_force_cease_fire_changed"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_cease_fire_changed"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_force_cease_fire_changed", "force")
    value = data["other_force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_cease_fire_changed"},
        {"raise-event-protection.field-missing", "other_force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_force_cease_fire_changed", "other_force")
    value = data["added"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_cease_fire_changed"},
        {"raise-event-protection.field-missing", "added", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_force_cease_fire_changed", "added")
  end,
  [defines.events["on_force_created"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_created"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_force_created", "force")
  end,
  [defines.events["on_force_friends_changed"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_friends_changed"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_force_friends_changed", "force")
    value = data["other_force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_friends_changed"},
        {"raise-event-protection.field-missing", "other_force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_force_friends_changed", "other_force")
    value = data["added"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_force_friends_changed"},
        {"raise-event-protection.field-missing", "added", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_force_friends_changed", "added")
  end,
  [defines.events["on_forces_merged"]] = function(data, source_mod_name)
    local value
    value = data["source_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_forces_merged"},
        {"raise-event-protection.field-missing", "source_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_forces_merged", "source_name")
    value = data["source_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_forces_merged"},
        {"raise-event-protection.field-missing", "source_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_forces_merged", "source_index")
    value = data["destination"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_forces_merged"},
        {"raise-event-protection.field-missing", "destination", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_forces_merged", "destination")
  end,
  [defines.events["on_forces_merging"]] = function(data, source_mod_name)
    local value
    value = data["source"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_forces_merging"},
        {"raise-event-protection.field-missing", "source", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_forces_merging", "source")
    value = data["destination"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_forces_merging"},
        {"raise-event-protection.field-missing", "destination", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_forces_merging", "destination")
  end,
  [defines.events["on_gui_checked_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_checked_state_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_checked_state_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_checked_state_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_checked_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_checked_state_changed[e_type] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_checked_state_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "{{expected_type}}", "{{expected_type}}"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_checked_state_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_click"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_click", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_click", "player_index")
    value = data["button"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "button", "defines.mouse_button_type"},
      }
    end
      f__defines__mouse_button_type(value, source_mod_name, "on_gui_click", "button")
    value = data["alt"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "alt", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_click", "alt")
    value = data["control"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "control", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_click", "control")
    value = data["shift"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
        {"raise-event-protection.field-missing", "shift", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_click", "shift")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_click"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_closed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_closed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_closed", "player_index")
    value = data["gui_type"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_closed"},
        {"raise-event-protection.field-missing", "gui_type", "defines.gui_type"},
      }
    end
      f__defines__gui_type(value, source_mod_name, "on_gui_closed", "gui_type")
    value = data["entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_gui_closed", "entity")
    end
    value = data["item"]
    if value then
      a__luaitemstack(value, source_mod_name, "on_gui_closed", "item")
    end
    value = data["equipment"]
    if value then
      a__luaequipment(value, source_mod_name, "on_gui_closed", "equipment")
    end
    value = data["other_player"]
    if value then
      a__luaplayer(value, source_mod_name, "on_gui_closed", "other_player")
    end
    value = data["element"]
    if value then
      a__luaguielement(value, source_mod_name, "on_gui_closed", "element")
    end
    value = data["technology"]
    if value then
      a__luatechnology(value, source_mod_name, "on_gui_closed", "technology")
    end
    value = data["tile_position"]
    if value then
      n__tileposition(value, source_mod_name, "on_gui_closed", "tile_position")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_closed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_confirmed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_confirmed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_confirmed", "player_index")
    value = data["alt"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
        {"raise-event-protection.field-missing", "alt", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "alt")
    value = data["control"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
        {"raise-event-protection.field-missing", "control", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "control")
    value = data["shift"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
        {"raise-event-protection.field-missing", "shift", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "shift")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "textfield" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
          {"raise-event-protection.field-with-wrong-type", "element", "textfield", "textfield"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_confirmed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_elem_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_elem_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_elem_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_elem_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_elem_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "choose-elem-button" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_elem_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "choose-elem-button", "choose-elem-button"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_elem_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_location_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_location_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_location_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_location_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_location_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "frame" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_location_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "frame", "frame"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_location_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_opened"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_opened"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_opened", "player_index")
    value = data["gui_type"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_opened"},
        {"raise-event-protection.field-missing", "gui_type", "defines.gui_type"},
      }
    end
      f__defines__gui_type(value, source_mod_name, "on_gui_opened", "gui_type")
    value = data["entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_gui_opened", "entity")
    end
    value = data["item"]
    if value then
      a__luaitemstack(value, source_mod_name, "on_gui_opened", "item")
    end
    value = data["equipment"]
    if value then
      a__luaequipment(value, source_mod_name, "on_gui_opened", "equipment")
    end
    value = data["other_player"]
    if value then
      a__luaplayer(value, source_mod_name, "on_gui_opened", "other_player")
    end
    value = data["element"]
    if value then
      a__luaguielement(value, source_mod_name, "on_gui_opened", "element")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_opened"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_selected_tab_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selected_tab_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_selected_tab_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selected_tab_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_selected_tab_changed", "player_index")
    local e = data["{{field_name_to_check}}"]
    local e_type
      e_type = e.type
      if e_type ~= "tabbed-pane" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selected_tab_changed"},
          {"raise-event-protection.field-with-wrong-type", "{{field_name_to_check}}", "tabbed-pane", "tabbed-pane"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selected_tab_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_selection_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selection_state_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_selection_state_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selection_state_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_selection_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_selection_state_changed[e_type] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selection_state_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "{{expected_type}}", "{{expected_type}}"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_selection_state_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_switch_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_switch_state_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_switch_state_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_switch_state_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_switch_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "switch" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_switch_state_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "switch", "switch"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_switch_state_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_text_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_text_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_text_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_text_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_text_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_text_changed[e_type] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_text_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "{{expected_type}}", "{{expected_type}}"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_text_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_gui_value_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_value_changed"},
        {"raise-event-protection.field-missing", "element", "LuaGuiElement"},
      }
    end
      a__luaguielement(value, source_mod_name, "on_gui_value_changed", "element")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_gui_value_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_gui_value_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "slider" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_gui_value_changed"},
          {"raise-event-protection.field-with-wrong-type", "element", "slider", "slider"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_gui_value_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_land_mine_armed"]] = function(data, source_mod_name)
    local value
    value = data["mine"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_land_mine_armed"},
        {"raise-event-protection.field-missing", "mine", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_land_mine_armed", "mine")
    local e = data["mine"]
    local e_type
      e_type = e.type
      if e_type ~= "land-mine" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_land_mine_armed"},
          {"raise-event-protection.field-with-wrong-type", "mine", "land-mine", "land-mine"},
        }
      end
  end,
  [defines.events["on_lua_shortcut"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_lua_shortcut"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_lua_shortcut", "player_index")
    value = data["prototype_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_lua_shortcut"},
        {"raise-event-protection.field-missing", "prototype_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_lua_shortcut", "prototype_name")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_lua_shortcut"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_marked_for_deconstruction"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_marked_for_deconstruction"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_marked_for_deconstruction", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_marked_for_deconstruction", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_marked_for_deconstruction"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_marked_for_upgrade"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_marked_for_upgrade"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_marked_for_upgrade", "entity")
    value = data["target"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_marked_for_upgrade"},
        {"raise-event-protection.field-missing", "target", "LuaEntityPrototype"},
      }
    end
      a__luaentityprototype(value, source_mod_name, "on_marked_for_upgrade", "target")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_marked_for_upgrade", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_marked_for_upgrade"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_market_item_purchased"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "player_index")
    value = data["market"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
        {"raise-event-protection.field-missing", "market", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_market_item_purchased", "market")
    value = data["offer_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
        {"raise-event-protection.field-missing", "offer_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "offer_index")
    value = data["count"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
        {"raise-event-protection.field-missing", "count", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "count")
    local e = data["market"]
    local e_type
      e_type = e.type
      if e_type ~= "market" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
          {"raise-event-protection.field-with-wrong-type", "market", "market", "market"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_market_item_purchased"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_mod_item_opened"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_mod_item_opened"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_mod_item_opened", "player_index")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_mod_item_opened"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_mod_item_opened", "item")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_mod_item_opened"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_picked_up_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_picked_up_item"},
        {"raise-event-protection.field-missing", "item_stack", "SimpleItemStack"},
      }
    end
      n__simpleitemstack(value, source_mod_name, "on_picked_up_item", "item_stack")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_picked_up_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_picked_up_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_picked_up_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_alt_selected_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_alt_selected_area", "player_index")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_player_alt_selected_area", "area")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
        {"raise-event-protection.field-missing", "item", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_alt_selected_area", "item")
    value = data["entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
        {"raise-event-protection.field-missing", "entities", "array of LuaEntity"},
      }
    end
      r__a__luaentity(value, source_mod_name, "on_player_alt_selected_area", "entities")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
        {"raise-event-protection.field-missing", "tiles", "array of LuaTile"},
      }
    end
      r__a__luatile(value, source_mod_name, "on_player_alt_selected_area", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_alt_selected_area"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_ammo_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_ammo_inventory_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_ammo_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_ammo_inventory_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_armor_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_armor_inventory_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_armor_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_armor_inventory_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_banned"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_player_banned", "player_index")
    end
    value = data["player_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_banned"},
        {"raise-event-protection.field-missing", "player_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_banned", "player_name")
    value = data["by_player"]
    if value then
      i__uint(value, source_mod_name, "on_player_banned", "by_player")
    end
    value = data["reason"]
    if value then
      i__string(value, source_mod_name, "on_player_banned", "reason")
    end
    value = data["by_player"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_banned"},
         {"raise-event-protection.field-with-invalid-value-simple", "by_player", "player index"},
        }
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_banned"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_player_built_tile"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_built_tile", "player_index")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_built_tile", "surface_index")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
        {"raise-event-protection.field-missing", "tiles", "array of OldTileAndPosition"},
      }
    end
      r__n__oldtileandposition(value, source_mod_name, "on_player_built_tile", "tiles")
    value = data["tile"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
        {"raise-event-protection.field-missing", "tile", "LuaTilePrototype"},
      }
    end
      a__luatileprototype(value, source_mod_name, "on_player_built_tile", "tile")
    value = data["item"]
    if value then
      a__luaitemprototype(value, source_mod_name, "on_player_built_tile", "item")
    end
    value = data["stack"]
    if value then
      a__luaitemstack(value, source_mod_name, "on_player_built_tile", "stack")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_built_tile"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_player_cancelled_crafting"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cancelled_crafting"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_cancelled_crafting", "player_index")
    value = data["items"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cancelled_crafting"},
        {"raise-event-protection.field-missing", "items", "LuaInventory"},
      }
    end
      a__luainventory(value, source_mod_name, "on_player_cancelled_crafting", "items")
    value = data["recipe"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cancelled_crafting"},
        {"raise-event-protection.field-missing", "recipe", "LuaRecipe"},
      }
    end
      a__luarecipe(value, source_mod_name, "on_player_cancelled_crafting", "recipe")
    value = data["cancel_count"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cancelled_crafting"},
        {"raise-event-protection.field-missing", "cancel_count", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_cancelled_crafting", "cancel_count")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_cancelled_crafting"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_changed_force"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_force"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_changed_force", "player_index")
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_force"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_player_changed_force", "force")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_force"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_changed_position"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_position"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_changed_position", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_position"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_changed_surface"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_surface"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_changed_surface", "player_index")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_surface"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_changed_surface", "surface_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_surface"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_changed_surface"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_player_cheat_mode_disabled"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cheat_mode_disabled"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_cheat_mode_disabled", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_cheat_mode_disabled"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_cheat_mode_enabled"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cheat_mode_enabled"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_cheat_mode_enabled", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_cheat_mode_enabled"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_configured_blueprint"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_configured_blueprint"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_configured_blueprint", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_configured_blueprint"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_crafted_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_crafted_item"},
        {"raise-event-protection.field-missing", "item_stack", "LuaItemStack"},
      }
    end
      a__luaitemstack(value, source_mod_name, "on_player_crafted_item", "item_stack")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_crafted_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_crafted_item", "player_index")
    value = data["recipe"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_crafted_item"},
        {"raise-event-protection.field-missing", "recipe", "LuaRecipe"},
      }
    end
      a__luarecipe(value, source_mod_name, "on_player_crafted_item", "recipe")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_crafted_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_created"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_created"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_created", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_created"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_cursor_stack_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_cursor_stack_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_cursor_stack_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_cursor_stack_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_deconstructed_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_deconstructed_area"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_deconstructed_area", "player_index")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_deconstructed_area"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_player_deconstructed_area", "area")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_deconstructed_area"},
        {"raise-event-protection.field-missing", "item", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_deconstructed_area", "item")
    value = data["alt"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_deconstructed_area"},
        {"raise-event-protection.field-missing", "alt", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_player_deconstructed_area", "alt")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_deconstructed_area"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_demoted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_demoted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_demoted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_demoted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_died"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_died"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_died", "player_index")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_player_died", "cause")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_died"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_display_resolution_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_resolution_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_display_resolution_changed", "player_index")
    value = data["old_resolution"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_resolution_changed"},
        {"raise-event-protection.field-missing", "old_resolution", "DisplayResolution"},
      }
    end
      n__displayresolution(value, source_mod_name, "on_player_display_resolution_changed", "old_resolution")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_resolution_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_display_scale_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_scale_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_display_scale_changed", "player_index")
    value = data["old_scale"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_scale_changed"},
        {"raise-event-protection.field-missing", "old_scale", "double"},
      }
    end
      i__double(value, source_mod_name, "on_player_display_scale_changed", "old_scale")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_display_scale_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_driving_changed_state"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_driving_changed_state"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_driving_changed_state", "player_index")
    value = data["entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_player_driving_changed_state", "entity")
    end
    local e = data["entity"]
    local e_type
    if e then
      e_type = e.type
      if e_type ~= "car" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_driving_changed_state"},
          {"raise-event-protection.field-with-wrong-type", "entity", "car", "car"},
        }
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_driving_changed_state"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_dropped_item"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_dropped_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_dropped_item", "player_index")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_dropped_item"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_player_dropped_item", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "item-entity" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_dropped_item"},
          {"raise-event-protection.field-with-wrong-type", "entity", "item-entity", "item-entity"},
        }
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_dropped_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_fast_transferred"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_fast_transferred"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_fast_transferred", "player_index")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_fast_transferred"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_player_fast_transferred", "entity")
    value = data["from_player"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_fast_transferred"},
        {"raise-event-protection.field-missing", "from_player", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_player_fast_transferred", "from_player")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_fast_transferred"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_gun_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_gun_inventory_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_gun_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_gun_inventory_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_joined_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_joined_game"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_joined_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_joined_game"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_kicked"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_kicked"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_kicked", "player_index")
    value = data["by_player"]
    if value then
      i__uint(value, source_mod_name, "on_player_kicked", "by_player")
    end
    value = data["reason"]
    if value then
      i__string(value, source_mod_name, "on_player_kicked", "reason")
    end
    value = data["by_player"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_kicked"},
         {"raise-event-protection.field-with-invalid-value-simple", "by_player", "player index"},
        }
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_kicked"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_left_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_left_game"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_left_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_left_game"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_main_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_main_inventory_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_main_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_main_inventory_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_mined_entity"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_entity"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_mined_entity", "player_index")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_entity"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_player_mined_entity", "entity")
    value = data["buffer"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_entity"},
        {"raise-event-protection.field-missing", "buffer", "LuaInventory"},
      }
    end
      a__luainventory(value, source_mod_name, "on_player_mined_entity", "buffer")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_entity"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_mined_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_item"},
        {"raise-event-protection.field-missing", "item_stack", "SimpleItemStack"},
      }
    end
      n__simpleitemstack(value, source_mod_name, "on_player_mined_item", "item_stack")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_mined_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_mined_tile"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_tile"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_mined_tile", "player_index")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_tile"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_mined_tile", "surface_index")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_tile"},
        {"raise-event-protection.field-missing", "tiles", "array of OldTileAndPosition"},
      }
    end
      r__n__oldtileandposition(value, source_mod_name, "on_player_mined_tile", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_tile"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_mined_tile"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_player_muted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_muted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_muted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_muted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_pipette"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_pipette"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_pipette", "player_index")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_pipette"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_player_pipette", "item")
    value = data["used_cheat_mode"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_pipette"},
        {"raise-event-protection.field-missing", "used_cheat_mode", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_player_pipette", "used_cheat_mode")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_pipette"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_placed_equipment"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_placed_equipment"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_placed_equipment", "player_index")
    value = data["equipment"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_placed_equipment"},
        {"raise-event-protection.field-missing", "equipment", "LuaEquipment"},
      }
    end
      a__luaequipment(value, source_mod_name, "on_player_placed_equipment", "equipment")
    value = data["grid"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_placed_equipment"},
        {"raise-event-protection.field-missing", "grid", "LuaEquipmentGrid"},
      }
    end
      a__luaequipmentgrid(value, source_mod_name, "on_player_placed_equipment", "grid")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_placed_equipment"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_promoted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_promoted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_promoted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_promoted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_removed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_removed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_removed_equipment"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed_equipment"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_removed_equipment", "player_index")
    value = data["grid"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed_equipment"},
        {"raise-event-protection.field-missing", "grid", "LuaEquipmentGrid"},
      }
    end
      a__luaequipmentgrid(value, source_mod_name, "on_player_removed_equipment", "grid")
    value = data["equipment"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed_equipment"},
        {"raise-event-protection.field-missing", "equipment", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_removed_equipment", "equipment")
    value = data["count"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed_equipment"},
        {"raise-event-protection.field-missing", "count", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_removed_equipment", "count")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_removed_equipment"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_repaired_entity"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_repaired_entity"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_repaired_entity", "player_index")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_repaired_entity"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_player_repaired_entity", "entity")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_repaired_entity"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_respawned"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_respawned"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_respawned", "player_index")
    value = data["player_port"]
    if value then
      a__luaentity(value, source_mod_name, "on_player_respawned", "player_port")
    end
    local e = data["player_port"]
    local e_type
    if e then
      e_type = e.type
      if e_type ~= "player-port" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_player_respawned"},
          {"raise-event-protection.field-with-wrong-type", "player_port", "player-port", "player-port"},
        }
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_respawned"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_rotated_entity"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_rotated_entity"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_player_rotated_entity", "entity")
    value = data["previous_direction"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_rotated_entity"},
        {"raise-event-protection.field-missing", "previous_direction", "defines.direction"},
      }
    end
      f__defines__direction(value, source_mod_name, "on_player_rotated_entity", "previous_direction")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_rotated_entity"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_rotated_entity", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_rotated_entity"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_selected_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_selected_area", "player_index")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_player_selected_area", "area")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
        {"raise-event-protection.field-missing", "item", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_selected_area", "item")
    value = data["entities"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
        {"raise-event-protection.field-missing", "entities", "array of LuaEntity"},
      }
    end
      r__a__luaentity(value, source_mod_name, "on_player_selected_area", "entities")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
        {"raise-event-protection.field-missing", "tiles", "array of LuaTile"},
      }
    end
      r__a__luatile(value, source_mod_name, "on_player_selected_area", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_selected_area"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_setup_blueprint"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_setup_blueprint", "player_index")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_player_setup_blueprint", "area")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
        {"raise-event-protection.field-missing", "item", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_setup_blueprint", "item")
    value = data["alt"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
        {"raise-event-protection.field-missing", "alt", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_player_setup_blueprint", "alt")
    value = data["mapping"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
        {"raise-event-protection.field-missing", "mapping", "LuaLazyLoadedValue (dictionary uint -> LuaEntity)"},
      }
    end
      z__c__k__i__uint__v__a__luaentity(value, source_mod_name, "on_player_setup_blueprint", "mapping")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_setup_blueprint"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_toggled_alt_mode"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_toggled_alt_mode"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_toggled_alt_mode", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_toggled_alt_mode"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_toggled_map_editor"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_toggled_map_editor"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_toggled_map_editor", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_toggled_map_editor"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_trash_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_trash_inventory_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_trash_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_trash_inventory_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_unbanned"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_player_unbanned", "player_index")
    end
    value = data["player_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_unbanned"},
        {"raise-event-protection.field-missing", "player_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_player_unbanned", "player_name")
    value = data["by_player"]
    if value then
      i__uint(value, source_mod_name, "on_player_unbanned", "by_player")
    end
    value = data["reason"]
    if value then
      i__string(value, source_mod_name, "on_player_unbanned", "reason")
    end
    value = data["by_player"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_unbanned"},
         {"raise-event-protection.field-with-invalid-value-simple", "by_player", "player index"},
        }
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_unbanned"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_player_unmuted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_unmuted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_unmuted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_unmuted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_player_used_capsule"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_used_capsule"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_player_used_capsule", "player_index")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_used_capsule"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_player_used_capsule", "item")
    value = data["position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_player_used_capsule"},
        {"raise-event-protection.field-missing", "position", "Position"},
      }
    end
      n__position(value, source_mod_name, "on_player_used_capsule", "position")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_player_used_capsule"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_post_entity_died"]] = function(data, source_mod_name)
    local value
    value = data["ghost"]
    if value then
      a__luaentity(value, source_mod_name, "on_post_entity_died", "ghost")
    end
    value = data["force"]
    if value then
      a__luaforce(value, source_mod_name, "on_post_entity_died", "force")
    end
    value = data["position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_post_entity_died"},
        {"raise-event-protection.field-missing", "position", "Position"},
      }
    end
      n__position(value, source_mod_name, "on_post_entity_died", "position")
    value = data["prototype"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_post_entity_died"},
        {"raise-event-protection.field-missing", "prototype", "LuaEntityPrototype"},
      }
    end
      a__luaentityprototype(value, source_mod_name, "on_post_entity_died", "prototype")
    value = data["corpses"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_post_entity_died"},
        {"raise-event-protection.field-missing", "corpses", "array of LuaEntity"},
      }
    end
      r__a__luaentity(value, source_mod_name, "on_post_entity_died", "corpses")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_post_entity_died"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_post_entity_died", "surface_index")
    value = data["unit_number"]
    if value then
      i__uint(value, source_mod_name, "on_post_entity_died", "unit_number")
    end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_post_entity_died"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
    local e = data["prototype"]
    return e, e.type
  end,
  [defines.events["on_pre_chunk_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_chunk_deleted"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_chunk_deleted", "surface_index")
    value = data["positions"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_chunk_deleted"},
        {"raise-event-protection.field-missing", "positions", "array of ChunkPosition"},
      }
    end
      r__n__chunkposition(value, source_mod_name, "on_pre_chunk_deleted", "positions")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_chunk_deleted"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_pre_entity_settings_pasted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_entity_settings_pasted", "player_index")
    value = data["source"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "source", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_entity_settings_pasted", "source")
    value = data["destination"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_entity_settings_pasted"},
        {"raise-event-protection.field-missing", "destination", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_entity_settings_pasted", "destination")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_entity_settings_pasted"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_pre_ghost_deconstructed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_pre_ghost_deconstructed", "player_index")
    end
    value = data["ghost"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_ghost_deconstructed"},
        {"raise-event-protection.field-missing", "ghost", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_ghost_deconstructed", "ghost")
    local e = data["ghost"]
    local e_type
      e_type = e.type
      if not types_for_on_pre_ghost_deconstructed[e_type] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_ghost_deconstructed"},
          {"raise-event-protection.field-with-wrong-type", "ghost", "{{expected_type}}", "{{expected_type}}"},
        }
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_ghost_deconstructed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
    return e, e_type
  end,
  [defines.events["on_pre_player_crafted_item"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_crafted_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_player_crafted_item", "player_index")
    value = data["recipe"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_crafted_item"},
        {"raise-event-protection.field-missing", "recipe", "LuaRecipe"},
      }
    end
      a__luarecipe(value, source_mod_name, "on_pre_player_crafted_item", "recipe")
    value = data["items"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_crafted_item"},
        {"raise-event-protection.field-missing", "items", "LuaInventory"},
      }
    end
      a__luainventory(value, source_mod_name, "on_pre_player_crafted_item", "items")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_crafted_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_pre_player_died"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_died"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_player_died", "player_index")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_pre_player_died", "cause")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_died"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_pre_player_left_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_left_game"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_player_left_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_left_game"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_pre_player_mined_item"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_mined_item"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_player_mined_item", "entity")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_mined_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_player_mined_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_mined_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_pre_player_removed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_removed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_player_removed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_pre_player_removed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_pre_robot_exploded_cliff"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_robot_exploded_cliff"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_robot_exploded_cliff", "robot")
    value = data["cliff"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_robot_exploded_cliff"},
        {"raise-event-protection.field-missing", "cliff", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_pre_robot_exploded_cliff", "cliff")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_robot_exploded_cliff"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_pre_robot_exploded_cliff", "item")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_robot_exploded_cliff"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
    local e = data["cliff"]
    local e_type
      e_type = e.type
      if e_type ~= "cliff" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_robot_exploded_cliff"},
          {"raise-event-protection.field-with-wrong-type", "cliff", "cliff", "cliff"},
        }
      end
  end,
  [defines.events["on_pre_surface_cleared"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_surface_cleared"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_surface_cleared", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_surface_cleared"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_pre_surface_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_pre_surface_deleted"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_pre_surface_deleted", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_pre_surface_deleted"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_put_item"]] = function(data, source_mod_name)
    local value
    value = data["position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
        {"raise-event-protection.field-missing", "position", "Position"},
      }
    end
      n__position(value, source_mod_name, "on_put_item", "position")
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_put_item", "player_index")
    value = data["shift_build"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
        {"raise-event-protection.field-missing", "shift_build", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_put_item", "shift_build")
    value = data["built_by_moving"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
        {"raise-event-protection.field-missing", "built_by_moving", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_put_item", "built_by_moving")
    value = data["direction"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
        {"raise-event-protection.field-missing", "direction", "defines.direction"},
      }
    end
      f__defines__direction(value, source_mod_name, "on_put_item", "direction")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_put_item"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_research_finished"]] = function(data, source_mod_name)
    local value
    value = data["research"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_research_finished"},
        {"raise-event-protection.field-missing", "research", "LuaTechnology"},
      }
    end
      a__luatechnology(value, source_mod_name, "on_research_finished", "research")
    value = data["by_script"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_research_finished"},
        {"raise-event-protection.field-missing", "by_script", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_research_finished", "by_script")
  end,
  [defines.events["on_research_started"]] = function(data, source_mod_name)
    local value
    value = data["research"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_research_started"},
        {"raise-event-protection.field-missing", "research", "LuaTechnology"},
      }
    end
      a__luatechnology(value, source_mod_name, "on_research_started", "research")
    value = data["last_research"]
    if value then
      a__luatechnology(value, source_mod_name, "on_research_started", "last_research")
    end
  end,
  [defines.events["on_resource_depleted"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_resource_depleted"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_resource_depleted", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "resource" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_resource_depleted"},
          {"raise-event-protection.field-with-wrong-type", "entity", "resource", "resource"},
        }
      end
  end,
  [defines.events["on_robot_built_entity"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_entity"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_built_entity", "robot")
    value = data["created_entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_entity"},
        {"raise-event-protection.field-missing", "created_entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_built_entity", "created_entity")
    value = data["stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_entity"},
        {"raise-event-protection.field-missing", "stack", "LuaItemStack"},
      }
    end
      a__luaitemstack(value, source_mod_name, "on_robot_built_entity", "stack")
    value = data["tags"]
    if value then
      n__tags(value, source_mod_name, "on_robot_built_entity", "tags")
    end
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_entity"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
    local e = data["created_entity"]
    return e, e.type
  end,
  [defines.events["on_robot_built_tile"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_built_tile", "robot")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "tiles", "array of OldTileAndPosition"},
      }
    end
      r__n__oldtileandposition(value, source_mod_name, "on_robot_built_tile", "tiles")
    value = data["tile"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "tile", "LuaTilePrototype"},
      }
    end
      a__luatileprototype(value, source_mod_name, "on_robot_built_tile", "tile")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_robot_built_tile", "item")
    value = data["stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "stack", "LuaItemStack"},
      }
    end
      a__luaitemstack(value, source_mod_name, "on_robot_built_tile", "stack")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_robot_built_tile", "surface_index")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_built_tile"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_robot_exploded_cliff"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_exploded_cliff"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_exploded_cliff", "robot")
    value = data["item"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_exploded_cliff"},
        {"raise-event-protection.field-missing", "item", "LuaItemPrototype"},
      }
    end
      a__luaitemprototype(value, source_mod_name, "on_robot_exploded_cliff", "item")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_exploded_cliff"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
  end,
  [defines.events["on_robot_mined"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_mined", "robot")
    value = data["item_stack"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined"},
        {"raise-event-protection.field-missing", "item_stack", "SimpleItemStack"},
      }
    end
      n__simpleitemstack(value, source_mod_name, "on_robot_mined", "item_stack")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
  end,
  [defines.events["on_robot_mined_entity"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_entity"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_entity", "robot")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_entity"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_entity", "entity")
    value = data["buffer"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_entity"},
        {"raise-event-protection.field-missing", "buffer", "LuaInventory"},
      }
    end
      a__luainventory(value, source_mod_name, "on_robot_mined_entity", "buffer")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_entity"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
  end,
  [defines.events["on_robot_mined_tile"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_tile"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_tile", "robot")
    value = data["tiles"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_tile"},
        {"raise-event-protection.field-missing", "tiles", "array of OldTileAndPosition"},
      }
    end
      r__n__oldtileandposition(value, source_mod_name, "on_robot_mined_tile", "tiles")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_tile"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_robot_mined_tile", "surface_index")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_tile"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_mined_tile"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_robot_pre_mined"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_pre_mined"},
        {"raise-event-protection.field-missing", "robot", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_pre_mined", "robot")
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_robot_pre_mined"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_robot_pre_mined", "entity")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_robot_pre_mined"},
          {"raise-event-protection.field-with-wrong-type", "robot", "construction-robot", "construction-robot"},
        }
      end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_rocket_launch_ordered"]] = function(data, source_mod_name)
    local value
    value = data["rocket"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launch_ordered"},
        {"raise-event-protection.field-missing", "rocket", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_rocket_launch_ordered", "rocket")
    value = data["rocket_silo"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launch_ordered"},
        {"raise-event-protection.field-missing", "rocket_silo", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_rocket_launch_ordered", "rocket_silo")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_rocket_launch_ordered", "player_index")
    end
    local e = data["rocket"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo-rocket" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launch_ordered"},
          {"raise-event-protection.field-with-wrong-type", "rocket", "rocket-silo-rocket", "rocket-silo-rocket"},
        }
      end
    local e = data["rocket_silo"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launch_ordered"},
          {"raise-event-protection.field-with-wrong-type", "rocket_silo", "rocket-silo", "rocket-silo"},
        }
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launch_ordered"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_rocket_launched"]] = function(data, source_mod_name)
    local value
    value = data["rocket"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launched"},
        {"raise-event-protection.field-missing", "rocket", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_rocket_launched", "rocket")
    value = data["rocket_silo"]
    if value then
      a__luaentity(value, source_mod_name, "on_rocket_launched", "rocket_silo")
    end
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_rocket_launched", "player_index")
    end
    local e = data["rocket"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo-rocket" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launched"},
          {"raise-event-protection.field-with-wrong-type", "rocket", "rocket-silo-rocket", "rocket-silo-rocket"},
        }
      end
    local e = data["rocket_silo"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launched"},
          {"raise-event-protection.field-with-wrong-type", "rocket_silo", "rocket-silo", "rocket-silo"},
        }
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_rocket_launched"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_runtime_mod_setting_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_runtime_mod_setting_changed", "player_index")
    end
    value = data["setting"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_runtime_mod_setting_changed"},
        {"raise-event-protection.field-missing", "setting", "string"},
      }
    end
      i__string(value, source_mod_name, "on_runtime_mod_setting_changed", "setting")
    value = data["setting_type"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_runtime_mod_setting_changed"},
        {"raise-event-protection.field-missing", "setting_type", "string"},
      }
    end
      i__string(value, source_mod_name, "on_runtime_mod_setting_changed", "setting_type")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_runtime_mod_setting_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_script_path_request_finished"]] = function(data, source_mod_name)
    local value
    value = data["path"]
    if value then
      r__n__waypoint(value, source_mod_name, "on_script_path_request_finished", "path")
    end
    value = data["id"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_script_path_request_finished"},
        {"raise-event-protection.field-missing", "id", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_script_path_request_finished", "id")
    value = data["try_again_later"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_script_path_request_finished"},
        {"raise-event-protection.field-missing", "try_again_later", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_script_path_request_finished", "try_again_later")
  end,
  [defines.events["on_script_trigger_effect"]] = function(data, source_mod_name)
    local value
    value = data["effect_id"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_script_trigger_effect"},
        {"raise-event-protection.field-missing", "effect_id", "string"},
      }
    end
      i__string(value, source_mod_name, "on_script_trigger_effect", "effect_id")
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_script_trigger_effect"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_script_trigger_effect", "surface_index")
    value = data["source_position"]
    if value then
      n__position(value, source_mod_name, "on_script_trigger_effect", "source_position")
    end
    value = data["source_entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_script_trigger_effect", "source_entity")
    end
    value = data["target_position"]
    if value then
      n__position(value, source_mod_name, "on_script_trigger_effect", "target_position")
    end
    value = data["target_entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_script_trigger_effect", "target_entity")
    end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_script_trigger_effect"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_sector_scanned"]] = function(data, source_mod_name)
    local value
    value = data["radar"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_sector_scanned"},
        {"raise-event-protection.field-missing", "radar", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_sector_scanned", "radar")
    value = data["chunk_position"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_sector_scanned"},
        {"raise-event-protection.field-missing", "chunk_position", "ChunkPosition"},
      }
    end
      n__chunkposition(value, source_mod_name, "on_sector_scanned", "chunk_position")
    value = data["area"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_sector_scanned"},
        {"raise-event-protection.field-missing", "area", "BoundingBox"},
      }
    end
      n__boundingbox(value, source_mod_name, "on_sector_scanned", "area")
    local e = data["radar"]
    local e_type
      e_type = e.type
      if e_type ~= "radar" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_sector_scanned"},
          {"raise-event-protection.field-with-wrong-type", "radar", "radar", "radar"},
        }
      end
  end,
  [defines.events["on_selected_entity_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_selected_entity_changed"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_selected_entity_changed", "player_index")
    value = data["last_entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_selected_entity_changed", "last_entity")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_selected_entity_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_string_translated"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_string_translated"},
        {"raise-event-protection.field-missing", "player_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_string_translated", "player_index")
    value = data["localised_string"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_string_translated"},
        {"raise-event-protection.field-missing", "localised_string", "LocalisedString"},
      }
    end
      n__localisedstring(value, source_mod_name, "on_string_translated", "localised_string")
    value = data["result"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_string_translated"},
        {"raise-event-protection.field-missing", "result", "string"},
      }
    end
      i__string(value, source_mod_name, "on_string_translated", "result")
    value = data["translated"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_string_translated"},
        {"raise-event-protection.field-missing", "translated", "boolean"},
      }
    end
      i__boolean(value, source_mod_name, "on_string_translated", "translated")
    value = data["player_index"]
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_string_translated"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
  end,
  [defines.events["on_surface_cleared"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_cleared"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_surface_cleared", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_surface_cleared"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_surface_created"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_created"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_surface_created", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_surface_created"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_surface_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_deleted"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_surface_deleted", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_surface_deleted"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_surface_imported"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_imported"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_surface_imported", "surface_index")
    value = data["original_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_imported"},
        {"raise-event-protection.field-missing", "original_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_surface_imported", "original_name")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_surface_imported"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_surface_renamed"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_renamed"},
        {"raise-event-protection.field-missing", "surface_index", "uint"},
      }
    end
      i__uint(value, source_mod_name, "on_surface_renamed", "surface_index")
    value = data["old_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_renamed"},
        {"raise-event-protection.field-missing", "old_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_surface_renamed", "old_name")
    value = data["new_name"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_surface_renamed"},
        {"raise-event-protection.field-missing", "new_name", "string"},
      }
    end
      i__string(value, source_mod_name, "on_surface_renamed", "new_name")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_surface_renamed"},
          {"raise-event-protection.field-with-invalid-value-simple", "surface_index", "surface index"},
        }
      end
  end,
  [defines.events["on_technology_effects_reset"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_technology_effects_reset"},
        {"raise-event-protection.field-missing", "force", "LuaForce"},
      }
    end
      a__luaforce(value, source_mod_name, "on_technology_effects_reset", "force")
  end,
  [defines.events["on_train_changed_state"]] = function(data, source_mod_name)
    local value
    value = data["train"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_train_changed_state"},
        {"raise-event-protection.field-missing", "train", "LuaTrain"},
      }
    end
      a__luatrain(value, source_mod_name, "on_train_changed_state", "train")
    value = data["old_state"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_train_changed_state"},
        {"raise-event-protection.field-missing", "old_state", "defines.train_state"},
      }
    end
      f__defines__train_state(value, source_mod_name, "on_train_changed_state", "old_state")
  end,
  [defines.events["on_train_created"]] = function(data, source_mod_name)
    local value
    value = data["train"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_train_created"},
        {"raise-event-protection.field-missing", "train", "LuaTrain"},
      }
    end
      a__luatrain(value, source_mod_name, "on_train_created", "train")
    value = data["old_train_id_1"]
    if value then
      i__uint(value, source_mod_name, "on_train_created", "old_train_id_1")
    end
    value = data["old_train_id_2"]
    if value then
      i__uint(value, source_mod_name, "on_train_created", "old_train_id_2")
    end
  end,
  [defines.events["on_train_schedule_changed"]] = function(data, source_mod_name)
    local value
    value = data["train"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_train_schedule_changed"},
        {"raise-event-protection.field-missing", "train", "LuaTrain"},
      }
    end
      a__luatrain(value, source_mod_name, "on_train_schedule_changed", "train")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_train_schedule_changed", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error{"",
         {"raise-event-protection.error-prefix", source_mod_name, "on_train_schedule_changed"},
         {"raise-event-protection.field-with-invalid-value-simple", "player_index", "player index"},
        }
      end
    end
  end,
  [defines.events["on_trigger_created_entity"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_trigger_created_entity"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_trigger_created_entity", "entity")
    value = data["source"]
    if value then
      a__luaentity(value, source_mod_name, "on_trigger_created_entity", "source")
    end
  end,
  [defines.events["on_trigger_fired_artillery"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_trigger_fired_artillery"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_trigger_fired_artillery", "entity")
    value = data["source"]
    if value then
      a__luaentity(value, source_mod_name, "on_trigger_fired_artillery", "source")
    end
  end,
  [defines.events["on_unit_added_to_group"]] = function(data, source_mod_name)
    local value
    value = data["unit"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_added_to_group"},
        {"raise-event-protection.field-missing", "unit", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_unit_added_to_group", "unit")
    value = data["group"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_added_to_group"},
        {"raise-event-protection.field-missing", "group", "LuaUnitGroup"},
      }
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_added_to_group", "group")
    local e = data["unit"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_unit_added_to_group"},
          {"raise-event-protection.field-with-wrong-type", "unit", "unit", "unit"},
        }
      end
  end,
  [defines.events["on_unit_group_created"]] = function(data, source_mod_name)
    local value
    value = data["group"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_group_created"},
        {"raise-event-protection.field-missing", "group", "LuaUnitGroup"},
      }
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_group_created", "group")
  end,
  [defines.events["on_unit_group_finished_gathering"]] = function(data, source_mod_name)
    local value
    value = data["group"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_group_finished_gathering"},
        {"raise-event-protection.field-missing", "group", "LuaUnitGroup"},
      }
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_group_finished_gathering", "group")
  end,
  [defines.events["on_unit_removed_from_group"]] = function(data, source_mod_name)
    local value
    value = data["unit"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_removed_from_group"},
        {"raise-event-protection.field-missing", "unit", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "on_unit_removed_from_group", "unit")
    value = data["group"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "on_unit_removed_from_group"},
        {"raise-event-protection.field-missing", "group", "LuaUnitGroup"},
      }
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_removed_from_group", "group")
    local e = data["unit"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error{"",
          {"raise-event-protection.error-prefix", source_mod_name, "on_unit_removed_from_group"},
          {"raise-event-protection.field-with-wrong-type", "unit", "unit", "unit"},
        }
      end
  end,
  [defines.events["script_raised_built"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "script_raised_built"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "script_raised_built", "entity")
  end,
  [defines.events["script_raised_destroy"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "script_raised_destroy"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "script_raised_destroy", "entity")
  end,
  [defines.events["script_raised_revive"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error{"",
        {"raise-event-protection.error-prefix", source_mod_name, "script_raised_revive"},
        {"raise-event-protection.field-missing", "entity", "LuaEntity"},
      }
    end
      a__luaentity(value, source_mod_name, "script_raised_revive", "entity")
    value = data["tags"]
    if value then
      n__tags(value, source_mod_name, "script_raised_revive", "tags")
    end
  end,
}
