return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>e",
			function()
				local current_buf = vim.api.nvim_get_current_buf()
				local current_filetype = vim.bo[current_buf].filetype
				if current_filetype == "neo-tree" then
					vim.cmd("Neotree close")
				else
					vim.cmd("Neotree reveal")
				end
			end,
			desc = "Toggle file explorer",
		},
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "right",
				width = 50,
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
				},
				git_status = {
					symbols = {
						added = "+",
						deleted = "x",
						modified = "~",
						renamed = ">",
						untracked = "●",
						ignored = "◌",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		})
	end,
}
