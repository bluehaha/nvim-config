return {{
  'davidmh/cspell.nvim',
  dependencies = {
    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'williamboman/mason.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "cspell" }, -- `mason-null-ls` will manage `cspell` as a null-ls source
    })

    local config = {
      config_file_preferred_name = 'cspell.json',
      cspell_config_dirs = { "~/.config/" },
    }

    local cspell = require('cspell')
    require("null-ls").setup {
        sources = {
            cspell.diagnostics.with({ config = config }),
            cspell.code_actions.with({ config = config }),
        }
    }
  end
}}
