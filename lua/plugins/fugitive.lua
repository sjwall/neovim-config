return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Open Git [S]taging' })
    vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', { desc = 'Git [P]ull' })
    vim.keymap.set('n', '<leader>gg', ':Git push<CR>', { desc = '[G]it Push' })

    vim.keymap.set('n', '<leader>gcm', ':Git checkout main<CR>', { desc = 'Git [C]heckout [M]ain' })
    vim.keymap.set('n', '<leader>gcb', ':Git checkout -b ', { desc = 'Git [C]heckout new [b]ranch' })

    vim.keymap.set('n', '<leader>gmm', ':Git merge main<CR>', { desc = 'Git [M]erge [M]ain' })

    vim.keymap.set('n', '<leader>grm', ':Git rebase main<CR>', { desc = 'Git [R]ebase [M]ain' })
  end,
}
