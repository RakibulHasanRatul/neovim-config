return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local nvim_treesitter = require("nvim-treesitter")
		nvim_treesitter.install({
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
			"jsx",
			"tsx",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "<filetype>" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
