return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = { 'davidmh/cspell.nvim' },
  cond = function()
    success = pcall(vim.fn.system, { 'npx', '--no-install', 'cspell', '--help' })
    return success and vim.v.shell_error == 0
  end,
  opts = function(_, opts)
    local cspell = require('cspell')
    opts.sources = opts.sources or {}
    table.insert(
      opts.sources,
      cspell.diagnostics.with({
        prefer_local = 'node_modules/.bin',
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      })
    )
    table.insert(
      opts.sources,
      cspell.code_actions.with({
        prefer_local = 'node_modules/.bin',
      })
    )
  end,
}
