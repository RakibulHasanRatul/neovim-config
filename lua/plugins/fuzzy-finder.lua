return {
	-- Snacks Picker (replaces Telescope)
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
		picker = {
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-q>"] = { "qflist_all", mode = { "n", "i" }, desc = "Send all to quickfix" },
					},
				},
			},
		},
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[F]ind with [G]rep",
			},
		},
		config = function(_, opts)
			require("snacks").setup(opts)
		end,
	},
}
