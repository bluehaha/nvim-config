return {{
  'vim-test/vim-test',
  keys = {
    { '<Leader>t', "<Cmd>TestNearest<CR>" },
    { '<Leader>T', "<Cmd>TestFile<CR>" },
    { '<Leader>l', "<Cmd>TestLast<CR>" },
  },
  config = function()
    vim.g['test#basic#start_normal'] = 1
  end
}}
