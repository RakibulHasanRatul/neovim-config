return {
	"folke/todo-comments.nvim",
	dependencies = { "folke/snacks.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<leader>ft",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Find TODOs",
		},
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next TODO",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous TODO",
		},
	},
	config = function()
		require("todo-comments").setup({
			signs = true,
			keywords = {
				FIX = {
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { color = "info" },
				HACK = { color = "warning" },
				WARN = { color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { color = "hint", alt = { "INFO" } },
				TEST = { color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			highlight = {
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
				comments_only = true,
			},
		})
	end,
}
