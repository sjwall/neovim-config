return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Open Git [S]taging' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = 'Git [P]ull' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git push<CR>', { desc = '[G]it Push' })

    vim.keymap.set('n', '<leader>gcm', '<cmd>Git checkout main<CR>', { desc = 'Git [C]heckout [M]ain' })
    vim.keymap.set('n', '<leader>gcb', '<cmd>Git checkout -b ', { desc = 'Git [C]heckout new [b]ranch' })

    vim.keymap.set('n', '<leader>gmm', '<cmd>Git merge main<CR>', { desc = 'Git [M]erge [M]ain' })

    vim.keymap.set('n', '<leader>grm', '<cmd>Git rebase main<CR>', { desc = 'Git [R]ebase [M]ain' })
  end,
}
