return {
	"rmagatti/auto-session",
	event = "VimEnter",
	config = function()
		local auto_session = require("auto-session")
		-- silengly close all buffers before loading a session
		vim.api.nvim_create_autocmd("User", {
			pattern = "SessionLoadPre",
			callback = function()
				vim.cmd("silent! %bwipeout!")
			end,
		})
		auto_session.setup({
			log_level = "info",
			auto_session_enable_last_session = false, -- don't auto-load last session globally
			auto_save = true, -- enable auto-save
			auto_restore = true, -- let auto-session handle restoration
			suppress_dirs = {
				vim.fn.expand("~") .. "/Downloads/",
				vim.fn.expand("~") .. "/Music/",
				vim.fn.expand("~") .. "/Desktop/",
				vim.fn.expand("~") .. "/Videos/",
				vim.fn.expand("~") .. "/Templates/",
				vim.fn.expand("~") .. "/Pictures/",
			}, -- don't auto-save in these directories
			session_lens = {
				-- optional: for telescope integration
				theme = "dropdown",
			},
		})
	end,
}
