
local validators = require("__EventDataValidator__/validators")
-- stupid name, but who cares :)
local filterers = require("__EventDataValidator__/filters")

local function opt_next(t, k)
  if k then return end
  return true, t
end
local function opt_pairs(t)
  if type(t) == "table" then
    return next, t
  else
    return opt_next, t
  end
end

local events_to_ignore = {
  -- generated - all events with 0 fields besides name and tick
  --<ignore_event>
  [defines.events["{{event_name}}"]] = true,
  --</ignore_event>
}

local old_script = script
local new_script = {}
function new_script.on_event(event, f, filters)
  if f then
    if events_to_ignore[event] then
      return old_script.on_event(event, f) -- can't ever have filters
    end

    local filterer

    for _, e in opt_pairs(event) do
      local validator = validators[e]

      if filters then -- has filters
        filterer = filterer or filterers.generate_filter(filters)
        return old_script.on_event(e, function(data)
          local mod_name = data.mod_name
          if mod_name then
            local entity, entity_type = validator(data, mod_name) -- the validator returns the entity and it's type for anything that can be filtered
            if not filterer(entity, entity_type) then return end
          end
          return f(data) -- make it a tail call
        end, filters)

      else -- no filters
        return old_script.on_event(e, function(data)
          local mod_name = data.mod_name
          if mod_name then
            validator(data, mod_name)
          end
          return f(data) -- make it a tail call
        end)
      end
    end
  else -- unsubscribe
    return old_script.on_event(event, nil)
  end
end
setmetatable(new_script, {
  __index = old_script,
  __newindex = function(t, k, v)
    old_script[k] = v
  end
})
script = new_script
