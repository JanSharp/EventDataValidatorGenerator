
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

local required_field_missing = "%s raised the event '%s' without the '%s' (must be %s) field."
local required_concept_field_missing = "%s raised the event '%s' the '%s' (must be %s) field without the nested field '%s' (must be %s)."
local field_with_wrong_type = "%s raised the event '%s' with the '%s' field with the wrong type (%s instead of %s)."
local builtin_value_out_of_range = "%s raised the event '%s' with the '%s' field (must be %s) with a value out of range (%s to %s)."
local builtin_value_non_integer = "%s raised the event '%s' with the '%s' field (must be %s) with a non integer value."
local define_field_with_wrong_type = "%s raised the event '%s' with the '%s' field with the wrong type (%s instead of %s (which are numbers))."
local define_field_with_wrong_value = "%s raised the event '%s' with the '%s' field with the wrong define value (must be any %s)."
local array_with_non_numerical_keys = "%s raised the event '%s' with the '%s' field (must be %s) with at least one non numerical key."
local array_with_gaps = "%s raised the event '%s' with the '%s' field (must be %s) with gap(s) in the keys."

-- predefine all locals so that the upvalues link correctly (generated)
--<type_validator>
--[[!local {{type_id}}]] --[[!]]
--</type_validator>

-- hardcoded concepts (and 'Waypoint')
local function n__position(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "Position", "x", "double"))
  end
  --[[!i__double]]_--[[!]](value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "Position", "y", "double"))
  end
  --[[!i__double]]_--[[!]](value, source_mod_name, event_name, field_name)
end

local function n__chunkposition(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "ChunkPosition", "x", "int"))
  end
  --[[!i__int]]_--[[!]](value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "ChunkPosition", "y", "int"))
  end
  --[[!i__int]]_--[[!]](value, source_mod_name, event_name, field_name)
end

local function n__tileposition(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "TilePosition", "x", "int"))
  end
  --[[!i__int]]_--[[!]](value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "TilePosition", "y", "int"))
  end
  --[[!i__int]]_--[[!]](value, source_mod_name, event_name, field_name)
end

local function n__boundingbox()

end
local function n__simpleitemstack()

end
local function n__oldtileandposition()

end
local function n__tags()

end
local function n__displayresolution()

end
local function n__localisedstring()

end
local function n__signalid()

end
local function n__waypoint()

end


-- from here on everything is generated
--<type_validator>
function --[[!{{type_id}}]] _ --[[!]](value, source_mod_name, event_name, field_name)
  --[[!]] local value_type --[[just so that there are no warnings about redefined locals]] --[[!]]

  --<lazy>
  --[[!{{lazy_type_id}}]] _ --[[!]](value.get(), source_mod_name, event_name, field_name)
  --</lazy>

  --<array>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "{{type_name}}"))
  end
  local array_length = #value
  for _ in next, value, array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "{{type_name}}"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "{{type_name}}"))
  end
  for _, v in ipairs(value) do
    --[[!{{array_elem_type_id}}]] _ --[[!]](v, source_mod_name, event_name, field_name)
  end
  --</array>


  --<dictionary>
  -- todo: impl
  --</dictionary>


  --<builtin_or_luaobj>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "{{type_string}}" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "{{type_name}}"))
  end

  --<min_check>
  if value < --[[!{{min_value}}]] 0 --[[!]] then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "{{type_name}}", tostring(--[[!{{min_value}}]] 0 --[[!]]), tostring(--[[!{{max_value}}]] 0 --[[!]])))
  end
  --</min_check>

  --<max_check>
  if value > --[[!{{max_value}}]] 0 --[[!]] then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "{{type_name}}", tostring(--[[!{{min_value}}]] 0 --[[!]]), tostring(--[[!{{max_value}}]] 0 --[[!]])))
  end
  --</max_check>

  --<integer_check>
  if value % 1 ~= 0 then
    error(string.format(builtin_value_non_integer, source_mod_name, event_name, field_name, "{{type_name}}"))
  end
  --</integer_check>

  --</builtin_or_luaobj>


  --<defines>
  --[[!local]] --[[!]] value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "{{type_name}}"))
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    --<check>
    value == --[[!{{define_name}}]] nil --[[!]] or
    --</check>
    false)
  then
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "{{type_name}}"))
  end
  --</defines>
end
--</type_validator>



-- event data validators

return {
  --<event_validator>
  [defines.events["{{event_name}}"]] = function(data, source_mod_name)
    local value
    --<field>
    value = data["{{field_name}}"]

    --<required>
    if not value then
      error(string.format(required_field_missing, source_mod_name, "{{event_name}}", "{{field_name}}", "{{field_type_name}}"))
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

  end,
  --</event_validator>
}
