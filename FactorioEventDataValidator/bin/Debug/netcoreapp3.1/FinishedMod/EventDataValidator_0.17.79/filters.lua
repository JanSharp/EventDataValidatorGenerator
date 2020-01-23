-- "ghost"
-- "rail"
-- "rail-signal"
-- "rolling-stock"
-- "robot-with-logistics-interface"
-- "vehicle"
-- "turret"
-- "crafting-machine"
-- "wall-connectable"
-- "transport-belt-connectable"
-- "circuit-network-connectable"
-- "type": Additional fields:
--     type :: string: The prototype type
-- "name": Additional fields:
--     name :: string: The prototype name
-- "ghost_type": Additional fields:
--     type :: string: The ghost prototype type
-- "ghost_name": Additional fields:
--     name :: string: The ghost prototype name

local all_types = require("__EventDataValidator__/all-entity-types")

local raw_definitions = {
  ["ghost"] = {
    "entity-ghost",
    "tile-ghost",
  },
  ["rail"] = {
    "curved-rail",
    "straight-rail",
  },
  ["rail-signal"] = {
    "rail-chain-signal",
    "rail-signal",
  },
  ["rolling-stock"] = {
    "artillery-wagon",
    "cargo-wagon",
    "fluid-wagon",
    "locomotive",
  },
  ["robot-with-logistics-interface"] = {
    "construction-robot",
    "logistic-robot",
  },
  ["vehicle"] = {
    "car",
  },
  ["turret"] = {
    "turret",
    "ammo-turret",
    "electric-turret",
    "fluid-turret",
  },
  ["crafting-machine"] = {
    "assembling-machine",
    "rocket-silo",
    "furnace",
  },
  ["wall-connectable"] = {
    "wall",
    "gate",
  },
  ["transport-belt-connectable"] = {
    "loader",
    "splitter",
    "transport-belt",
    "underground-belt",
  },
  ["circuit-network-connectable"] = {
    "arithmetic-combinator",
    "decider-combinator",
    "constant-combinator",
    "roboport",
    "container",
    "logistic-container",
    "infinity-container",
    "power-switch",
    "electric-pole",
    "accumulator",
    "wall",
    "lamp",
    "programmable-speaker",
    "pump",
    "rail-chain-signal",
    "rail-signal",
    "storage-tank",
    "train-stop",
    "transport-belt",
    "inserter",
  },
}



local type_map = {}
__event_data_validator_type_map = type_map
local filter_map = {}

for _, type_name in pairs(all_types) do
  type_map[type_name] = 0
end

local num = 1
for filter_name, types in pairs(raw_definitions) do
  filter_map[filter_name] = num
  for _, type_name in pairs(types) do
    type_map[type_name] = type_map[type_name] + num
  end
  num = num * 2 -- bit32.lshift(num, 1)
end


local check_string_helpers = {
  ["type"] = function(filter)
    return "type" .. filter.type
  end,
  ["name"] = function(filter)
    return "name" .. filter.name
  end,
  ["ghost_type"] = function(filter)
    return "ghost_type" .. filter.ghost_type
  end,
  ["ghost_name"] = function(filter)
    return "ghost_name" .. filter.ghost_name
  end,
}
setmetatable(check_string_helpers, {
  __index = function(t, k)
    return function(filter) -- default
      return filter.filter
    end
  end,
})

local function get_check_string(filter)
  return check_string_helpers[filter.filter](filter)
end

local needed_localed_fields = {}
local check_table_helpers = {
  ["type"] = function(filter)
    return { count = 1, filter = "entity_type", value = filter.type, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["name"] = function(filter)
    needed_localed_fields["name"] = true
    return { count = 1, filter = "name", value = filter.name, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["ghost_type"] = function(filter)
    needed_localed_fields["ghost_type"] = true
    return { count = 1, filter = "ghost_type", value = filter.ghost_type, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["ghost_name"] = function(filter)
    needed_localed_fields["ghost_name"] = true
    return { count = 1, filter = "ghost_name", value = filter.ghost_name, invert = filter.invert, mode = filter.mode or "or" }
  end,
}
local has_special_check = false
setmetatable(check_table_helpers, {
  __index = function(t, k)
    return function(filter) -- default
      has_special_check = true
      return { count = 1, filter = filter.filter, num_value = filter_map[filter.filter], invert = filter.invert, mode = filter.mode or "or" }
    end
  end,
})

local function get_check_table(filter)
  return check_table_helpers[filter.filter](filter)
end

local function get_check(check_table)
  if check_table.local_name then
    return check_table.local_name
  end
  local value = check_table.value
  if value then
    return check_table.filter .. (check_table.invert and "~='" or "=='") .. value .. "'"
  else
    return (check_table.invert and "not " or "") .. "btest(num," .. tostring(check_table.num_value) .. ")"
  end
end

local function generate_filter(filters)
  if not filters[1] then return function() return true end end
  local local_count = 0
  local localed_checks = {}
  local all_checks = {}

  for _, filter in ipairs(filters) do
    local check_string = get_check_string(filter)
    local check = all_checks[check_string]
    if check then
      local count = check.count + 1
      check.count = count
      if count == 2 then
        local local_name = "l" .. tostring(local_count)
        local_count = local_count + 1
        localed_checks[local_count] = "local " .. local_name .. "=" .. get_check(check) .. ";"
        check.local_name = local_name
      end
    else
      all_checks[check_string] = get_check_table(filter)
    end
  end

  local func_str = "return function(entity,entity_type)"

  if has_special_check then
    has_special_check = false
    func_str = func_str .. "local btest,num=bit32.btest,__event_data_validator_type_map[entity_type];"
  end
  for field, _ in pairs(needed_localed_fields) do
    func_str = func_str .. "local " .. field .. "=entity." .. field .. ";"
  end
  needed_localed_fields = {}

  local first_key, first_value = next(all_checks)
  func_str = func_str .. "return " .. get_check(first_value) .. " "

  for _, check_table in next, all_checks, first_key do
    func_str = func_str .. check_table.mode .. " " .. get_check(check_table) .. " "
  end

  func_str = func_str .. "end"
  return load(func_str, "=(load)")()
end

return {
  generate_filter = generate_filter,
}
