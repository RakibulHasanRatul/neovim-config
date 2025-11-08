return {
	"rmagatti/auto-session",
	event = "VimEnter",
	opts = {
		auto_save = true,
		auto_restore = true,
		suppressed_dirs = {
			vim.fn.expand("~") .. "/Downloads/",
			vim.fn.expand("~") .. "/Music/",
			vim.fn.expand("~") .. "/Desktop/",
			vim.fn.expand("~") .. "/Videos/",
			vim.fn.expand("~") .. "/Templates/",
			vim.fn.expand("~") .. "/Pictures/",
		},
		bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
	},
}
