return {
  'petertriho/nvim-scrollbar',
  config = function()
    local colors = require('tokyonight.colors').setup()

    require('scrollbar').setup()
  end,
}
