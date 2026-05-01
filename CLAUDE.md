# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration using lazy.nvim as the plugin manager. The configuration is written in Lua and follows a modular structure with separate files for core settings, keymaps, autocmds, and individual plugin configurations.

## Architecture

### Entry Point
- `init.lua` - Main entry point that loads configuration modules in order: basic settings, keymaps, autocmds, and the lazy.nvim plugin manager

### Core Configuration (`lua/config/`)
- `basic.lua` - Core Neovim settings (leader key, UI, tabs, folding, filetype-specific settings)
- `keymap.lua` - Global keybindings and custom shortcuts
- `autocmd.lua` - Auto-commands (e.g., trailing whitespace removal on save)
- `lazy.lua` - Lazy.nvim plugin manager bootstrap and setup

### Plugin System (`lua/plugins/`)
All plugins are auto-loaded from the `lua/plugins/` directory by lazy.nvim. Each plugin file should return a table/array of plugin specifications. Key plugins include:

- `lsp.lua` - LSP configuration via mason.nvim, mason-lspconfig, and nvim-lspconfig
  - Configured LSP servers: lua_ls (Lua), ts_ls (TypeScript), intelephense (PHP)
  - LSP keybindings integrated with fzf-lua for navigation
- `fzf.lua` - Fuzzy finder (fzf-lua) with custom commands `:Ag` and `:BCommits`
- `completion.lua` - nvim-cmp setup with LSP, snippet, buffer, and path sources
- `treesitter.lua` - Syntax highlighting and indentation (Lua, TypeScript, PHP)
- `cspell.lua` - Spell checking via null-ls (disabled in ~/.config/nvim directory)
- `git.lua` - Git integration (gitsigns and vim-fugitive)
- `nvim-tree.lua` - File explorer
- `copilot.lua` - GitHub Copilot integration

## Key Settings

### Indentation
- Default: 4 spaces
- Frontend files (TypeScript, JS, Vue, HTML, CSS, JSON, Lua, TSP): 2 spaces
- Makefiles: tabs (no expansion)

### Leader Key
- Leader: `,`
- Local leader: `,`

### LSP & Treesitter Language Support
Languages must be configured in BOTH lsp.lua and treesitter.lua:
- Currently supported: Lua, TypeScript, PHP

### CSpell Behavior
CSpell is conditionally disabled when working inside `~/.config/nvim` to avoid spell-checking this configuration directory itself.

## Essential Keybindings

### File Operations
- `s` - Save file (`:w`)
- `qq` - Quit all (`:qall`)
- `<Leader>q` - Quit current window
- `<Ctrl-P>` - Fuzzy find files (includes hidden and ignored files via rg)
- `<Ctrl-O>` - Switch buffers
- `<Leader>b` - Toggle file tree

### Buffer Management
- `<Ctrl-H>` - Previous buffer
- `<Ctrl-L>` - Next buffer
- `<Leader>w` - Close current buffer (go to previous)
- `<Leader>dt` - Close buffer and window

### LSP Navigation
- `gd` - Go to definition
- `K` - Show hover documentation
- `<Leader>d` - Show diagnostic float
- `[d` / `]d` - Previous/next diagnostic
- `<Leader>r` - Document symbols
- `<Leader>mf` - Find references
- `<Leader>mi` - Find implementations
- `<Leader>a` - Code actions

### Search & Grep
- `:Ag "search_term" [path]` - Custom grep command using fzf
- `<Leader>g` (visual mode) - Grep selected text
- `<Space>` - Clear search highlighting

### Git
- `<Leader>B` - Git blame
- Current line blame is always visible (via gitsigns)

### Other
- `<Leader>cs` - Toggle CSpell on/off
- `<Ctrl-K>` / `<Ctrl-J>` - Move lines up/down (normal and visual mode)
- `<Leader>y` (visual) - Copy to system clipboard

## Development Commands

### Plugin Management
```bash
# Launch Neovim (plugins auto-install on first run)
nvim

# Inside Neovim, manage plugins:
:Lazy          # Open lazy.nvim UI
:Lazy sync     # Update and install plugins
:Mason         # Open Mason UI for LSP/tools
:TSUpdate      # Update treesitter parsers
```

### LSP & Diagnostics
```vim
:LspInfo       # Show LSP client info
:LspStart      # Start LSP
:LspStop       # Stop LSP
:Mason         # Manage LSP servers
```

### Testing Configuration Changes
After modifying Lua files, restart Neovim or source the file:
```vim
:source %      # Source current file
:source $MYVIMRC  # Reload init.lua
```

## Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Return a plugin specification table:
```lua
return {{
  'author/plugin-name',
  dependencies = { 'dep1', 'dep2' },
  config = function()
    -- Plugin setup
  end,
}}
```
3. Restart Neovim - lazy.nvim will auto-detect and install the plugin

## Adding New LSP Support

1. Add language server to `ensure_installed` in `lua/plugins/lsp.lua`
2. Add parser to `ensure_installed` in `lua/plugins/treesitter.lua`
3. Add `lspconfig.<server>.setup({})` call in `lua/plugins/lsp.lua`
4. Restart Neovim

## Important Notes

- Trailing whitespace is automatically removed on save (BufWritePre autocmd)
- Mouse support is disabled (`vim.opt.mouse = ''`)
- System clipboard is NOT automatically used (clipboard setting is commented out)
- PHP files use `//` for comments instead of `/* */`
