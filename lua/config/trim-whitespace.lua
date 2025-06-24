-- autocmd to trim trailing whitespaces on exit insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = { "*" },
  command = "%s/\\s\\+$//e",
})

