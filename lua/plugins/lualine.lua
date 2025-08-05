return {{
  -- A blazing fast and easy to configure Neovim statusline written in Lua
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'vscode',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            symbols = {
              modified = '+',
            }
          }
        },
        lualine_z = {{
          'tabs',
          mode = 0,
          cond = function()
            return #vim.fn.gettabinfo() > 1
          end,
        }},
      }
    }
  end
}}
