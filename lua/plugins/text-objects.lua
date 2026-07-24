return {
	"nvim-mini/mini.ai",
	event = "InsertEnter",
	version = false,
	config = function()
		require("mini.ai").setup({
			mappings = {
				around_next = "<leader>!an",
				inside_next = "<leader>!in",
				around_last = "<leader>!al",
				inside_last = "<leader>!il",
			},
		})
	end,
}
