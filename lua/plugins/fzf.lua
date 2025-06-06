return {{
  'ibhagwan/fzf-lua',
  dependencies = { 
    { "junegunn/fzf", build = "./install --bin" }
  },
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      winopts = {
        preview = {
          vertical = 'down:50%',
          horizontal = 'right:50%',
        },
      },
      keymap = {
        builtin = {
          false,
          ['<C-_>'] = 'toggle-preview', -- ctrl + /
          ['<C-b>'] = 'preview-page-up',
          ['<C-f>'] = 'preview-page-down',
        },
      },
      fzf_opts = {
        ['--layout'] = false,
      },
      files = {
        git_icons = false,
        file_icons = false,
      },
      grep = {
        git_icons = false,
        file_icons = false,
      },
      lsp = {
        jump1 = true, -- if only one options, jump to it
      }
    })

    vim.api.nvim_create_user_command('Ag', function(opts)
      fzf.grep_project({ search = opts.args })
    end, { bang = true, nargs = '?' })

    vim.api.nvim_create_user_command('BCommits', function(opts)
      fzf.git_bcommits({ query = opts.args })
    end, { bang = true, nargs = '?' })

    local keymap = vim.keymap.set
    local options = { silent = true }
    -- 設置 <C-P> 快捷鍵以使用 fzf-lua 搜索檔案，並自定義使用 rg 命令
    vim.keymap.set('n', '<C-P>', function()
      require('fzf-lua').files({
        cmd = 'rg --color=never --files --hidden --follow --no-ignore'
      })
    end, options)
    keymap('n', '<C-O>', fzf.buffers, options)
    keymap('v', '<Leader>g', fzf.grep_visual, options)
    keymap('i', '<C-x><C-f>', fzf.complete_file, options)
  end,
}}

