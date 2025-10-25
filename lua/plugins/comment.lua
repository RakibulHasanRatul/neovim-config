return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<C-_>", mode = { "n", "v" }, desc = "Toggle comment" }, -- Ctrl+/ (terminal sees it as Ctrl+_)
			{ "gcc", mode = "n", desc = "Toggle comment line" },
			{ "gc", mode = "v", desc = "Toggle comment" },
			{ "gbc", mode = "n", desc = "Toggle block comment" },
			{ "gb", mode = "v", desc = "Toggle block comment" },
		},
		config = function()
			local comment = require("Comment")
			local ts_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			comment.setup({
				padding = true,
				sticky = true,
				ignore = "^$", -- Ignore empty lines
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = ts_commentstring.create_pre_hook(),
			})

			-- Ctrl+/ toggle comment
			-- Works in normal and visual mode on any Neovim version
			vim.keymap.set({ "n", "v" }, "<C-_>", function()
				if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
					return "<Plug>(comment_toggle_linewise_visual)"
				else
					return "<Plug>(comment_toggle_linewise_current)"
				end
			end, { expr = true, desc = "Toggle comment" })
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
}
