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

    --  使用範例：
    -- :Ag "function"           " 在當前目錄搜尋 "function"
    -- :Ag "function" src/      " 在 src/ 目錄搜尋 "function"
    -- :Ag function             " 無引號也可以（單個詞）
    vim.api.nvim_create_user_command('Ag', function(opts)
      local args_str = opts.args or ''
      local search_term = ''
      local cwd = nil

      -- 處理引號包圍的搜尋詞
      local quoted_pattern = [["([^"]*)"]] -- 雙引號
      local single_quoted_pattern = [['([^']*)']] -- 單引號

      local match = args_str:match(quoted_pattern)
      if not match then
        match = args_str:match(single_quoted_pattern)
      end

      if match then
        search_term = match
        -- 移除引號部分，取得剩餘的參數作為路徑
        local remaining = args_str:gsub([["[^"]*"]], ''):gsub([['[^']*']], ''):gsub('^%s+', ''):gsub('%s+$', '')
        if remaining ~= '' then
          cwd = remaining
        end
      else
        -- 沒有引號的情況，按空格分割
        local args = vim.split(args_str, ' ', { trimempty = true })
        search_term = args[1] or ''
        cwd = args[2] or nil
      end

      fzf.grep_project({
        search = search_term,
        cwd = cwd
      })
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

