-- Leader key (set this FIRST before any keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show sign column (prevents text shift when signs appear)
vim.opt.signcolumn = "yes"

-- Mouse (keep vim registers separate from system clipboard)
vim.opt.mouse = "a"

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4 -- default for all files
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Unless search has uppercase
vim.opt.incsearch = true -- Show matches as you type

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.wrap = true
vim.opt.breakindent = true -- Wrapped lines preserve indentation
vim.opt.showmode = false -- Don't show mode (status line shows it)
vim.opt.pumheight = 10 -- Max items in completion popup

-- Splits
vim.opt.splitright = true -- Vertical splits go right
vim.opt.splitbelow = true -- Horizontal splits go below

-- Files & Backup
vim.opt.swapfile = false -- No swap files
vim.opt.backup = false -- No backup files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Performance
vim.opt.updatetime = 250 -- Faster completion & git signs
vim.opt.timeoutlen = 300 -- Faster key sequence completion

-- Better completion experience
vim.opt.completeopt = "menu,menuone,noselect"

-- auto session options
vim.o.sessionoptions = "buffers,curdir,tabpages,winpos,winsize,localoptions"

-- Disable netrw completely
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
