return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = false,
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				styles = {
					comments = "italic",
					conditionals = "italic",
					constants = "NONE",
					functions = "italic",
					keywords = "italic",
					numbers = "NONE",
					operators = "italic",
					strings = "NONE",
					types = "italic",
					variables = "NONE",
				},
			},
		})

		vim.cmd("colorscheme carbonfox") -- load colorscheme

		-- Force undercurl on diagnostics (herdr doesn't advertise terminal capabilities)
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				for _, sev in ipairs({ "Error", "Warn", "Info", "Hint" }) do
					local hl = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. sev })
					hl.underline = nil
					hl.undercurl = true
					vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. sev, hl)
				end
			end,
			once = true,
		})
	end,
}
