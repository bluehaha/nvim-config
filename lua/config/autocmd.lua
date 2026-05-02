-- truncate LSP log on startup if it exceeds 10MB (Copilot is a noisy logger)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local log = vim.lsp.get_log_path()
    local stat = vim.uv.fs_stat(log)
    if stat and stat.size > 10 * 1024 * 1024 then
      local f = io.open(log, "w")
      if f then f:close() end
    end
  end,
})

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

-- Go: organize imports + format on save (via gopls)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})
