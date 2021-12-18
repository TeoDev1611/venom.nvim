local M = {}
local util = require 'venom.util'
local log = require 'venom.thunder.log'

M.path = vim.fn.expand '<sfile>:p:h:h'
M.python = util.path_join(M.path, 'python', 'venom.py')

M.config = {
  opts = { 'pipenv' },
}

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

  if type(opt) ~= 'string' then
    log:log('fatal', 'The type is necessary a string')
    return
  end

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

M.run = function(opt)
  if type(opt) ~= 'string' then
    log:log('fatal', 'The option type is necessary a string')
  end

  for i = 1, table.getn(M.config.opts) do
    if M.config.opts[i] == 'pipenv' then
      if opt == 'pipenv' then
        return ' -p'
      end
    else
      log:log('fatal', 'Other option not found only pipenv supported actually')
    end
  end
end

return M
