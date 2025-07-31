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
    build = 'chmod +x build.sh && ./build.sh',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
