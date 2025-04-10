-- remove trailing whitespace before saving buffer
local whitespace = vim.api.nvim_create_augroup('whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = whitespace,
  command = [[:%s/\s\+$//e]],
})
