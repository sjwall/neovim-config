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
    if string.sub(hostname, -6) == '.local' then
      hostname = string.sub(hostname, 1, #hostname - 6)
    end
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

  if config and type(config[name]) ~= 'boolean' then
    return config[name]
  end

  return nil
end

function M.is_enabled(name)
  local config = M.get_config()
  if config and config[name] ~= nil then
    return config[name] ~= false
  else
    vim.notify('[config_loader] Missing ' .. name, vim.log.levels.WARN)
  end
  return true
end

return M
