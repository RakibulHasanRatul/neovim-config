return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",

				-- use underline indicator
				indicator = {
					style = "underline",
				},

				-- Diagnostics with icons
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,

				-- Show diagnostics indicator after filename (errors and warnings only)
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or "")
						if sym ~= "" then
							s = s .. sym .. n
						end
					end
					return s
				end,

				-- Neo-tree offset
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},

				-- UI Settings
				separator_style = "thin", -- "slant" | "slope" | "thick" | "thin"
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				color_icons = true,

				-- filter out empty direcotry buffers
				custom_filter = function(buf_number, buf_numbers)
					local bufname = vim.fn.bufname(buf_number)
					local buftype = vim.fn.getbufvar(buf_number, "&buftype")

					-- Hide empty [No Name] buffers
					if bufname == "" and buftype == "" then
						return false
					end

					-- Hide directory buffers
					if vim.fn.isdirectory(bufname) == 1 then
						return false
					end

					return true
				end,
			},
		})

		-- Keymaps
		local opts = { noremap = true, silent = true }

		-- <leader>Tab to go to next buffer
		vim.keymap.set("n", "<leader><Tab>", "<cmd>BufferLineCycleNext<cr>", opts)

		-- <leader>Shift-Tab to go to previous buffer
		vim.keymap.set("n", "<leader><S-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts)

		-- <leader>tx to close current buffer
		vim.keymap.set("n", "<leader>tx", "<cmd>bdelete<cr>", opts)

		-- Optional but useful: <leader>tp to pin/unpin buffer
		vim.keymap.set("n", "<leader>tp", "<cmd>BufferLineTogglePin<cr>", opts)
	end,
}
