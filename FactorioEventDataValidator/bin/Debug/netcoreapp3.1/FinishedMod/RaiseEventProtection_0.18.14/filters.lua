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

-- "force": Additional fields:
--     force :: string: The entity force

-- "original-damage-amount": Additional fields:
--     comparison :: ComparatorString
--     value :: uint: The value to compare against.
-- "final-damage-amount": Additional fields:
--     comparison :: ComparatorString
--     value :: uint: The value to compare against.
-- "damage-type": Additional fields:
--     type :: string: A LuaDamagePrototype name

local all_types = require("__RaiseEventProtection__/all-entity-types.lua")

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
    "artillery-wagon",
    "cargo-wagon",
    "fluid-wagon",
    "locomotive",
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



local type_map = {} -- type string -> bit wise and of all filters the type is included in
local filter_map = {} -- filter name -> number (single bit, unique)

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
  ["force"] = function(filter)
    return "force" .. filter.force
  end,
  ["ghost_type"] = function(filter)
    return "ghost_type" .. filter.ghost_type
  end,
  ["ghost_name"] = function(filter)
    return "ghost_name" .. filter.ghost_name
  end,
  ["original-damage-amount"] = function(filter)
    return "original-damage-amount" .. filter.value .. filter.comparison
  end,
  ["final-damage-amount"] = function(filter)
    return "final-damage-amount" .. filter.value .. filter.comparison
  end,
  ["damage-type"] = function(filter)
    return "damage-type" .. filter.type
  end,
}
setmetatable(check_string_helpers, {
  __index = function(t, k)
    return function(filter) -- default
      return filter.filter
    end
  end,
})

-- get a string which identifies the filter, considers everything except mode, since that does not affect the actual check
local function get_check_string(filter)
  return check_string_helpers[filter.filter](filter)
end


local comparator_map = {
  ["<"] = "<",
  [">"] = ">",
  ["="] = "==",
  ["≥"] = ">=",
  ["≤"] = "<=",
  ["≠"] = "~=",
}

local needed_localed_fields = {}
local check_table_helpers = {
  ["type"] = function(filter)
    return { local_name = "entity_type", value = filter.type, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["name"] = function(filter)
    needed_localed_fields["name"] = "entity.name"
    return { local_name = "name", value = filter.name, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["force"] = function(filter)
    needed_localed_fields["force_name"] = "entity.force.name"
    return { local_name = "force_name", value = filter.name, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["ghost_type"] = function(filter)
    needed_localed_fields["ghost_type"] = "entity.ghost_type"
    return { local_name = "ghost_type", value = filter.ghost_type, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["ghost_name"] = function(filter)
    needed_localed_fields["ghost_name"] = "entity.ghost_name"
    return { local_name = "ghost_name", value = filter.ghost_name, invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["original-damage-amount"] = function(filter)
    needed_localed_fields["original_damage_amount"] = "event.original_damage_amount"
    return { local_name = "original_damage_amount", value = filter.value, comparator = comparator_map[filter.comparison], invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["final-damage-amount"] = function(filter)
    needed_localed_fields["original_damage_amount"] = "event.original_damage_amount"
    return { local_name = "original_damage_amount", value = filter.value, comparator = comparator_map[filter.comparison], invert = filter.invert, mode = filter.mode or "or" }
  end,
  ["damage-type"] = function(filter)
    needed_localed_fields["damage_type"] = "event.damage_type"
    return { local_name = "damage_type", value = filter.type, invert = filter.invert, mode = filter.mode or "or" }
  end,
}
local has_special_check = false
setmetatable(check_table_helpers, {
  __index = function(t, k)
    return function(filter) -- default
      has_special_check = true
      return { num_value = filter_map[filter.filter], invert = filter.invert, mode = filter.mode or "or" }
    end
  end,
})

-- create a check_table from a filter definition
local function get_check_table(filter)
  return check_table_helpers[filter.filter](filter)
end

-- create the check from a check_table, considers cached_result_local_name
local function get_check(check_table)
  if check_table.cached_result_local_name then
    return (check_table.invert and "not " or "") .. check_table.cached_result_local_name
  end
  local local_name = check_table.local_name
  if local_name then
    local comparator = check_table.comparator
    if comparator then
      return (check_table.invert and "not " or "") .. local_name .. comparator .. check_table.value
    else
      return local_name .. (check_table.invert and "~='" or "=='") .. check_table.value .. "'"
    end
  else
    return (check_table.invert and "not " or "") .. "btest(num," .. tostring(check_table.num_value) .. ")"
  end
end

local function generate_filter(filters)
  if not filters[1] then return function() return true end end
  local cached_result_index = 1 -- count is this -1
  local cached_results = {}
  local duplicate_checks_count = 0
  local all_check_tables = {}

  -- go through all filters and prepare result cacheing for duplicate filters
  for _, filter in ipairs(filters) do
    local check_string = get_check_string(filter)
    local check_table = all_check_tables[check_string]

    if check_table then
      local chached_result_local_name = check_table.cached_result_local_name
      if not chached_result_local_name then -- not cached yet, so make it get cached
        local local_count_str = tostring(cached_result_index)
        cached_results[cached_result_index] = "local l" .. local_count_str .. "=" .. get_check(check_table) .. ";"
        check_table.cached_result_local_name = "l" .. local_count_str
        cached_result_index = cached_result_index + 1
      end

      all_check_tables[tostring(duplicate_checks_count)] = { -- add a small check_table, since this is all it needs
        cached_result_local_name = check_table.cached_result_local_name,
        invert = filter.invert,
        mode = filter.mode or "or",
      }
      duplicate_checks_count = duplicate_checks_count + 1
    else
      -- first time this exact check was defined, so just add it directly
      all_check_tables[check_string] = get_check_table(filter)
    end
  end

  -- build function string
  local func_str = "return function(event,entity,entity_type,type_map)"

  if has_special_check then
    has_special_check = false
    func_str = func_str .. "local btest,num=bit32.btest,type_map[entity_type];"
  end
  -- add localed fields for checks
  for local_name, entity_field in pairs(needed_localed_fields) do
    func_str = func_str .. "local " .. local_name .. "=" .. entity_field .. ";"
  end
  needed_localed_fields = {}

  func_str = func_str .. table.concat(cached_results)

  -- add first check, which ignores the "mode"
  local first_key, first_value = next(all_check_tables)
  func_str = func_str .. "return " .. get_check(first_value) .. " "

  -- add all the other checks
  for _, check_table in next, all_check_tables, first_key do
    func_str = func_str .. check_table.mode .. " " .. get_check(check_table) .. " "
  end

  func_str = func_str .. "end"
  return load(func_str)()
end

return {
  generate_filter = generate_filter,
  type_map = type_map,
}
