return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")

		-- load sessions silently
		vim.api.nvim_create_autocmd("User", {
			pattern = "SessionLoadPre",
			callback = function()
				vim.cmd("silent! %bwipeout!")
			end,
		})

		auto_session.setup({
			log_level = "info",
			auto_restore = true, -- restore automatically
			auto_save = true, -- save automatically
			auto_restore_last_session = false, -- although it is default
			suppressed_dirs = { -- ignore these directories
				vim.fn.expand("~") .. "/Downloads/",
				vim.fn.expand("~") .. "/Music/",
				vim.fn.expand("~") .. "/Desktop/",
				vim.fn.expand("~") .. "/Videos/",
				vim.fn.expand("~") .. "/Templates/",
				vim.fn.expand("~") .. "/Pictures/",
			},
			session_lens = {
				theme = "dropdown",
			},
		})
	end,
}
