  -- Portable package manager for LSP servers, DAP servers, linters, and formatters
return {{
  'williamboman/mason.nvim',
  dependencies = {
    -- bridges mason.nvim with the lspconfig plugin
    'williamboman/mason-lspconfig.nvim',
    -- LSP client configurations for various LSP servers
    'neovim/nvim-lspconfig',
    'ibhagwan/fzf-lua',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- lsp, treesitter 兩者需要的語言要連動
      ensure_installed = {
        "lua_ls",       -- lua
        "ts_ls",        -- typescript
        -- "volar",        -- vue
        "intelephense", -- php
        "pyright",       -- python
      },
    })

    local lspconfig = require('lspconfig')

    -- local util = require('lspconfig.util')

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })
    lspconfig.ts_ls.setup({})
    -- lspconfig.volar.setup({})
    lspconfig.intelephense.setup({
      -- 原本是想讓一般 php 也可以在根目錄偵測，但是看起來會跟 composer.json 衝突
      -- root_dir = util.root_pattern("composer.json", ".git", "./"),
    })
    lspconfig.pyright.setup({})

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
    })

    vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

    local fzf = require('fzf-lua')
    local fzf_utils = require('fzf-lua.utils')
    local keymap = vim.keymap.set
    local options = { silent = true }

    local lsp_workspace_symbols_visual = function()
      fzf.lsp_workspace_symbols({ lsp_query = fzf_utils.get_visual_selection() })
    end

    keymap('n', '<Leader>d', vim.diagnostic.open_float, options) -- 顯示錯誤訊息
    keymap('n', '[d', vim.diagnostic.goto_prev, options) -- 跳到上一個錯誤
    keymap('n', ']d', vim.diagnostic.goto_next, options) -- 跳到下一個錯誤
    keymap('n', '<Leader>r', fzf.lsp_document_symbols, options)  -- 顯示文件內的符號
    -- keymap('n', '<Leader>t', fzf.lsp_live_workspace_symbols, options)
    -- keymap('v', '<Leader>t', lsp_workspace_symbols_visual, options)
    keymap('n', 'K', vim.lsp.buf.hover, options)
    -- keymap('n', '<Leader>mr', vim.lsp.buf.rename, options) -- 該功能需付費
    keymap('n', '<Leader>mf', fzf.lsp_references, options)
    keymap('n', '<Leader>a', vim.lsp.buf.code_action, options)
    keymap('n', 'gd', fzf.lsp_definitions, options)

  end,
}}
