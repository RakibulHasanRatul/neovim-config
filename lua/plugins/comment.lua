return {
	{
		"nvim-mini/mini.comment",
		event = "InsertEnter",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "InsertEnter",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
