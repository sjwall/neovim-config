local directory = require('../utils/directory')
return {
  'sjwall/react-native-directory.nvim',
  dir = directory.exists_or_nil('/mnt/ssd1/projects/react-native-directory.nvim'),
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>sD', '<CMD>Telescope rnd<CR>', { desc = '[S]earch React Native [D]irectory' })
  end,
}
