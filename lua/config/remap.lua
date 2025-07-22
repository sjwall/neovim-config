local wk = require('which-key')
wk.add({
  { '<leader>st', vim.cmd.Ex, desc = '[S]earch tree [V]iew', icon = '' },
  -- Move code up and down
  { 'J', ":m '>+1<CR>gv=gv", mode = 'v' },
  { 'K', ":m '<-2<CR>gv=gv", mode = 'v' },

  -- Center view when going up and down
  { '<C-d>', '<C-d>zz' },
  { '<C-u>', '<C-u>zz' },

  -- Center view when next and previous
  { 'n', 'nzzzv' },
  { 'N', 'Nzzzv' },

  -- Delete the visual selection and replace it with what is in the buffer
  { '<leader>p', [["_dP]], mode = 'x', icon = '󰆒' },

  -- Yank to the system clipboard
  { '<leader>y', [["+y]], mode = { 'n', 'v' }, icon = '󰆒' },
  { '<leader>Y', [["+Y]], icon = '󰆒' },

  -- Find and replace
  { '<leader>r', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]] },

  { '<leader>x', '<cmd>!chmod +x %<CR>', silent = true },

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  { '<Esc>', '<cmd>nohlsearch<CR>' },

  -- Diagnostic keymaps
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic [Q]uickfix list' },

  -- Change indenting
  { '<', '<gv', mode = 'v' },
  { '>', '>gv', mode = 'v' },

  -- Buffers
  { '<TAB>', '<cmd>bn<CR>' },
  { '<S-TAB>', '<cmd>bp<CR>' },
  { '<leader>b', '<cmd>enew|term<CR>' },
  { '<leader>w', '<cmd>noa w<CR>' },

  {
    '<C-x>',
    function()
      -- could use <cmd>bd<CR> but this closes the window as well 👎️
      local current_buf = vim.api.nvim_get_current_buf()
      local current_window = vim.api.nvim_get_current_win()

      local windows = vim.api.nvim_list_wins()
      for _, win_id in ipairs(windows) do
        local win_buf = vim.api.nvim_win_get_buf(win_id)
        if win_buf == current_buf then
          vim.api.nvim_set_current_win(win_id)
          local bufnrs = vim.api.nvim_list_bufs()
          if #bufnrs > 1 then
            vim.cmd('bnext')
          else
            vim.cmd('enew')
          end
        end
      end

      vim.api.nvim_set_current_win(current_window)
      vim.cmd('bd ' .. current_buf)
    end,
    desc = 'Close the current buffer',
    icon = '',
  },

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  { '<Esc><Esc>', '<C-\\><C-n>', mode = 't', desc = 'Exit terminal mode' },

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
  { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
  { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
  { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
  --
  -- terminal
  { '<C-h>', '<cmd>wincmd h<CR>', mode = 't', desc = 'Move focus to the left window' },
  { '<C-l>', '<cmd>wincmd l<CR>', mode = 't', desc = 'Move focus to the right window' },
  { '<C-j>', '<cmd>wincmd j<CR>', mode = 't', desc = 'Move focus to the lower window' },
  { '<C-k>', '<cmd>wincmd k<CR>', mode = 't', desc = 'Move focus to the upper window' },

  -- Resize window
  { '<C-Up>', '<cmd>resize -2<CR>' },
  { '<C-Down>', '<cmd>resize +2<CR>' },
  { '<C-Left>', '<cmd>vertical resize -2<CR>' },
  { '<C-Right>', '<cmd>vertical resize +2<CR>' },

  -- terminal
  { '<C-Up>', '<cmd>resize -2<CR>', mode = 't' },
  { '<C-Down>', '<cmd>resize +2<CR>', mode = 't' },
  { '<C-Left>', '<cmd>vertical resize -2<CR>', mode = 't' },
  { '<C-Right>', '<cmd>vertical resize +2<CR>', mode = 't' },
})
