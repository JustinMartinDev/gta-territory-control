-- Create copy of object
local function deep_copy(object)
  if type(object) ~= 'table' then return object end

  local result = {}
  for key, value in pairs(object) do
      result[key] = deep_copy(value)
  end
  return result
end

-- Spread function to merge two objects
function spreadObject(template, override)
  if not override then
      return function(override)
          spread(template, override)
      end
  end

  local mt = getmetatable(template)
  local result = {}
  setmetatable(result, mt)

  for key, value in pairs(template) do
      result[key] = deep_copy(value)
  end

  -- No longer wrapped up inside a function
  for key, value in pairs(override) do
      result[key] = value
  end

  return result
end

function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

function tofloat(value)
  if type(value) ~= 'number' then
    print("Invalid conversion to float for", value)
    return value;
  end

  return value + 0.0
end

  