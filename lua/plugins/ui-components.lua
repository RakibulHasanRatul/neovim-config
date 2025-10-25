return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = {
			{ "<leader>nl", "<cmd>NoiceLog<cr>", desc = "Noice Log" },
			{ "<leader>nh", "<cmd>NoiceHistory<cr>", desc = "Noice History" },
			{ "<leader>nd", "<cmd>NoiceDismiss<cr>", desc = "Dismiss Notifications" },
		},
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true,
					view = "cmdline_popup", -- Classic command line at the bottom
					format = {
						cmdline = { icon = "  " },
						search_down = { icon = "  " },
						search_up = { icon = "  " },
						filter = { icon = "  " },
						lua = { icon = "  " },
						help = { icon = "  " },
					},
				},
				popupmenu = {
					enabled = true,
					backend = "nui", -- Use nui for completion menu
				},
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					progress = {
						enabled = true,
						format = "lsp_progress",
						view = "mini",
					},
					hover = {
						enabled = true,
						silent = false,
					},
					signature = {
						enabled = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = { enabled = true },
				select = { enabled = true },
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")

			notify.setup({
				timeout = 2000, -- disappear quickly
				stages = "fade_in_slide_out",
				render = "minimal",
				fps = 60,

				-- Position bottom-right
				top_down = false, -- flips stack direction
				background_colour = "#000000", -- transparent-ish background
			})

			-- Replace default vim.notify with this one
			vim.notify = notify
		end,
	},
}
