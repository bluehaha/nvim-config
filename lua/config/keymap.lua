vim.keymap.set('n', 's', ':w<CR>')
vim.keymap.set('n', 'q', ':q<CR>')
vim.keymap.set('n', 'qq', ':qall<CR>')
vim.keymap.set('n', '<Space>', ':nohlsearch<CR>')
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
