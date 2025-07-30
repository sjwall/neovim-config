return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap')
    end,
  },
  {
    'sjwall/react-native-devtools.nvim',
    dir = require('../utils/directory').exists_or_nil('/workspaces/react-native-devtools-nvim'),
    build = ':RNDevToolsBuild',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
