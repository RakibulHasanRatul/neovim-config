return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			-- Don't auto-expand anything
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			default_component_configs = {
				git_status = {
					symbols = {
						added = "+",
						modified = "~",
						deleted = "x",
						renamed = ">",
						untracked = "●",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "!",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- Show all files including hidden
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- Only works on Windows
					hide_by_name = {},
					hide_by_pattern = {},
					always_show = {},
					never_show = {},
				},
				follow_current_file = {
					enabled = true, -- Focus on current file when opening
					leave_dirs_open = false, -- Don't auto-expand directories
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "disabled",
				use_libuv_file_watcher = false,
				window = {
					mappings = {
						["<space>"] = "none", -- Disable space (your leader key)
						["<bs>"] = "none", -- Disable backspace navigation
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},

			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = "none", -- Disable space globally in neo-tree
					["<bs>"] = "none", -- Disable backspace globally
					["<cr>"] = "open",
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["a"] = {
						"add",
						config = {
							show_path = "none",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
		})

		-- Key mappings
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })
		vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { silent = true, desc = "Focus Neo-tree" })
	end,
}
