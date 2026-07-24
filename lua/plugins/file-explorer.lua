return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim",
	},
	opts = function(_, opts)
		local Snacks = require("snacks")
		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end
		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
	end,
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
