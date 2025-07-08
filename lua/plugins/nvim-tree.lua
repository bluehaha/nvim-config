return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvimTree = require("nvim-tree")
    local api = require("nvim-tree.api")

    nvimTree.setup({
      renderer = {
        icons = {
          show = {
            file = false,
          },
          glyphs = {
            folder = {
              arrow_closed = '▸',
              arrow_open = '▾',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
          }
        },
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      }
    })

    -- change color of folder
    vim.cmd([[
      highlight NvimTreeFolderName guifg=#4FC1FF
      highlight NvimTreeOpenedFolderName guifg=#4FC1FF
      highlight NvimTreeEmptyFolderName guifg=#4FC1FF
    ]])

    -- open nvim-tree by default
    -- local function open_nvim_tree()
    --   require("nvim-tree.api").tree.open()
    -- end
    -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

    -- map tree toggle
    vim.keymap.set('n', '<Leader>b', '<Cmd>NvimTreeToggle<CR>' )
    -- preview file
    vim.keymap.set('n', 'go', api.node.open.preview)
  end,
}
