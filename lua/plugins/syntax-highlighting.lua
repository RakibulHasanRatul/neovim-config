return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
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
			},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		})
	end,
}
