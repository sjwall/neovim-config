return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup()

    vim.keymap.set('n', '<leader>hA', function()
      harpoon:list():prepend()
    end, { desc = 'Prepend' })
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'add' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon show list' })

    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():select(1)
    end, { desc = 'Select buffer 1' })
    vim.keymap.set('n', '<leader>hj', function()
      harpoon:list():select(2)
    end, { desc = 'Select buffer 2' })
    vim.keymap.set('n', '<leader>hk', function()
      harpoon:list():select(3)
    end, { desc = 'Select buffer 3' })
    vim.keymap.set('n', '<leader>hl', function()
      harpoon:list():select(4)
    end, { desc = 'Select buffer 4' })
    vim.keymap.set('n', '<leader>hH', function()
      harpoon:list():replace_at(1)
    end, { desc = 'Set buffer 1' })
    vim.keymap.set('n', '<leader>hJ', function()
      harpoon:list():replace_at(2)
    end, { desc = 'Set buffer 2' })
    vim.keymap.set('n', '<leader>hK', function()
      harpoon:list():replace_at(3)
    end, { desc = 'Set buffer 3' })
    vim.keymap.set('n', '<leader>hL', function()
      harpoon:list():replace_at(4)
    end, { desc = 'Set buffer 4' })
  end,
}
