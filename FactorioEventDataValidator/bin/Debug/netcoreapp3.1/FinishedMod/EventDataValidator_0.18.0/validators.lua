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
local invalid_player_index = "%s raised the event '%s' with an invalid player index (%s) in the field '%s'."
local invalid_surface_index = "%s raised the event '%s' with an invalid surface index (%s) in the field '%s'."
-- predefine all locals so that the upvalues link correctly (generated)
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
-- hardcoded concepts (and 'Waypoint')
local function n__position(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "Position", "x", "double"))
  end
  i__double(value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "Position", "y", "double"))
  end
  i__double(value, source_mod_name, event_name, field_name)
end
local function n__chunkposition(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "ChunkPosition", "x", "int"))
  end
  i__int(value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "ChunkPosition", "y", "int"))
  end
  i__int(value, source_mod_name, event_name, field_name)
end
local function n__tileposition(data, source_mod_name, event_name, field_name)
  local value
  value = data["x"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "TilePosition", "x", "int"))
  end
  i__int(value, source_mod_name, event_name, field_name)
  value = data["y"]
  if not value then
    error(string.format(required_concept_field_missing, source_mod_name, event_name, field_name, "TilePosition", "y", "int"))
  end
  i__int(value, source_mod_name, event_name, field_name)
end
local function n__boundingbox(data, source_mod_name, event_name, field_name)
end
local function n__simpleitemstack(data, source_mod_name, event_name, field_name)
end
local function n__oldtileandposition(data, source_mod_name, event_name, field_name)
end
local function n__tags(data, source_mod_name, event_name, field_name)
end
local function n__displayresolution(data, source_mod_name, event_name, field_name)
end
local function n__localisedstring(data, source_mod_name, event_name, field_name)
end
local function n__signalid(data, source_mod_name, event_name, field_name)
end
local function n__waypoint(data, source_mod_name, event_name, field_name)
end
-- from here on everything is generated
-- type validators
function i__uint(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "uint"))
  end
  if value < 0 then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "uint", "0", "4294967295"))
  end
  if value > 4294967295 then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "uint", "0", "4294967295"))
  end
  if value % 1 ~= 0 then
    error(string.format(builtin_value_non_integer, source_mod_name, event_name, field_name, "uint"))
  end
end
function f__defines__behavior_result(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "defines.behavior_result"))
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.behavior_result.in_progress or
    value == defines.behavior_result.fail or
    value == defines.behavior_result.success or
    value == defines.behavior_result.deleted or
    false)
  then
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "defines.behavior_result"))
  end
end
function a__luasurface(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaSurface" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaSurface"))
  end
end
function a__luaforce(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaForce" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaForce"))
  end
end
function i__boolean(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "boolean" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "boolean"))
  end
end
function a__luaentity(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEntity" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaEntity"))
  end
end
function r__n__tileposition(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of TilePosition"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of TilePosition"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of TilePosition"))
  end
  for _, v in ipairs(value) do
    n__tileposition(v, source_mod_name, event_name, field_name)
  end
end
function a__luaunitgroup(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaUnitGroup" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaUnitGroup"))
  end
end
function a__luaitemstack(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaItemStack" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaItemStack"))
  end
end
function a__luaitemprototype(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaItemPrototype" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaItemPrototype"))
  end
end
function a__luacustomcharttag(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaCustomChartTag" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaCustomChartTag"))
  end
end
function i__string(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "string" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "string"))
  end
end
function r__n__chunkposition(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of ChunkPosition"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of ChunkPosition"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of ChunkPosition"))
  end
  for _, v in ipairs(value) do
    n__chunkposition(v, source_mod_name, event_name, field_name)
  end
end
function a__luadamageprototype(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaDamagePrototype" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaDamagePrototype"))
  end
end
function i__float(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "float"))
  end
end
function a__luainventory(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaInventory" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaInventory"))
  end
end
function a__luaguielement(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaGuiElement" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaGuiElement"))
  end
end
function f__defines__mouse_button_type(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "defines.mouse_button_type"))
  end
  if not (
    -- todo: this can very most likely use range checks instead. maybe i'll do that, quite a bit of effort tho if i want it to be fully generic and reliable. not sure
    value == defines.mouse_button_type.none or
    value == defines.mouse_button_type.left or
    value == defines.mouse_button_type.right or
    value == defines.mouse_button_type.middle or
    false)
  then
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "defines.mouse_button_type"))
  end
end
function f__defines__gui_type(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "defines.gui_type"))
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
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "defines.gui_type"))
  end
end
function a__luaequipment(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEquipment" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaEquipment"))
  end
end
function a__luaplayer(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaPlayer" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaPlayer"))
  end
end
function a__luatechnology(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTechnology" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaTechnology"))
  end
end
function a__luaentityprototype(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEntityPrototype" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaEntityPrototype"))
  end
end
function r__a__luaentity(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of LuaEntity"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of LuaEntity"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of LuaEntity"))
  end
  for _, v in ipairs(value) do
    a__luaentity(v, source_mod_name, event_name, field_name)
  end
end
function r__a__luatile(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of LuaTile"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of LuaTile"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of LuaTile"))
  end
  for _, v in ipairs(value) do
    a__luatile(v, source_mod_name, event_name, field_name)
  end
end
function a__luatile(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTile" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaTile"))
  end
end
function r__n__oldtileandposition(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of OldTileAndPosition"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of OldTileAndPosition"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of OldTileAndPosition"))
  end
  for _, v in ipairs(value) do
    n__oldtileandposition(v, source_mod_name, event_name, field_name)
  end
end
function a__luatileprototype(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTilePrototype" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaTilePrototype"))
  end
end
function a__luarecipe(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaRecipe" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaRecipe"))
  end
end
function i__double(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "double"))
  end
end
function a__luaequipmentgrid(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaEquipmentGrid" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaEquipmentGrid"))
  end
end
function f__defines__direction(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "defines.direction"))
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
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "defines.direction"))
  end
end
function z__c__k__i__uint__v__a__luaentity(value, source_mod_name, event_name, field_name)
  c__k__i__uint__v__a__luaentity(value.get(), source_mod_name, event_name, field_name)
end
function c__k__i__uint__v__a__luaentity(value, source_mod_name, event_name, field_name)
  -- todo: impl
