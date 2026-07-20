return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				side = "right",
				width = 50,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						symlink = "",
						git = {
							unstaged = "~",
							staged = "+",
							unmerged = "",
							renamed = ">",
							untracked = "●",
							deleted = "x",
							ignored = "◌",
						},
					},
				},
			},
		git = {
			enable = true,
		},
		filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = {},
			},
			actions = {
				open_file = {
					quit_on_open = false,
					window_picker = {
						enable = true,
					},
				},
			},
		})
	end,
}
