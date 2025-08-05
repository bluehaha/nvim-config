-- remove trailing whitespace before saving buffer
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

-- disable auto-reload of nvim config files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.expand("~") .. "/.config/nvim/**/*.lua",
  callback = function()
    -- do nothing to prevent auto-reload
  end,
})
