return {{
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup({
      map_c_h = true,
      ignored_next_char = "" -- don't ignore any char
		})
  end,
}}
