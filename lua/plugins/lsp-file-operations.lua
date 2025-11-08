return {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neo-tree/neo-tree.nvim",
	},
	event = "InsertEnter",
	config = function()
		require("lsp-file-operations").setup()
	end,
}
