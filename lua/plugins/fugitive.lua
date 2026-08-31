return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gv', vim.cmd.Git, { desc = 'Open [G]it [V]iew' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = '[G]it [P]ull' })
    vim.keymap.set('n', '<leader>go', '<cmd>Git pull origin main<CR>', { desc = '[G]it pull [O]rigin main' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git push<CR>', { desc = '[G]it Push' })
    vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<CR>', { desc = '[G]it [F]etch' })
    local function is_rebasing()
      local git_dir = ''
      if vim.fn.exists('*FugitiveGitDir') == 1 then
        git_dir = vim.fn.FugitiveGitDir()
      end
      if git_dir == '' then
        local out = vim.trim(vim.fn.system('git rev-parse --git-dir'))
        if vim.v.shell_error == 0 and out ~= '' then
          git_dir = out
        end
      end
      if git_dir == '' then
        return false
      end
      return vim.fn.isdirectory(git_dir .. '/rebase-merge') == 1
        or vim.fn.isdirectory(git_dir .. '/rebase-apply') == 1
    end

    vim.keymap.set('n', '<leader>gc', function()
      if is_rebasing() then
        vim.notify('Cannot commit: repository is currently rebasing', vim.log.levels.ERROR)
        return
      end
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(":Git commit -n -m ''<Left>", true, false, true),
        'n',
        false
      )
    end, { desc = '[G]it [C]ommit' })

    vim.keymap.set('n', '<leader>ga', function()
      if is_rebasing() then
        vim.notify('Cannot commit: repository is currently rebasing', vim.log.levels.ERROR)
        return
      end
      vim.cmd('Git commit -n --amend --no-edit')
    end, { desc = '[G]it Commit [A]mend' })

    vim.keymap.set('n', '<leader>ge', function()
      if is_rebasing() then
        vim.notify('Cannot commit: repository is currently rebasing', vim.log.levels.ERROR)
        return
      end
      vim.cmd('Git commit -n --amend')
    end, { desc = '[G]it Commit am[E]nd message' })
    vim.keymap.set('n', '<leader>gu', function()
      local branch = vim.trim(vim.fn.system('git rev-parse --abbrev-ref HEAD'))
      local sha = vim.trim(vim.fn.system('git rev-parse HEAD'))
      local upstream = vim.trim(vim.fn.system('git rev-parse --abbrev-ref --symbolic-full-name @{push}'))
      local remote = (vim.v.shell_error == 0 and upstream:match('^([^/]+)/')) or 'origin'
      vim.cmd('Git push ' .. remote .. ' ' .. sha .. ':refs/heads/' .. branch .. ' -f --no-verify')
    end, { desc = '[G]it [U]npushed push (force, no-verify)' })

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
