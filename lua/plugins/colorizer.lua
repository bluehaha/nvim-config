return {{
  -- color highlighter to show color codes in files
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}}
