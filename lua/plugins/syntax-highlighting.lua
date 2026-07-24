return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").install({
			"python",
			"c",
			"cpp",
			"java",
			"bash",
			"javascript",
			"typescript",
			"lua",
			"rust",
			"fish",
			"yaml",
			"dockerfile",
			"desktop",
			"gitignore",
			"git_config",
			"json",
			"tsx",
		})

		-- Incremental selection: use built-in Neovim 0.12 text objects
		--   an - select parent node
		--   in - select child node
		--   ]n - next node
		--   [n - previous node
		--   ]N - expand to next node
		--   [N - shrink to previous node
	end,
}
