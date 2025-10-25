return {
	"rmagatti/auto-session",
	event = "VimEnter",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			log_level = "info",
			auto_session_enable_last_session = false, -- don't auto-load last session globally
			auto_save_enabled = true, -- enable auto-save
			auto_restore_enabled = false, -- we'll handle directory-specific restore
			auto_session_suppress_dirs = {
				"~/",
				"/",
				"~/Downloads/",
				"~/Music/",
				"~/Desktop/",
				"~/Videos/",
				"~/Templates",
				"~/Pictures/",
			}, -- don't auto-save in this directories
			session_lens = {
				-- optional: for telescope integration
				theme = "dropdown",
			},
		})

		-- Automatically restore session when entering a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local session_path = vim.fn.getcwd() .. "/.local/share/nvim/sessions"
				local session_file = session_path .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") .. ".vim"

				if vim.fn.filereadable(session_file) == 1 then
					vim.cmd("silent! source " .. session_file)
				end
			end,
		})
	end,
}
