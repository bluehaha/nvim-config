-- map leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- auto complete menu option
vim.opt.mouse = '' -- don't allow the mouse to be used in Nvim
vim.opt.visualbell = true -- Use visual bell (no beeping)
-- vim.opt.clipboard = 'unnamedplus' -- use system clipboard

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.wrap = false -- no wrap lines
vim.opt.linebreak = true --- Break lines at word (requires Wrap lines)
vim.opt.showbreak = '+++' --- Wrap-broken line prefix
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true  -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint
vim.opt.scrolloff = 10

-- Searching
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- fold
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 20


-- Custom setting for different file type
vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    command = "setlocal noexpandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "js", "javascript", "json", "vue", "css", "html", "pug", "scss", "yml", "lua" },
    command = "setlocal sw=2 sts=2 ts=2"
})
