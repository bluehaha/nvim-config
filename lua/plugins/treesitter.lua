return {{
  -- Tree-sitter is a parser generator tool and an incremental parsing library
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'williamboman/mason.nvim',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      -- lsp, treesitter 兩者需要的語言要連動
      ensure_installed = { "lua", "typescript", "php" },
      sync_install = false,
      highlight = {
        enable = true,
        disable = {
          'vimdoc',
        },
      },
      indent = {
        enable = true,
        disable = {
          'lua',
        },
      },
    })
  end
}}
