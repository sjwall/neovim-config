return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Open Git [S]taging' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = 'Git [P]ull' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git push<CR>', { desc = '[G]it Push' })
    vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<CR>', { desc = 'Git [F]etch' })

    vim.keymap.set('n', '<leader>gbm', '<cmd>Git checkout main<CR>', { desc = 'Git [B]ranch switch [M]ain' })
    vim.keymap.set('n', '<leader>gbn', ':Git checkout -b ', { desc = 'Git [B]ranch [N]ew' })
    vim.keymap.set('n', '<leader>gbs', ':Git checkout ', { desc = 'Git [B]ranch [S]witch' })
    vim.keymap.set(
      'n',
      '<leader>gbr',
      ':Git checkout -m <C-R>=system("git branch --show-current")<CR><BS>',
      { desc = 'Git [B]ranch [R]ename' }
    )

    vim.keymap.set('n', '<leader>gmm', '<cmd>Git merge main<CR>', { desc = 'Git [M]erge [M]ain' })

    vim.keymap.set('n', '<leader>grm', '<cmd>Git rebase main<CR>', { desc = 'Git [R]ebase [M]ain' })
    vim.keymap.set('n', '<leader>grc', '<cmd>Git rebase --continue<CR>', { desc = 'Git [R]ebase [C]ontinue' })
  end,
}
