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
    cond = function()
      success = pcall(vim.fn.system, { 'npx', '--help' })
      return success and vim.v.shell_error == 0
    end,
    build = 'chmod +x build.sh && ./build.sh',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
