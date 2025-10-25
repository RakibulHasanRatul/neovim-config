return {
	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = vim.keymap.set

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Next git hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Previous git hunk" })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
					map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { buffer = bufnr, desc = "Blame line" })
				end,
			})
		end,
	},
	-- LazyGit: Full Git workflow in Neovim
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit File History" },
			{ "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Current File History" },
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 0.9
			vim.g.lazygit_floating_window_use_plenary = 0

			-- Use neovim remote for opening files from lazygit in nvim
			vim.g.lazygit_use_neovim_remote = 1

			-- Setup diffview integration
			-- When you press 'd' on a commit in lazygit, it opens in diffview
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "lazygit",
				callback = function()
					vim.keymap.set("t", "<C-d>", function()
						vim.cmd("DiffviewOpen")
					end, { buffer = true, desc = "Open Diffview" })
				end,
			})
		end,
	},

	-- Git Conflict management
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
			{ "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
			{ "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
			{ "<leader>gcn", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
			{ "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
			{ "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
		},
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				disable_diagnostics = false,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})
		end,
	},

	-- Diffview: For file/repo history and merge visualization
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed", -- show base + theirs + ours
					},
				},
			})
		end,
	},
}
