return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				-- Use nice arrow-like separators
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { "neo-tree", "alpha", "lazy", "dashboard" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { { "mode" } },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						-- path = 1, -- relative path
						symbols = {
							readonly = "  ",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					{ "location" },
					{
						function()
							return os.date("%H:%M")
						end,
						icon = " ",
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "neo-tree", "lazy", "fugitive" },
		})
	end,
}
