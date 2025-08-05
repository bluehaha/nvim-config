vim.keymap.set('n', 's', ':w<CR>')
vim.keymap.set('n', 'qq', ':qall<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')
vim.keymap.set('n', '<Space>', ':nohlsearch<CR>')
vim.keymap.set('n', '<Leader>dt', ':bp|bd #<CR>:q<CR>')
-- copy to clipboard
vim.keymap.set('v', '<Leader>y', '"*y')
-- move lines up and down using ctrl+[jk]
vim.keymap.set('n', '<C-K>', ':m-2<CR>')
vim.keymap.set('n', '<C-J>', ':m+<CR>')
vim.keymap.set('v', '<C-K>', ":m'<-2<CR>`>my`<mzgv`yo`z")
vim.keymap.set('v', '<C-J>', ":m'>+<CR>`<my`>mzgv`yo`z")
-- buffer
vim.keymap.set('n', '<C-H>', ':bprevious<CR>') -- previous buffer
vim.keymap.set('n', '<C-L>', ':bnext<CR>')     -- next buffer
vim.keymap.set('n', '<Leader>w', ':bp|bd #<CR>') -- go to previous buffer & close the last buffer

-- toggle cspell
vim.keymap.set('n', '<Leader>cs', function()
  local null_ls = require("null-ls")
  local sources = null_ls.get_sources()
  local cspell_active = false

  for _, source in ipairs(sources) do
    if source.name == "cspell" then
      cspell_active = true
      break
    end
  end

  if cspell_active then
    null_ls.disable("cspell")
    print("CSpell disabled")
  else
    null_ls.enable("cspell")
    print("CSpell enabled")
  end
end, { desc = "Toggle CSpell" })
