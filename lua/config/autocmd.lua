-- remove trailing whitespace before saving buffer
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

-- set PHP commentstring to use // instead of /* */
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})
