return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gv', vim.cmd.Git, { desc = 'Open [G]it [V]iew' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = '[G]it [P]ull' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git push<CR>', { desc = '[G]it Push' })
    vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<CR>', { desc = '[G]it [F]etch' })
    vim.keymap.set('n', '<leader>gc', ":Git commit -n -m '", { desc = '[G]it [C]ommit' })

    vim.keymap.set('n', '<leader>gss', '<cmd>Git stash push<CR>', { desc = '[G]it [S]tash [P]ush' })
    vim.keymap.set('n', '<leader>gsp', '<cmd>Git stash pop 0<CR>', { desc = '[G]it [S]tash [P]op 0' })
    vim.keymap.set('n', '<leader>gsa', '<cmd>Git stash apply 0<CR>', { desc = '[G]it [A]pply 0' })

    vim.keymap.set('n', '<leader>gbm', '<cmd>Git checkout main<CR>', { desc = '[G]it [B]ranch switch [M]ain' })
    vim.keymap.set('n', '<leader>gbn', ':Git checkout -b ', { desc = '[G]it [B]ranch [N]ew' })
    vim.keymap.set('n', '<leader>gbs', ':Git checkout ', { desc = '[G]it [B]ranch [S]witch' })
    vim.keymap.set(
      'n',
      '<leader>gbr',
      ':Git checkout -m <C-R>=system("git branch --show-current")<CR><BS>',
      { desc = '[G]it [B]ranch [R]ename' }
    )

    vim.keymap.set('n', '<leader>gmm', '<cmd>Git merge main<CR>', { desc = '[G]it [M]erge [M]ain' })
    vim.keymap.set('n', '<leader>gma', '<cmd>Git merge --abort<CR>', { desc = '[G]it [M]erge [A]bort' })
    vim.keymap.set('n', '<leader>gmc', '<cmd>Git merge --continue<CR>', { desc = '[G]it [M]erge [C]ontinue' })

    vim.keymap.set('n', '<leader>grm', '<cmd>Git rebase main<CR>', { desc = '[G]it [R]ebase [M]ain' })
    vim.keymap.set('n', '<leader>gra', '<cmd>Git rebase --abort<CR>', { desc = '[G]it [R]ebase [A]bort' })
    vim.keymap.set('n', '<leader>grc', '<cmd>Git rebase --continue<CR>', { desc = '[G]it [R]ebase [C]ontinue' })
  end,
}
