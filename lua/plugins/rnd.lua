return {
  'sjwall/react-native-directory.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>sD', '<CMD>Telescope rnd<CR>', { desc = '[S]earch React Native [D]irectory' })
  end,
}
