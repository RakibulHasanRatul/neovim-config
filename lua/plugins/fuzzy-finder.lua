return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep (search text)" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fg", "<cmd>Telescope git_branches<cr>", desc = "Find Git branches to checkout" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"%.git/",
					"dist/",
					"build/",
					".venv/",
					"__pycache__/",
					"%.lock",
				},
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						preview_cutoff = 120,
					},
					width = 0.87,
					height = 0.80,
					anchor = "CENTER",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
				},
			},
		})
		telescope.load_extension("fzf")

		-- Set ripgrep as grep program for better search
		vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
		vim.opt.grepformat = "%f:%l:%c:%m"
	end,
}
