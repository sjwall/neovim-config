return {
  'nvim-java/nvim-java',
  cond = function(self)
    if require('config.config_loader').is_enabled(self.name) then
      local scan = require('plenary.scandir')
      local matches = scan.scan_dir(vim.loop.cwd(), {
        search_pattern = '%.java$',
        depth = 1e3,
        hidden = false,
        add_filter = function(entry)
          -- ignore anything under node_modules
          return not vim.startswith(entry, 'node_modules')
        end,
      })
      return #matches > 0
    end
    return false
  end,
  config = function()
    require('java').setup()
    vim.lsp.enable('jdtls')
  end,
}
