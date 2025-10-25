return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000, -- Load first
	config = function()
		require("nightfox").setup({
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = false, -- Disable setting background
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				colorblind = {
					enable = false, -- Enable colorblind support
					simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
					severity = {
						protan = 0, -- Severity [0,1] for protan (red)
						deutan = 0, -- Severity [0,1] for deutan (green)
						tritan = 0, -- Severity [0,1] for tritan (blue)
					},
				},
				styles = {
					comments = "italic", -- Soft hint, easy on eyes
					conditionals = "italic,underline", -- 'if', 'else', etc. stand out with subtle underline emphasis
					constants = "bold", -- Constants deserve weight, not italics
					functions = "italic,bold", -- Makes functions pop elegantly
					keywords = "italic", -- 'return', 'for', 'import' look distinct but not loud
					numbers = "NONE", -- Numbers don’t need styling
					operators = "NONE", -- Too frequent, no styling keeps it clean
					strings = "italic", -- Adds a nice "soft text" tone to strings
					types = "italic,bold", -- Type names look solid but slightly stylized
					variables = "NONE", -- Let colors handle distinction
				},
				inverse = { -- Inverse highlight for different types
					match_paren = false,
					visual = false,
					search = false,
				},
				modules = { -- List of various plugins and additional options
					-- ...
				},
			},
			palettes = {},
			specs = {},
			groups = {},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme carbonfox")
	end,
}
