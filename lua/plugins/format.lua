return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		-- Install formatters via Mason
		vim.api.nvim_create_autocmd("User", {
			pattern = "MasonToolsUpdateCompleted",
			callback = function()
				vim.schedule(function()
					local registry = require("mason-registry")
					local formatters = { "ruff", "stylua", "prettier" }
					for _, formatter in ipairs(formatters) do
						if not registry.is_installed(formatter) then
							vim.cmd("MasonInstall " .. formatter)
						end
					end
				end)
			end,
		})
	end,
}
