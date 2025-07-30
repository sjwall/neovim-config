return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = { 'davidmh/cspell.nvim' },
  cond = function()
    vim.fn.system({ 'npx', '--no-install', 'cspell', '--help' })
    return vim.v.shell_error == 0
  end,
  opts = function(_, opts)
    local cspell = require('cspell')
    opts.sources = opts.sources or {}
    table.insert(
      opts.sources,
      cspell.diagnostics.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      })
    )
    table.insert(opts.sources, cspell.code_actions)
  end,
}
