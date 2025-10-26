> My personal Neovim configuration — optimized for Python, web, and AI-related development.
> This repo mainly serves as a **personal backup**, but feel free to explore or get inspired!

---

## Overview

This config is built around **Neovim’s Lua-based setup**, focused on:

- **Speed:** Lazy-loaded plugins for snappy startup
- **Simplicity:** Clean structure, minimal bloat
- **Productivity:** Strong LSP, autocompletion, and formatter setup
- **Comfort:** Aesthetic UI + practical keymaps

It’s not meant to be a universal distro, just _my personal flow_ — but if you’re curious, you can clone and tweak it as you like.

---

## Components Used

- **AI integration**: [Windsurf](https://github.com/Exafunction/windsurf.nvim), [Mini AI](https://github.com/echasnovski/mini.ai)
- **Auto Completion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- **Auto Session**: [AutoSession](https://github.com/rmagatti/auto-session)
- **Auto pairs completion**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- **Auto Tag for TS/JS/TSX/JSX/HTML**:[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
- **Buffer Tabs**: [Bufferline](https://github.com/akinsho/bufferline.nvim)
- **Colorizer**: [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua)
- **Colorscheme**: [NightFox](https://github.com/EdenEast/nightfox.nvim)
- **Commenting Control**: [Comment.nvim](https://github.com/numToStr/Comment.nvim), [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- **Diagnostics**: [Trouble](https://github.com/folke/trouble.nvim)
- **Emmet**: [emmet-vim](https://github.com/mattn/emmet-vim)
- **File Explorer**: [NeoTree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **Flash**: [Flash](https://github.com/folke/flash.nvim)
- **Formatter**: [Conform](https://github.com/stevearc/conform.nvim)
- **Fuzzy Finder**: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **Git Integration**: [Gitsigns](https://github.com/lewis6991/gitsigns.nvim), [LazyGit](https://github.com/kdheepak/lazygit.nvim), [Git Conflict](https://github.com/akinsho/git-conflict.nvim), [Diffview](https://github.com/sindrets/diffview.nvim)
- **Indent Guides**: [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- **LSP**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [neodev.nvim](https://github.com/folke/neodev.nvim)
- **LSP File Operations**: [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations)
- **LSP Tool Installer**: [Mason](https://github.com/williamboman/mason.nvim), [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim), [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
- **Match Tag**: [vim-matchtag](https://github.com/leafOfTree/vim-matchtag)
- **Plugin Manager**: [Lazy](https://github.com/folke/lazy.nvim)
- **Statusline**: [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- **Styled Components**: [vim-styled-components](https://github.com/styled-components/vim-styled-components)
- **Surrounds**: [nvim-surround](https://github.com/kylechui/nvim-surround)
- **Symbol Tree**: [Aerial](https://github.com/stevearc/aerial.nvim)
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Tmux Navigation**: [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- **Todo Comments**: [Todo Comments](https://github.com/folke/todo-comments.nvim)
- **UI Components**: [Noice](https://github.com/folke/noice.nvim), [Dressing](https://github.com/stevearc/dressing.nvim), [nvim-notify](https://github.com/rcarriga/nvim-notify)
- **Undo Tree**: [undotree](https://github.com/mbbill/undotree)
- **Show keymaps**: [which-key.nvim](https://github.com/folke/which-key.nvim)
- **Welcome Screen**: [alpha-nvim](https://github.com/goolord/alpha-nvim)

## Installation

You can just clone the repo and start neovim to let the magic happen:

```bash
git clone https://github.com/RakibulHasanRatul/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
nvim
```

---

## Requirements

- **Neovim 0.11+**
- **Git**
- **Nerd Font** (for icons)
- _(Optional)_: Mason will handle most binary dependencies automatically — no system-wide installs needed 😉

---

## Highlights

- **Zero external dependencies** — everything runs inside the config dir
- **Tuned for terminal workflow** (no GUI dependencies)
- **Easily hackable**: Each module is self-contained and rea( able
- **Safe public config:** no personal API keys, secrets, or machine-specific paths

---

## Preview

Not much, showing preview from [my own source](https://github.com/RakibulHasanRatul/scratch-lr)

![Preview](./preview.png)

---

## Note

This config evolves as I )o — expect tweaks, rewrites, and experiments over time.
If you find something cool or notice an issue, feel free to open an issue or PR!

---

## License

MIT — do whatever you want with it. A star ⭐ would be appreciated if it helped you!
