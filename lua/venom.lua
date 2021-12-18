local M = {}
local util = require 'venom.util'
local log = require 'venom.thunder.log'

M.path = vim.fn.expand '<sfile>:p:h:h'
M.python = util.path_join(M.path, 'python', 'venom.py')

M.setup = function()
  log:open()
  if vim.fn.executable 'python' ~= 1 then
    log:log('fatal', 'Is necessary python for use this plugin')
    return
  end
end

M.log_path = function()
  log:log('info', string.format('The logger are in %s here you check the logs', log.path))
end

M.checker = function(opt)
  local data = {}
  log:log('info', type(opt))

  if vim.fn.executable 'pipenv' ~= 1 then
    data.pipenv = false
  else
    data.pipenv = true
  end
  if vim.fn.executable 'poetry' ~= 1 then
    data.poetry = false
  else
    data.poetry = true
  end

  if opt == 'table' then
    log:log('info', data)
    return
  end

  if opt == 'msg' then
    for key, value in pairs(data) do
      if type(value) ~= 'string' then
        log:log('info', string.format('Key -> %s || Value -> %s', key, vim.inspect(value)))
        return
      end
      log:log('info', string.format('Key -> %s || Value -> %s', key, value))
      return
    end
  end

  if opt ~= 'msg' or opt ~= 'table' then
    log:log('error', 'This not are a option valid the valid options are msg and table')
    return
  end
end

return M
