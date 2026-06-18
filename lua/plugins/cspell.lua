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

    -- Directories (and their subdirectories) where cspell should be disabled.
    local disabled_prefixes = {
      vim.fn.expand("~/.config/nvim"),
      vim.fn.expand("~/Project/universetech/open-im-server"),
    }

    local function is_disabled(cwd)
      for _, prefix in ipairs(disabled_prefixes) do
        if cwd == prefix or cwd:sub(1, #prefix + 1) == prefix .. "/" then
          return true
        end
      end
      return false
    end

    -- Conditionally setup cspell sources based on the current working directory.
    local function setup_cspell()
      if is_disabled(vim.fn.getcwd()) then
        require("null-ls").setup {
          sources = {}
        }
      else
        require("null-ls").setup {
          sources = {
            cspell.diagnostics.with({ config = config }),
            cspell.code_actions.with({ config = config }),
          }
        }
      end
    end

    setup_cspell()

    -- Re-evaluate when the working directory changes during a session.
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = setup_cspell,
    })
  end
}}
