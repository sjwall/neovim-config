vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  command = '%s/\\s\\+$//e',
  desc = 'Trim trailing whitespace before saving',
})