end
function r__n__waypoint(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "table" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "array of Waypoint"))
  end
  local array_length = #value
  for _ in next, value, array_length ~= 0 and array_length do
    error(string.format(array_with_non_numerical_keys, source_mod_name, event_name, field_name, "array of Waypoint"))
  end
  if array_length ~= table_size(value) then
    error(string.format(array_with_gaps, source_mod_name, event_name, field_name, "array of Waypoint"))
  end
  for _, v in ipairs(value) do
    n__waypoint(v, source_mod_name, event_name, field_name)
  end
end
function a__luatrain(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "LuaTrain" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "LuaTrain"))
  end
end
function f__defines__train_state(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(define_field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "defines.train_state"))
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
    error(string.format(define_field_with_wrong_value, source_mod_name, event_name, field_name, "defines.train_state"))
  end
end
function i__int(value, source_mod_name, event_name, field_name)
  local value_type = advanced_type(value)
  if value_type ~= "number" then
    error(string.format(field_with_wrong_type, source_mod_name, event_name, field_name, value_type, "int"))
  end
  if value < -2147483648 then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "int", "-2147483648", "2147483647"))
  end
  if value > 2147483647 then
    error(string.format(builtin_value_out_of_range, source_mod_name, event_name, field_name, "int", "-2147483648", "2147483647"))
  end
  if value % 1 ~= 0 then
    error(string.format(builtin_value_non_integer, source_mod_name, event_name, field_name, "int"))
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
      error(string.format(required_field_missing, source_mod_name, "on_ai_command_completed", "unit_number", "uint"))
    end
      i__uint(value, source_mod_name, "on_ai_command_completed", "unit_number")
    value = data["result"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_ai_command_completed", "result", "defines.behavior_result"))
    end
      f__defines__behavior_result(value, source_mod_name, "on_ai_command_completed", "result")
  end,
  [defines.events["on_area_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source_surface"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "source_surface", "LuaSurface"))
    end
      a__luasurface(value, source_mod_name, "on_area_cloned", "source_surface")
    value = data["source_area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "source_area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_area_cloned", "source_area")
    value = data["destination_surface"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "destination_surface", "LuaSurface"))
    end
      a__luasurface(value, source_mod_name, "on_area_cloned", "destination_surface")
    value = data["destination_area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "destination_area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_area_cloned", "destination_area")
    value = data["destination_force"]
    if value then
      a__luaforce(value, source_mod_name, "on_area_cloned", "destination_force")
    end
    value = data["clone_tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "clone_tiles", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_tiles")
    value = data["clone_entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "clone_entities", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_entities")
    value = data["clone_decoratives"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "clone_decoratives", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clone_decoratives")
    value = data["clear_destination_entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "clear_destination_entities", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clear_destination_entities")
    value = data["clear_destination_decoratives"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_area_cloned", "clear_destination_decoratives", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_area_cloned", "clear_destination_decoratives")
  end,
  [defines.events["on_biter_base_built"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_biter_base_built", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_biter_base_built", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "unit-spawner" then
        error("invalid type " .. e_type .. ", must be unit-spawner")
      end
  end,
  [defines.events["on_brush_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source_offset"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "source_offset", "TilePosition"))
    end
      n__tileposition(value, source_mod_name, "on_brush_cloned", "source_offset")
    value = data["destination_offset"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "destination_offset", "TilePosition"))
    end
      n__tileposition(value, source_mod_name, "on_brush_cloned", "destination_offset")
    value = data["source_surface"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "source_surface", "LuaSurface"))
    end
      a__luasurface(value, source_mod_name, "on_brush_cloned", "source_surface")
    value = data["source_positions"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "source_positions", "array of TilePosition"))
    end
      r__n__tileposition(value, source_mod_name, "on_brush_cloned", "source_positions")
    value = data["destination_surface"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "destination_surface", "LuaSurface"))
    end
      a__luasurface(value, source_mod_name, "on_brush_cloned", "destination_surface")
    value = data["destination_force"]
    if value then
      a__luaforce(value, source_mod_name, "on_brush_cloned", "destination_force")
    end
    value = data["clone_tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "clone_tiles", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_tiles")
    value = data["clone_entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "clone_entities", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_entities")
    value = data["clone_decoratives"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "clone_decoratives", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clone_decoratives")
    value = data["clear_destination_entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "clear_destination_entities", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_brush_cloned", "clear_destination_entities")
    value = data["clear_destination_decoratives"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_brush_cloned", "clear_destination_decoratives", "boolean"))
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
        error("invalid type " .. e_type .. ", must be unit")
      end
    end
  end,
  [defines.events["on_built_entity"]] = function(data, source_mod_name)
    local value
    value = data["created_entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_built_entity", "created_entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_built_entity", "created_entity")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_built_entity", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_built_entity", "player_index")
    value = data["stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_built_entity", "stack", "LuaItemStack"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_built_entity", tostring(value), "player_index"))
      end
    local e = data["created_entity"]
    return e, e.type
  end,
  [defines.events["on_cancelled_deconstruction"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_cancelled_deconstruction", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_cancelled_deconstruction", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_cancelled_deconstruction", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_cancelled_deconstruction", tostring(value), "player_index"))
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_cancelled_upgrade"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_cancelled_upgrade", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_cancelled_upgrade", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_cancelled_upgrade", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_cancelled_upgrade", tostring(value), "player_index"))
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_character_corpse_expired"]] = function(data, source_mod_name)
    local value
    value = data["corpse"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_character_corpse_expired", "corpse", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_character_corpse_expired", "corpse")
    local e = data["corpse"]
    local e_type
      e_type = e.type
      if e_type ~= "character-corpse" then
        error("invalid type " .. e_type .. ", must be character-corpse")
      end
  end,
  [defines.events["on_chart_tag_added"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_added", "tag", "LuaCustomChartTag"))
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_added", "tag")
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_added", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_added", "force")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_added", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_chart_tag_added", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_chart_tag_modified"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_modified", "tag", "LuaCustomChartTag"))
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_modified", "tag")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_modified", "player_index")
    end
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_modified", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_modified", "force")
    value = data["old_text"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_modified", "old_text", "string"))
    end
      i__string(value, source_mod_name, "on_chart_tag_modified", "old_text")
    value = data["old_icon"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_modified", "old_icon", "SignalID"))
    end
      n__signalid(value, source_mod_name, "on_chart_tag_modified", "old_icon")
    value = data["old_player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_modified", "old_player_index")
    end
    value = data["old_player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_chart_tag_modified", tostring(value), "old_player_index"))
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_chart_tag_modified", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_chart_tag_removed"]] = function(data, source_mod_name)
    local value
    value = data["tag"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_removed", "tag", "LuaCustomChartTag"))
    end
      a__luacustomcharttag(value, source_mod_name, "on_chart_tag_removed", "tag")
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chart_tag_removed", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_chart_tag_removed", "force")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_chart_tag_removed", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_chart_tag_removed", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_chunk_charted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_charted", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_chunk_charted", "surface_index")
    value = data["position"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_charted", "position", "ChunkPosition"))
    end
      n__chunkposition(value, source_mod_name, "on_chunk_charted", "position")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_charted", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_chunk_charted", "area")
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_charted", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_chunk_charted", "force")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_chunk_charted", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_chunk_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_deleted", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_chunk_deleted", "surface_index")
    value = data["positions"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_deleted", "positions", "array of ChunkPosition"))
    end
      r__n__chunkposition(value, source_mod_name, "on_chunk_deleted", "positions")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_chunk_deleted", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_chunk_generated"]] = function(data, source_mod_name)
    local value
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_generated", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_chunk_generated", "area")
    value = data["position"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_generated", "position", "ChunkPosition"))
    end
      n__chunkposition(value, source_mod_name, "on_chunk_generated", "position")
    value = data["surface"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_chunk_generated", "surface", "LuaSurface"))
    end
      a__luasurface(value, source_mod_name, "on_chunk_generated", "surface")
  end,
  [defines.events["on_combat_robot_expired"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_combat_robot_expired", "robot", "LuaEntity"))
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
        error("invalid type " .. e_type .. ", must be combat-robot")
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
      error(string.format(required_field_missing, source_mod_name, "on_console_chat", "message", "string"))
    end
      i__string(value, source_mod_name, "on_console_chat", "message")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_console_chat", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_console_command", "command", "string"))
    end
      i__string(value, source_mod_name, "on_console_command", "command")
    value = data["parameters"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_console_command", "parameters", "string"))
    end
      i__string(value, source_mod_name, "on_console_command", "parameters")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_console_command", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_cutscene_waypoint_reached"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_cutscene_waypoint_reached", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_cutscene_waypoint_reached", "player_index")
    value = data["waypoint_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_cutscene_waypoint_reached", "waypoint_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_cutscene_waypoint_reached", "waypoint_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_cutscene_waypoint_reached", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_difficulty_settings_changed"]] = function(data, source_mod_name)
    local value
    value = data["old_recipe_difficulty"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_difficulty_settings_changed", "old_recipe_difficulty", "uint"))
    end
      i__uint(value, source_mod_name, "on_difficulty_settings_changed", "old_recipe_difficulty")
    value = data["old_technology_difficulty"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_difficulty_settings_changed", "old_technology_difficulty", "uint"))
    end
      i__uint(value, source_mod_name, "on_difficulty_settings_changed", "old_technology_difficulty")
  end,
  [defines.events["on_entity_cloned"]] = function(data, source_mod_name)
    local value
    value = data["source"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_cloned", "source", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_cloned", "source")
    value = data["destination"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_cloned", "destination", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_cloned", "destination")
  end,
  [defines.events["on_entity_damaged"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_damaged", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_damaged", "entity")
    value = data["damage_type"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_damaged", "damage_type", "LuaDamagePrototype"))
    end
      a__luadamageprototype(value, source_mod_name, "on_entity_damaged", "damage_type")
    value = data["original_damage_amount"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_damaged", "original_damage_amount", "float"))
    end
      i__float(value, source_mod_name, "on_entity_damaged", "original_damage_amount")
    value = data["final_damage_amount"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_damaged", "final_damage_amount", "float"))
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
      error(string.format(required_field_missing, source_mod_name, "on_entity_died", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_died", "entity")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_entity_died", "cause")
    end
    value = data["loot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_died", "loot", "LuaInventory"))
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
      error(string.format(required_field_missing, source_mod_name, "on_entity_renamed", "by_script", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_entity_renamed", "by_script")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_renamed", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_renamed", "entity")
    value = data["old_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_renamed", "old_name", "string"))
    end
      i__string(value, source_mod_name, "on_entity_renamed", "old_name")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_entity_renamed", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_entity_settings_pasted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_settings_pasted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_entity_settings_pasted", "player_index")
    value = data["source"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_settings_pasted", "source", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_settings_pasted", "source")
    value = data["destination"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_settings_pasted", "destination", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_settings_pasted", "destination")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_entity_settings_pasted", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_entity_spawned"]] = function(data, source_mod_name)
    local value
    value = data["spawner"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_spawned", "spawner", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_spawned", "spawner")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_entity_spawned", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_entity_spawned", "entity")
    local e = data["spawner"]
    local e_type
      e_type = e.type
      if e_type ~= "unit-spawner" then
        error("invalid type " .. e_type .. ", must be unit-spawner")
      end
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error("invalid type " .. e_type .. ", must be unit")
      end
  end,
  [defines.events["on_force_cease_fire_changed"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_cease_fire_changed", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_force_cease_fire_changed", "force")
    value = data["other_force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_cease_fire_changed", "other_force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_force_cease_fire_changed", "other_force")
    value = data["added"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_cease_fire_changed", "added", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_force_cease_fire_changed", "added")
  end,
  [defines.events["on_force_created"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_created", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_force_created", "force")
  end,
  [defines.events["on_force_friends_changed"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_friends_changed", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_force_friends_changed", "force")
    value = data["other_force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_friends_changed", "other_force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_force_friends_changed", "other_force")
    value = data["added"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_force_friends_changed", "added", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_force_friends_changed", "added")
  end,
  [defines.events["on_forces_merged"]] = function(data, source_mod_name)
    local value
    value = data["source_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_forces_merged", "source_name", "string"))
    end
      i__string(value, source_mod_name, "on_forces_merged", "source_name")
    value = data["source_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_forces_merged", "source_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_forces_merged", "source_index")
    value = data["destination"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_forces_merged", "destination", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_forces_merged", "destination")
  end,
  [defines.events["on_forces_merging"]] = function(data, source_mod_name)
    local value
    value = data["source"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_forces_merging", "source", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_forces_merging", "source")
    value = data["destination"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_forces_merging", "destination", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_forces_merging", "destination")
  end,
  [defines.events["on_gui_checked_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_checked_state_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_checked_state_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_checked_state_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_checked_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_checked_state_changed[e_type] then
        error("invalid type " .. e_type .. ", must be one of ...")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_checked_state_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_click"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_click", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_click", "player_index")
    value = data["button"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "button", "defines.mouse_button_type"))
    end
      f__defines__mouse_button_type(value, source_mod_name, "on_gui_click", "button")
    value = data["alt"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "alt", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_click", "alt")
    value = data["control"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "control", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_click", "control")
    value = data["shift"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_click", "shift", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_click", "shift")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_click", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_closed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_closed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_closed", "player_index")
    value = data["gui_type"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_closed", "gui_type", "defines.gui_type"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_gui_closed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_confirmed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_confirmed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_confirmed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_confirmed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_confirmed", "player_index")
    value = data["alt"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_confirmed", "alt", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "alt")
    value = data["control"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_confirmed", "control", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "control")
    value = data["shift"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_confirmed", "shift", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_gui_confirmed", "shift")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "textfield" then
        error("invalid type " .. e_type .. ", must be textfield")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_confirmed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_elem_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_elem_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_elem_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_elem_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_elem_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "choose-elem-button" then
        error("invalid type " .. e_type .. ", must be choose-elem-button")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_elem_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_location_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_location_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_location_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_location_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_location_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "frame" then
        error("invalid type " .. e_type .. ", must be frame")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_location_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_opened"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_opened", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_opened", "player_index")
    value = data["gui_type"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_opened", "gui_type", "defines.gui_type"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_gui_opened", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_selected_tab_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_selected_tab_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_selected_tab_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_selected_tab_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_selected_tab_changed", "player_index")
    local e = data["{{field_name_to_check}}"]
    local e_type
      e_type = e.type
      if e_type ~= "tabbed-pane" then
        error("invalid type " .. e_type .. ", must be tabbed-pane")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_selected_tab_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_selection_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_selection_state_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_selection_state_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_selection_state_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_selection_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_selection_state_changed[e_type] then
        error("invalid type " .. e_type .. ", must be one of ...")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_selection_state_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_switch_state_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_switch_state_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_switch_state_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_switch_state_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_switch_state_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "switch" then
        error("invalid type " .. e_type .. ", must be switch")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_switch_state_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_text_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_text_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_text_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_text_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_text_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if not types_for_on_gui_text_changed[e_type] then
        error("invalid type " .. e_type .. ", must be one of ...")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_text_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_gui_value_changed"]] = function(data, source_mod_name)
    local value
    value = data["element"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_value_changed", "element", "LuaGuiElement"))
    end
      a__luaguielement(value, source_mod_name, "on_gui_value_changed", "element")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_gui_value_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_gui_value_changed", "player_index")
    local e = data["element"]
    local e_type
      e_type = e.type
      if e_type ~= "slider" then
        error("invalid type " .. e_type .. ", must be slider")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_gui_value_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_land_mine_armed"]] = function(data, source_mod_name)
    local value
    value = data["mine"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_land_mine_armed", "mine", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_land_mine_armed", "mine")
    local e = data["mine"]
    local e_type
      e_type = e.type
      if e_type ~= "land-mine" then
        error("invalid type " .. e_type .. ", must be land-mine")
      end
  end,
  [defines.events["on_lua_shortcut"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_lua_shortcut", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_lua_shortcut", "player_index")
    value = data["prototype_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_lua_shortcut", "prototype_name", "string"))
    end
      i__string(value, source_mod_name, "on_lua_shortcut", "prototype_name")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_lua_shortcut", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_marked_for_deconstruction"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_marked_for_deconstruction", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_marked_for_deconstruction", "entity")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_marked_for_deconstruction", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_marked_for_deconstruction", tostring(value), "player_index"))
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_marked_for_upgrade"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_marked_for_upgrade", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_marked_for_upgrade", "entity")
    value = data["target"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_marked_for_upgrade", "target", "LuaEntityPrototype"))
    end
      a__luaentityprototype(value, source_mod_name, "on_marked_for_upgrade", "target")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_marked_for_upgrade", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_marked_for_upgrade", tostring(value), "player_index"))
      end
    end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_market_item_purchased"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_market_item_purchased", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "player_index")
    value = data["market"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_market_item_purchased", "market", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_market_item_purchased", "market")
    value = data["offer_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_market_item_purchased", "offer_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "offer_index")
    value = data["count"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_market_item_purchased", "count", "uint"))
    end
      i__uint(value, source_mod_name, "on_market_item_purchased", "count")
    local e = data["market"]
    local e_type
      e_type = e.type
      if e_type ~= "market" then
        error("invalid type " .. e_type .. ", must be market")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_market_item_purchased", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_mod_item_opened"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_mod_item_opened", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_mod_item_opened", "player_index")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_mod_item_opened", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_mod_item_opened", "item")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_mod_item_opened", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_picked_up_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_picked_up_item", "item_stack", "SimpleItemStack"))
    end
      n__simpleitemstack(value, source_mod_name, "on_picked_up_item", "item_stack")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_picked_up_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_picked_up_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_picked_up_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_alt_selected_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_alt_selected_area", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_alt_selected_area", "player_index")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_alt_selected_area", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_player_alt_selected_area", "area")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_alt_selected_area", "item", "string"))
    end
      i__string(value, source_mod_name, "on_player_alt_selected_area", "item")
    value = data["entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_alt_selected_area", "entities", "array of LuaEntity"))
    end
      r__a__luaentity(value, source_mod_name, "on_player_alt_selected_area", "entities")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_alt_selected_area", "tiles", "array of LuaTile"))
    end
      r__a__luatile(value, source_mod_name, "on_player_alt_selected_area", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_alt_selected_area", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_ammo_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_ammo_inventory_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_ammo_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_ammo_inventory_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_armor_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_armor_inventory_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_armor_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_armor_inventory_changed", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_player_banned", "player_name", "string"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_player_banned", tostring(value), "by_player"))
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_banned", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_player_built_tile"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_built_tile", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_built_tile", "player_index")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_built_tile", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_built_tile", "surface_index")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_built_tile", "tiles", "array of OldTileAndPosition"))
    end
      r__n__oldtileandposition(value, source_mod_name, "on_player_built_tile", "tiles")
    value = data["tile"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_built_tile", "tile", "LuaTilePrototype"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_player_built_tile", tostring(value), "player_index"))
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_player_built_tile", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_player_cancelled_crafting"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cancelled_crafting", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_cancelled_crafting", "player_index")
    value = data["items"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cancelled_crafting", "items", "LuaInventory"))
    end
      a__luainventory(value, source_mod_name, "on_player_cancelled_crafting", "items")
    value = data["recipe"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cancelled_crafting", "recipe", "LuaRecipe"))
    end
      a__luarecipe(value, source_mod_name, "on_player_cancelled_crafting", "recipe")
    value = data["cancel_count"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cancelled_crafting", "cancel_count", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_cancelled_crafting", "cancel_count")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_cancelled_crafting", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_changed_force"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_changed_force", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_changed_force", "player_index")
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_changed_force", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_player_changed_force", "force")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_changed_force", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_changed_position"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_changed_position", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_changed_position", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_changed_position", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_changed_surface"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_changed_surface", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_changed_surface", "player_index")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_changed_surface", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_changed_surface", "surface_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_changed_surface", tostring(value), "player_index"))
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_player_changed_surface", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_player_cheat_mode_disabled"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cheat_mode_disabled", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_cheat_mode_disabled", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_cheat_mode_disabled", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_cheat_mode_enabled"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cheat_mode_enabled", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_cheat_mode_enabled", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_cheat_mode_enabled", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_configured_blueprint"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_configured_blueprint", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_configured_blueprint", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_configured_blueprint", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_crafted_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_crafted_item", "item_stack", "LuaItemStack"))
    end
      a__luaitemstack(value, source_mod_name, "on_player_crafted_item", "item_stack")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_crafted_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_crafted_item", "player_index")
    value = data["recipe"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_crafted_item", "recipe", "LuaRecipe"))
    end
      a__luarecipe(value, source_mod_name, "on_player_crafted_item", "recipe")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_crafted_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_created"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_created", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_created", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_created", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_cursor_stack_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_cursor_stack_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_cursor_stack_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_cursor_stack_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_deconstructed_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_deconstructed_area", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_deconstructed_area", "player_index")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_deconstructed_area", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_player_deconstructed_area", "area")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_deconstructed_area", "item", "string"))
    end
      i__string(value, source_mod_name, "on_player_deconstructed_area", "item")
    value = data["alt"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_deconstructed_area", "alt", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_player_deconstructed_area", "alt")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_deconstructed_area", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_demoted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_demoted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_demoted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_demoted", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_died"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_died", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_died", "player_index")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_player_died", "cause")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_died", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_display_resolution_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_display_resolution_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_display_resolution_changed", "player_index")
    value = data["old_resolution"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_display_resolution_changed", "old_resolution", "DisplayResolution"))
    end
      n__displayresolution(value, source_mod_name, "on_player_display_resolution_changed", "old_resolution")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_display_resolution_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_display_scale_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_display_scale_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_display_scale_changed", "player_index")
    value = data["old_scale"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_display_scale_changed", "old_scale", "double"))
    end
      i__double(value, source_mod_name, "on_player_display_scale_changed", "old_scale")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_display_scale_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_driving_changed_state"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_driving_changed_state", "player_index", "uint"))
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
        error("invalid type " .. e_type .. ", must be car")
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_driving_changed_state", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_dropped_item"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_dropped_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_dropped_item", "player_index")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_dropped_item", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_player_dropped_item", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "item-entity" then
        error("invalid type " .. e_type .. ", must be item-entity")
      end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_dropped_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_fast_transferred"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_fast_transferred", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_fast_transferred", "player_index")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_fast_transferred", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_player_fast_transferred", "entity")
    value = data["from_player"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_fast_transferred", "from_player", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_player_fast_transferred", "from_player")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_fast_transferred", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_gun_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_gun_inventory_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_gun_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_gun_inventory_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_joined_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_joined_game", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_joined_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_joined_game", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_kicked"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_kicked", "player_index", "uint"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_player_kicked", tostring(value), "by_player"))
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_kicked", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_left_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_left_game", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_left_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_left_game", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_main_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_main_inventory_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_main_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_main_inventory_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_mined_entity"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_entity", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_mined_entity", "player_index")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_entity", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_player_mined_entity", "entity")
    value = data["buffer"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_entity", "buffer", "LuaInventory"))
    end
      a__luainventory(value, source_mod_name, "on_player_mined_entity", "buffer")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_mined_entity", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_mined_item"]] = function(data, source_mod_name)
    local value
    value = data["item_stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_item", "item_stack", "SimpleItemStack"))
    end
      n__simpleitemstack(value, source_mod_name, "on_player_mined_item", "item_stack")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_mined_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_mined_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_mined_tile"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_tile", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_mined_tile", "player_index")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_tile", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_mined_tile", "surface_index")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_mined_tile", "tiles", "array of OldTileAndPosition"))
    end
      r__n__oldtileandposition(value, source_mod_name, "on_player_mined_tile", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_mined_tile", tostring(value), "player_index"))
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_player_mined_tile", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_player_muted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_muted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_muted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_muted", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_pipette"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_pipette", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_pipette", "player_index")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_pipette", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_player_pipette", "item")
    value = data["used_cheat_mode"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_pipette", "used_cheat_mode", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_player_pipette", "used_cheat_mode")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_pipette", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_placed_equipment"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_placed_equipment", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_placed_equipment", "player_index")
    value = data["equipment"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_placed_equipment", "equipment", "LuaEquipment"))
    end
      a__luaequipment(value, source_mod_name, "on_player_placed_equipment", "equipment")
    value = data["grid"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_placed_equipment", "grid", "LuaEquipmentGrid"))
    end
      a__luaequipmentgrid(value, source_mod_name, "on_player_placed_equipment", "grid")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_placed_equipment", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_promoted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_promoted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_promoted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_promoted", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_removed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_removed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_removed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_removed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_removed_equipment"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_removed_equipment", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_removed_equipment", "player_index")
    value = data["grid"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_removed_equipment", "grid", "LuaEquipmentGrid"))
    end
      a__luaequipmentgrid(value, source_mod_name, "on_player_removed_equipment", "grid")
    value = data["equipment"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_removed_equipment", "equipment", "string"))
    end
      i__string(value, source_mod_name, "on_player_removed_equipment", "equipment")
    value = data["count"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_removed_equipment", "count", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_removed_equipment", "count")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_removed_equipment", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_repaired_entity"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_repaired_entity", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_repaired_entity", "player_index")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_repaired_entity", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_player_repaired_entity", "entity")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_repaired_entity", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_respawned"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_respawned", "player_index", "uint"))
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
        error("invalid type " .. e_type .. ", must be player-port")
      end
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_respawned", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_rotated_entity"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_rotated_entity", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_player_rotated_entity", "entity")
    value = data["previous_direction"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_rotated_entity", "previous_direction", "defines.direction"))
    end
      f__defines__direction(value, source_mod_name, "on_player_rotated_entity", "previous_direction")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_rotated_entity", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_rotated_entity", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_rotated_entity", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_selected_area"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_selected_area", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_selected_area", "player_index")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_selected_area", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_player_selected_area", "area")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_selected_area", "item", "string"))
    end
      i__string(value, source_mod_name, "on_player_selected_area", "item")
    value = data["entities"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_selected_area", "entities", "array of LuaEntity"))
    end
      r__a__luaentity(value, source_mod_name, "on_player_selected_area", "entities")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_selected_area", "tiles", "array of LuaTile"))
    end
      r__a__luatile(value, source_mod_name, "on_player_selected_area", "tiles")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_selected_area", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_setup_blueprint"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_setup_blueprint", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_setup_blueprint", "player_index")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_setup_blueprint", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_player_setup_blueprint", "area")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_setup_blueprint", "item", "string"))
    end
      i__string(value, source_mod_name, "on_player_setup_blueprint", "item")
    value = data["alt"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_setup_blueprint", "alt", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_player_setup_blueprint", "alt")
    value = data["mapping"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_setup_blueprint", "mapping", "LuaLazyLoadedValue (dictionary uint -> LuaEntity)"))
    end
      z__c__k__i__uint__v__a__luaentity(value, source_mod_name, "on_player_setup_blueprint", "mapping")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_setup_blueprint", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_toggled_alt_mode"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_toggled_alt_mode", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_toggled_alt_mode", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_toggled_alt_mode", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_toggled_map_editor"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_toggled_map_editor", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_toggled_map_editor", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_toggled_map_editor", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_trash_inventory_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_trash_inventory_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_trash_inventory_changed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_trash_inventory_changed", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_player_unbanned", "player_name", "string"))
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
        error(string.format(invalid_player_index, source_mod_name, "on_player_unbanned", tostring(value), "by_player"))
      end
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_unbanned", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_player_unmuted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_unmuted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_unmuted", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_unmuted", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_player_used_capsule"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_used_capsule", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_player_used_capsule", "player_index")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_used_capsule", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_player_used_capsule", "item")
    value = data["position"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_player_used_capsule", "position", "Position"))
    end
      n__position(value, source_mod_name, "on_player_used_capsule", "position")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_player_used_capsule", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_post_entity_died", "position", "Position"))
    end
      n__position(value, source_mod_name, "on_post_entity_died", "position")
    value = data["prototype"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_post_entity_died", "prototype", "LuaEntityPrototype"))
    end
      a__luaentityprototype(value, source_mod_name, "on_post_entity_died", "prototype")
    value = data["corpses"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_post_entity_died", "corpses", "array of LuaEntity"))
    end
      r__a__luaentity(value, source_mod_name, "on_post_entity_died", "corpses")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_post_entity_died", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_post_entity_died", "surface_index")
    value = data["unit_number"]
    if value then
      i__uint(value, source_mod_name, "on_post_entity_died", "unit_number")
    end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_post_entity_died", tostring(value), "surface_index"))
      end
    local e = data["prototype"]
    return e, e.type
  end,
  [defines.events["on_pre_chunk_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_chunk_deleted", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_chunk_deleted", "surface_index")
    value = data["positions"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_chunk_deleted", "positions", "array of ChunkPosition"))
    end
      r__n__chunkposition(value, source_mod_name, "on_pre_chunk_deleted", "positions")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_pre_chunk_deleted", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_pre_entity_settings_pasted"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_entity_settings_pasted", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_entity_settings_pasted", "player_index")
    value = data["source"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_entity_settings_pasted", "source", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_entity_settings_pasted", "source")
    value = data["destination"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_entity_settings_pasted", "destination", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_entity_settings_pasted", "destination")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_entity_settings_pasted", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_pre_ghost_deconstructed", "ghost", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_ghost_deconstructed", "ghost")
    local e = data["ghost"]
    local e_type
      e_type = e.type
      if not types_for_on_pre_ghost_deconstructed[e_type] then
        error("invalid type " .. e_type .. ", must be one of ...")
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_ghost_deconstructed", tostring(value), "player_index"))
      end
    end
    return e, e_type
  end,
  [defines.events["on_pre_player_crafted_item"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_crafted_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_player_crafted_item", "player_index")
    value = data["recipe"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_crafted_item", "recipe", "LuaRecipe"))
    end
      a__luarecipe(value, source_mod_name, "on_pre_player_crafted_item", "recipe")
    value = data["items"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_crafted_item", "items", "LuaInventory"))
    end
      a__luainventory(value, source_mod_name, "on_pre_player_crafted_item", "items")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_player_crafted_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_pre_player_died"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_died", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_player_died", "player_index")
    value = data["cause"]
    if value then
      a__luaentity(value, source_mod_name, "on_pre_player_died", "cause")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_player_died", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_pre_player_left_game"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_left_game", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_player_left_game", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_player_left_game", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_pre_player_mined_item"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_mined_item", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_player_mined_item", "entity")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_mined_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_player_mined_item", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_player_mined_item", tostring(value), "player_index"))
      end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_pre_player_removed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_player_removed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_player_removed", "player_index")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_pre_player_removed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_pre_robot_exploded_cliff"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_robot_exploded_cliff", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_robot_exploded_cliff", "robot")
    value = data["cliff"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_robot_exploded_cliff", "cliff", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_pre_robot_exploded_cliff", "cliff")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_robot_exploded_cliff", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_pre_robot_exploded_cliff", "item")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
    local e = data["cliff"]
    local e_type
      e_type = e.type
      if e_type ~= "cliff" then
        error("invalid type " .. e_type .. ", must be cliff")
      end
  end,
  [defines.events["on_pre_surface_cleared"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_surface_cleared", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_surface_cleared", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_pre_surface_cleared", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_pre_surface_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_pre_surface_deleted", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_pre_surface_deleted", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_pre_surface_deleted", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_put_item"]] = function(data, source_mod_name)
    local value
    value = data["position"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_put_item", "position", "Position"))
    end
      n__position(value, source_mod_name, "on_put_item", "position")
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_put_item", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_put_item", "player_index")
    value = data["shift_build"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_put_item", "shift_build", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_put_item", "shift_build")
    value = data["built_by_moving"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_put_item", "built_by_moving", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_put_item", "built_by_moving")
    value = data["direction"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_put_item", "direction", "defines.direction"))
    end
      f__defines__direction(value, source_mod_name, "on_put_item", "direction")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_put_item", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_research_finished"]] = function(data, source_mod_name)
    local value
    value = data["research"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_research_finished", "research", "LuaTechnology"))
    end
      a__luatechnology(value, source_mod_name, "on_research_finished", "research")
    value = data["by_script"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_research_finished", "by_script", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_research_finished", "by_script")
  end,
  [defines.events["on_research_started"]] = function(data, source_mod_name)
    local value
    value = data["research"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_research_started", "research", "LuaTechnology"))
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
      error(string.format(required_field_missing, source_mod_name, "on_resource_depleted", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_resource_depleted", "entity")
    local e = data["entity"]
    local e_type
      e_type = e.type
      if e_type ~= "resource" then
        error("invalid type " .. e_type .. ", must be resource")
      end
  end,
  [defines.events["on_robot_built_entity"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_entity", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_built_entity", "robot")
    value = data["created_entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_entity", "created_entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_built_entity", "created_entity")
    value = data["stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_entity", "stack", "LuaItemStack"))
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
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
    local e = data["created_entity"]
    return e, e.type
  end,
  [defines.events["on_robot_built_tile"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_built_tile", "robot")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "tiles", "array of OldTileAndPosition"))
    end
      r__n__oldtileandposition(value, source_mod_name, "on_robot_built_tile", "tiles")
    value = data["tile"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "tile", "LuaTilePrototype"))
    end
      a__luatileprototype(value, source_mod_name, "on_robot_built_tile", "tile")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_robot_built_tile", "item")
    value = data["stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "stack", "LuaItemStack"))
    end
      a__luaitemstack(value, source_mod_name, "on_robot_built_tile", "stack")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_built_tile", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_robot_built_tile", "surface_index")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_robot_built_tile", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_robot_exploded_cliff"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_exploded_cliff", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_exploded_cliff", "robot")
    value = data["item"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_exploded_cliff", "item", "LuaItemPrototype"))
    end
      a__luaitemprototype(value, source_mod_name, "on_robot_exploded_cliff", "item")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
  end,
  [defines.events["on_robot_mined"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_mined", "robot")
    value = data["item_stack"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined", "item_stack", "SimpleItemStack"))
    end
      n__simpleitemstack(value, source_mod_name, "on_robot_mined", "item_stack")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
  end,
  [defines.events["on_robot_mined_entity"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_entity", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_entity", "robot")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_entity", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_entity", "entity")
    value = data["buffer"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_entity", "buffer", "LuaInventory"))
    end
      a__luainventory(value, source_mod_name, "on_robot_mined_entity", "buffer")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
  end,
  [defines.events["on_robot_mined_tile"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_tile", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_mined_tile", "robot")
    value = data["tiles"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_tile", "tiles", "array of OldTileAndPosition"))
    end
      r__n__oldtileandposition(value, source_mod_name, "on_robot_mined_tile", "tiles")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_mined_tile", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_robot_mined_tile", "surface_index")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_robot_mined_tile", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_robot_pre_mined"]] = function(data, source_mod_name)
    local value
    value = data["robot"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_pre_mined", "robot", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_pre_mined", "robot")
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_robot_pre_mined", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_robot_pre_mined", "entity")
    local e = data["robot"]
    local e_type
      e_type = e.type
      if e_type ~= "construction-robot" then
        error("invalid type " .. e_type .. ", must be construction-robot")
      end
    local e = data["entity"]
    return e, e.type
  end,
  [defines.events["on_rocket_launch_ordered"]] = function(data, source_mod_name)
    local value
    value = data["rocket"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_rocket_launch_ordered", "rocket", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_rocket_launch_ordered", "rocket")
    value = data["rocket_silo"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_rocket_launch_ordered", "rocket_silo", "LuaEntity"))
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
        error("invalid type " .. e_type .. ", must be rocket-silo-rocket")
      end
    local e = data["rocket_silo"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo" then
        error("invalid type " .. e_type .. ", must be rocket-silo")
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_rocket_launch_ordered", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_rocket_launched"]] = function(data, source_mod_name)
    local value
    value = data["rocket"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_rocket_launched", "rocket", "LuaEntity"))
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
        error("invalid type " .. e_type .. ", must be rocket-silo-rocket")
      end
    local e = data["rocket_silo"]
    local e_type
      e_type = e.type
      if e_type ~= "rocket-silo" then
        error("invalid type " .. e_type .. ", must be rocket-silo")
      end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_rocket_launched", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_runtime_mod_setting_changed", "setting", "string"))
    end
      i__string(value, source_mod_name, "on_runtime_mod_setting_changed", "setting")
    value = data["setting_type"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_runtime_mod_setting_changed", "setting_type", "string"))
    end
      i__string(value, source_mod_name, "on_runtime_mod_setting_changed", "setting_type")
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_runtime_mod_setting_changed", tostring(value), "player_index"))
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
      error(string.format(required_field_missing, source_mod_name, "on_script_path_request_finished", "id", "uint"))
    end
      i__uint(value, source_mod_name, "on_script_path_request_finished", "id")
    value = data["try_again_later"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_script_path_request_finished", "try_again_later", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_script_path_request_finished", "try_again_later")
  end,
  [defines.events["on_script_trigger_effect"]] = function(data, source_mod_name)
    local value
    value = data["effect_id"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_script_trigger_effect", "effect_id", "string"))
    end
      i__string(value, source_mod_name, "on_script_trigger_effect", "effect_id")
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_script_trigger_effect", "surface_index", "uint"))
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
    value = data["target"]
    if value then
      a__luaentity(value, source_mod_name, "on_script_trigger_effect", "target")
    end
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_script_trigger_effect", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_sector_scanned"]] = function(data, source_mod_name)
    local value
    value = data["radar"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_sector_scanned", "radar", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_sector_scanned", "radar")
    value = data["chunk_position"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_sector_scanned", "chunk_position", "ChunkPosition"))
    end
      n__chunkposition(value, source_mod_name, "on_sector_scanned", "chunk_position")
    value = data["area"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_sector_scanned", "area", "BoundingBox"))
    end
      n__boundingbox(value, source_mod_name, "on_sector_scanned", "area")
    local e = data["radar"]
    local e_type
      e_type = e.type
      if e_type ~= "radar" then
        error("invalid type " .. e_type .. ", must be radar")
      end
  end,
  [defines.events["on_selected_entity_changed"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_selected_entity_changed", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_selected_entity_changed", "player_index")
    value = data["last_entity"]
    if value then
      a__luaentity(value, source_mod_name, "on_selected_entity_changed", "last_entity")
    end
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_selected_entity_changed", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_string_translated"]] = function(data, source_mod_name)
    local value
    value = data["player_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_string_translated", "player_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_string_translated", "player_index")
    value = data["localised_string"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_string_translated", "localised_string", "LocalisedString"))
    end
      n__localisedstring(value, source_mod_name, "on_string_translated", "localised_string")
    value = data["result"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_string_translated", "result", "string"))
    end
      i__string(value, source_mod_name, "on_string_translated", "result")
    value = data["translated"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_string_translated", "translated", "boolean"))
    end
      i__boolean(value, source_mod_name, "on_string_translated", "translated")
    value = data["player_index"]
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_string_translated", tostring(value), "player_index"))
      end
  end,
  [defines.events["on_surface_cleared"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_cleared", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_surface_cleared", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_surface_cleared", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_surface_created"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_created", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_surface_created", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_surface_created", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_surface_deleted"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_deleted", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_surface_deleted", "surface_index")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_surface_deleted", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_surface_imported"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_imported", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_surface_imported", "surface_index")
    value = data["original_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_imported", "original_name", "string"))
    end
      i__string(value, source_mod_name, "on_surface_imported", "original_name")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_surface_imported", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_surface_renamed"]] = function(data, source_mod_name)
    local value
    value = data["surface_index"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_renamed", "surface_index", "uint"))
    end
      i__uint(value, source_mod_name, "on_surface_renamed", "surface_index")
    value = data["old_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_renamed", "old_name", "string"))
    end
      i__string(value, source_mod_name, "on_surface_renamed", "old_name")
    value = data["new_name"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_surface_renamed", "new_name", "string"))
    end
      i__string(value, source_mod_name, "on_surface_renamed", "new_name")
    value = data["surface_index"]
      if not game.surfaces[value] then
        error(string.format(invalid_surface_index, source_mod_name, "on_surface_renamed", tostring(value), "surface_index"))
      end
  end,
  [defines.events["on_technology_effects_reset"]] = function(data, source_mod_name)
    local value
    value = data["force"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_technology_effects_reset", "force", "LuaForce"))
    end
      a__luaforce(value, source_mod_name, "on_technology_effects_reset", "force")
  end,
  [defines.events["on_train_changed_state"]] = function(data, source_mod_name)
    local value
    value = data["train"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_train_changed_state", "train", "LuaTrain"))
    end
      a__luatrain(value, source_mod_name, "on_train_changed_state", "train")
    value = data["old_state"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_train_changed_state", "old_state", "defines.train_state"))
    end
      f__defines__train_state(value, source_mod_name, "on_train_changed_state", "old_state")
  end,
  [defines.events["on_train_created"]] = function(data, source_mod_name)
    local value
    value = data["train"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_train_created", "train", "LuaTrain"))
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
      error(string.format(required_field_missing, source_mod_name, "on_train_schedule_changed", "train", "LuaTrain"))
    end
      a__luatrain(value, source_mod_name, "on_train_schedule_changed", "train")
    value = data["player_index"]
    if value then
      i__uint(value, source_mod_name, "on_train_schedule_changed", "player_index")
    end
    value = data["player_index"]
    if value then
      if not game.get_player(value) then
        error(string.format(invalid_player_index, source_mod_name, "on_train_schedule_changed", tostring(value), "player_index"))
      end
    end
  end,
  [defines.events["on_trigger_created_entity"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_trigger_created_entity", "entity", "LuaEntity"))
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
      error(string.format(required_field_missing, source_mod_name, "on_trigger_fired_artillery", "entity", "LuaEntity"))
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
      error(string.format(required_field_missing, source_mod_name, "on_unit_added_to_group", "unit", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_unit_added_to_group", "unit")
    value = data["group"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_unit_added_to_group", "group", "LuaUnitGroup"))
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_added_to_group", "group")
    local e = data["unit"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error("invalid type " .. e_type .. ", must be unit")
      end
  end,
  [defines.events["on_unit_group_created"]] = function(data, source_mod_name)
    local value
    value = data["group"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_unit_group_created", "group", "LuaUnitGroup"))
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_group_created", "group")
  end,
  [defines.events["on_unit_group_finished_gathering"]] = function(data, source_mod_name)
    local value
    value = data["group"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_unit_group_finished_gathering", "group", "LuaUnitGroup"))
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_group_finished_gathering", "group")
  end,
  [defines.events["on_unit_removed_from_group"]] = function(data, source_mod_name)
    local value
    value = data["unit"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_unit_removed_from_group", "unit", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "on_unit_removed_from_group", "unit")
    value = data["group"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "on_unit_removed_from_group", "group", "LuaUnitGroup"))
    end
      a__luaunitgroup(value, source_mod_name, "on_unit_removed_from_group", "group")
    local e = data["unit"]
    local e_type
      e_type = e.type
      if e_type ~= "unit" then
        error("invalid type " .. e_type .. ", must be unit")
      end
  end,
  [defines.events["script_raised_built"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "script_raised_built", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "script_raised_built", "entity")
  end,
  [defines.events["script_raised_destroy"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "script_raised_destroy", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "script_raised_destroy", "entity")
  end,
  [defines.events["script_raised_revive"]] = function(data, source_mod_name)
    local value
    value = data["entity"]
    if not value then
      error(string.format(required_field_missing, source_mod_name, "script_raised_revive", "entity", "LuaEntity"))
    end
      a__luaentity(value, source_mod_name, "script_raised_revive", "entity")
    value = data["tags"]
    if value then
      n__tags(value, source_mod_name, "script_raised_revive", "tags")
    end
  end,
}
