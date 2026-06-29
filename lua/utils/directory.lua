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

-- Returns the directory the given (or current) oil buffer is showing, as an
-- absolute path, or nil when the buffer is not an oil buffer.
function M.oil_buffer_dir(bufnr)
  bufnr = bufnr or 0
  if vim.bo[bufnr].filetype ~= 'oil' then
    return nil
  end
  local oil_path = vim.api.nvim_buf_get_name(bufnr):gsub('^oil://', '')
  if oil_path == '' then
    return nill
  end
  return vim.fn.fnamemodify(oil_path, ':p')
end

return M
