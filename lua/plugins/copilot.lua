return {{
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      suggestion = {
        enable = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-G>',
          prev = '<M-[>',
          next = '<M-]>',
          dismiss = '<M-c>',
        },
      }
    })

    -- for mac
    local suggestion = require('copilot.suggestion')
    local options = { silent = true }
    vim.keymap.set('i', '“', suggestion.prev, options) -- “ = Option + [
    vim.keymap.set('i', '‘', suggestion.next, options) -- ‘ = Option + ]
    vim.keymap.set('i', 'ç', suggestion.dismiss, options) -- ç = Option + c
  end,
}}

