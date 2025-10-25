return {
	-- lsp installer
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		},
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	-- mason tool installer
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"ruff", -- Python
					"stylua", -- Lua
					"biome", -- JS/TS/JSON
					"prettier", -- Markdown

					-- Linters
					"pylint", -- Python
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	-- mason lsp config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright", -- Python
					"ruff", -- Python linting/formatting
					"ts_ls", -- TypeScript/JavaScript
					"lua_ls", -- Lua
					"html", -- HTML
					"cssls", -- CSS
					"jsonls", -- JSON
					"tailwindcss", -- Tailwind CSS (for your TSX)
					"biome", -- Biome LSP
					"cspell_ls", -- Code Spell Checker
				},
				automatic_installation = true,
			})
		end,
	},
}
