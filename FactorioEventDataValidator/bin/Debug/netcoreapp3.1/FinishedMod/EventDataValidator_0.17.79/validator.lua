
local validators = require("__EventDataValidator__/validators")

local function validate(data)
  local source_mod_name = data.mod_name
  if not source_mod_name then return end
  return validators[data.name](data, "The mod " .. source_mod_name)

  -- local level = 2
  -- local info
  -- while true do
  --   level = level + 1
  --   info = debug.getinfo(level, "n")
  --   if not info then return true end -- no raise_event found, it's valid
  --   if info.namewhat == "C" and info.name == "raise_event" then
  --     info = debug.getinfo(level + 1, "S")
  --     local source_mod_name = string.match(info.short_src, "__(.+)__/")
  --     if source_mod_name then
  --       source_mod_name = "The mod " + source_mod_name
  --     else
  --       source_mod_name = "Something (like the console?)"
  --     end
  --     -- might get in here even if the current event technically isn't raised because of a raise_event call
  --     -- test and fix later
  --     return validators[data.name](data, source_mod_name)
  --   end
  -- end
end

local old_script = script
local new_script = {}
function new_script.on_event(event, f, filters)
  log(event)
  if f then
    old_script.on_event(
      event,
      function(data)
        validate(data)
        f(data)
      end,
      filters)
  else
    old_script.on_event(event, nil)
  end
end
setmetatable(new_script, {
  __index = old_script,
  __newindex = function(t, k, v)
    old_script[k] = v
  end
})
script = new_script
