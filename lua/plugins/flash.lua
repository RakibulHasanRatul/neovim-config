return {
	"folke/flash.nvim",
	event = "InsertEnter",
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
	config = function()
		require("flash").setup({
			labels = "asdfghjklqwertyuiopzxcvbnm",
			search = {
				multi_window = true,
				forward = true,
				wrap = true,
			},
			jump = {
				jumplist = true,
				pos = "start",
				history = false,
				register = false,
				nohlsearch = false,
				autojump = false,
			},
			label = {
				uppercase = true,
				rainbow = {
					enabled = false,
					shade = 5,
				},
			},
			modes = {
				search = {
					enabled = true,
				},
				char = {
					enabled = false,
				},
			},
		})
	end,
}
