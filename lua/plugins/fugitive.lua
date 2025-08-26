return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gv', vim.cmd.Git, { desc = 'Open Git [V]iew' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = 'Git [P]ull' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git push<CR>', { desc = '[G]it Push' })
    vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<CR>', { desc = 'Git [F]etch' })
    vim.keymap.set('n', '<leader>gc', ":Git commit -n -m '", { desc = 'Git [C]ommit' })

    vim.keymap.set('n', '<leader>gss', '<cmd>Git stash push<CR>', { desc = 'Git [S]tash [P]ush' })
    vim.keymap.set('n', '<leader>gsp', '<cmd>Git stash pop 0<CR>', { desc = 'Git [S]tash [P]op 0' })
    vim.keymap.set('n', '<leader>gsa', '<cmd>Git stash apply 0<CR>', { desc = 'Git [A]pply 0' })

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
    vim.keymap.set('n', '<leader>gma', '<cmd>Git merge --abort<CR>', { desc = 'Git [M]erge [A]bort' })
    vim.keymap.set('n', '<leader>gmc', '<cmd>Git merge --continue<CR>', { desc = 'Git [M]erge [C]ontinue' })

    vim.keymap.set('n', '<leader>grm', '<cmd>Git rebase main<CR>', { desc = 'Git [R]ebase [M]ain' })
    vim.keymap.set('n', '<leader>gra', '<cmd>Git rebase --abort<CR>', { desc = 'Git [R]ebase [A]bort' })
    vim.keymap.set('n', '<leader>grc', '<cmd>Git rebase --continue<CR>', { desc = 'Git [R]ebase [C]ontinue' })
  end,
}
