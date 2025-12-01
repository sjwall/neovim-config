return {
  'vuki656/package-info.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  ft = { 'json' },
  keys = {
    {
      '<leader>i',
      desc = 'Package [I]nfo',
    },
    {
      '<leader>it',
      desc = 'Package Info [T]oggle',
      cmd = function()
        require('package-info').toggle()
      end,
      silent = true,
    },
    {
      '<leader>iu',
      desc = 'Package Info [U]pdate',
      cmd = function()
        require('package-info').update()
      end,
      silent = true,
    },
    {
      '<leader>iv',
      desc = 'Package Info Change [V]ersion',
      cmd = function()
        require('package-info').change_version()
      end,
      silent = true,
    },
  },
}
