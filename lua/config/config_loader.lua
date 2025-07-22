local M = {}

local config_cache = nil

local function load_config(path)
  local ok, config = pcall(require, path)
  -- if not ok then
  -- vim.notify('Failed to load ' .. path .. '.lua: ' .. config, vim.log.levels.ERROR)
  -- end
  return ok, config
end

function M.get_config()
  if config_cache then
    return config_cache
  end

  local ok, config = load_config('config.config')

  if not ok then
    local hostname = vim.fn.hostname()
    ok, config = load_config('config.config_' .. hostname)
  end

  if not ok then
    _, config = load_config('config.config_default')
  end

  config_cache = config
  return config
end

function M.get_item_config(name)
  local config = M.get_config()

  if config and config[name] and config[name] ~= false then
    return config[name]
  end

  return nil
end

function M.is_enabled(name)
  return M.get_item_config(name) ~= nil
end

return M
