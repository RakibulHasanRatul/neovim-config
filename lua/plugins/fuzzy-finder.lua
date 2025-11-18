return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]ind [F]iles" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[F]ind with [G]rep" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "[F]ind [W]ord under cursor" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[F]ind [H]elp Tags" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "[F]ind [O]ld Files" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				find_command = { "rg", "--files", "--hidden", "--no-ignore", "--no-ignore-parent", "-u" },
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
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
					no_ignore_parent = true,
				},
			},
		})
		telescope.load_extension("fzf")

		-- Set ripgrep as grep program for better search
		vim.opt.grepprg = "rg --vimgrep --smart-case -u --hidden"
		vim.opt.grepformat = "%f:%l:%c:%m"
	end,
}
