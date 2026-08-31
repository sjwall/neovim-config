return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup({
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
          show_hidden = true,
        },
        -- For git status
        win_options = {
          signcolumn = 'yes:2',
        },
      })

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float)

      -- Open oil on startup if Neovim was launched without file arguments
      vim.api.nvim_create_autocmd('VimEnter', {
        group = vim.api.nvim_create_augroup('oil-startup', { clear = true }),
        desc = 'Open Oil on cwd instead of the intro screen',
        nested = true,
        callback = function()
          -- Bail if content piped stdin or session restore
          if vim.fn.argc() > 0 or vim.g.started_with_stdin then
            return
          end
          -- Bail if content in the buffer
          if vim.api.nvim_buf_get_name(0) ~= '' or vim.bo.modified or vim.api.nvim_buf_line_count(0) > 1 then
            return
          end
          require('oil').open(vim.fn.getcwd())
        end,
      })

      vim.api.nvim_create_autocmd('StdinReadPre', {
        group = 'oil-startup',
        callback = function()
          vim.g.started_with_stdin = true
        end,
      })
    end,
  },
  {
    'refractalize/oil-git-status.nvim',

    dependencies = {
      'stevearc/oil.nvim',
    },

    config = true,
  },
}
