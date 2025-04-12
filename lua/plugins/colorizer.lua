return {{
  -- color highlighter to show color codes in files
  'norcalli/nvim-colorizer.lua',
  enabled = false,
  config = function()
    require('colorizer').setup()
  end,
}}
