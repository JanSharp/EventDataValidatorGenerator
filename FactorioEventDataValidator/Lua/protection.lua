
local validators = require("__{{mod_name}}__/validators.lua")
local filterers = require("__{{mod_name}}__/filters.lua") -- stupid name, but who cares :)
local filter_type_map = filterers.type_map

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

local original_handlers = {}

local old_script = script
local new_script = {}

function new_script.on_event(event, f, filters)
  if f then
    if events_to_ignore[event] then
      return old_script.on_event(event, f, filters) -- i'll just add filters, because why not
    end

    local filterer

    for _, e in opt_pairs(event) do
      if type(e) == "string" then
        old_script.on_event(e, f) -- custom-inputs. (can't have filters)
      else
        local validator = validators[e]
        original_handlers[e] = f

        if filters then -- has filters
          filterer = filterer or filterers.generate_filter(filters)
          return old_script.on_event(e, function(data)
            local mod_name = data.mod_name
            if mod_name then
              local entity, entity_type = validator(data, mod_name) -- the validator returns the entity and it's type for anything that can be filtered
              if not filterer(entity, entity_type, filter_type_map) then return end
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
    end
  else -- unsubscribe
    for _, e in opt_pairs(event) do
      original_handlers[e] = nil -- i think it's faster to just not check the type and index with strings setting that to nil too. but also, who cares
    end
    return old_script.on_event(event, nil)
  end
end

function new_script.set_event_filter(event, filters)
  if type(event) ~= "number" then error("set_event_filter only takes numbers as arg #1 (event).") end
  script.on_event(event, original_handlers[event], filters)
end

setmetatable(new_script, {
  __index = old_script,
  __newindex = function(t, k, v)
    old_script[k] = v
  end
})
script = new_script
