-- lua/plugins/oil_image_details.lua
local M = {}

M.setup = function(opts)
  opts = opts or {}
  local default_opts = {
    shortcut = '<leader>ii', -- Default shortcut to trigger
    imagemagick_cmd = 'identify', -- Command for ImageMagick
  }
  local config = vim.tbl_deep_extend('force', default_opts, opts)

  local function open_image_details()
    -- Check if oil.nvim is active in the current buffer
    if vim.bo.filetype ~= 'oil' then
      vim.notify('Not in an oil.nvim buffer.', vim.log.levels.INFO)
      return
    end
    local oil = require('oil')

    local entry = oil.get_cursor_entry()
    if not entry then
      vim.notify('Not in an oil.nvim buffer.', vim.log.levels.INFO)
      return
    end

    local dir = oil.get_current_dir()
    local filename = dir .. entry.name

    if not filename or filename == '..' then
      vim.notify('No valid filename highlighted in oil.nvim.', vim.log.levels.WARN)
      return
    end

    local image_extensions = {
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.tiff',
      '.webp',
      '.svg',
      '.ico',
    }
    local is_image = false
    for _, ext in ipairs(image_extensions) do
      if string.match(string.lower(filename), ext .. '$') then
        is_image = true
        break
      end
    end

    if not is_image then
      vim.notify('File is not recognized as an image: ' .. filename, vim.log.levels.WARN)
      return
    end

    -- Execute ImageMagick's identify command
    local cmd = { config.imagemagick_cmd, filename }
    vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        local details = table.concat(data, '\n')
        vim.schedule(function()
          if details:match('^' .. filename .. ': no such file or directory$') then
            vim.notify('ImageMagick could not find the file: ' .. filename, vim.log.levels.ERROR)
            return
          end

          vim.cmd('split')
          vim.cmd('enew')
          vim.cmd('setlocal buftype=nofile nobuflisted bufhidden=hide nospell wrap')
          vim.api.nvim_set_option_value('filetype', 'imagemagick_details', { buf = 0 })
          vim.api.nvim_buf_set_name(0, 'Image Details: ' .. filename)
          local lines = vim.split(details, '\n', { plain = true })
          vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
          vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
          vim.cmd('normal! G')
        end)
      end,
      on_stderr = function(_, data, _)
        vim.schedule(function()
          local err_msg = table.concat(data, '\n')
          if err_msg:match('command not found') then
            vim.notify(
              "Error: imagemagick 'identify' command not found. "
                .. 'Please ensure ImageMagick is installed and in your PATH.',
              vim.log.levels.ERROR
            )
          else
            vim.notify('Error running identify for ' .. filename .. ': ' .. err_msg, vim.log.levels.ERROR)
          end
        end)
      end,
      on_exit = function(_, code, _)
        if code ~= 0 then
          vim.schedule(function()
            vim.notify('Identify command exited with code: ' .. code, vim.log.levels.WARN)
          end)
        end
      end,
    })
  end

  -- Map the shortcut only when oil.nvim is active
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'oil',
    callback = function()
      vim.keymap.set('n', config.shortcut, open_image_details, { buffer = true, desc = 'Open ImageMagick Details' })
    end,
    group = vim.api.nvim_create_augroup('OilImageDetailsKeymap', { clear = true }),
  })
end

return M
