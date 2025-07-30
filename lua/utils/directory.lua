local M = {}

function M.exists(path)
  local f = io.open(path, 'r')
  if f then
    io.close(f)
    return true
  end
  return false
end

function M.exists_or_nil(path)
  return M.exists(path) and path or nil
end

return M
