return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				spelling = { enabled = true },
			},
		})
		-- Register leader key groups
		wk.add({
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>h", group = "Git [H]unk" },
			{ "<leader>t", group = "[T]oggle" },
		})
	end,
}
