local util = {}

--- The utils functions
if jit ~= nil then
  util.is_windows = jit.os == 'Windows'
else
  util.is_windows = package.config:sub(1, 1) == '\\'
end

util.get_separator = function()
  if util.is_windows then
    return '\\'
  end
  return '/'
end

util.path_join = function(...)
  local separator = util.get_separator()
  return table.concat({ ... }, separator)
end

return util
