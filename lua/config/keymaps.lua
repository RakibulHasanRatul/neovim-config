local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- splits shortcurts
map("n", "<leader>sv", "<C-w>v<C-w>l", { desc = "Split vertically and move right" })
map("n", "<leader>sh", "<C-w>s<C-w>j", { desc = "Split horizontally and move down" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
map("n", "<leader>so", "<cmd>only<CR>", { desc = "Close other splits" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down (Visual mode)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered while scrolling/searching
map("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Paste over without losing yank (legendary remap)
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Yank to system clipboard only when using <leader>y / Y
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete without affecting yank register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole" })

-- Disable Q (Ex mode)
map("n", "Q", "<nop>", { desc = "Disabled Ex mode" })

-- Search and replace current word
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word" })

-- Make current file executable
map("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Re-indent a paragraph and return
map("n", "=ap", "ma=ap'a", { desc = "Re-indent paragraph" })

-- Quick save
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Clear search highlighting
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlighting" })

-- Quick quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving" })
