return {
  'mbbill/undotree',
  config = function()
    require('which-key').add({
      {
        '<leader>u',
        vim.cmd.UndotreeToggle,
        desc = '[U]ndotree',
        icon = '󰣜',
      },
    })
  end,
}
