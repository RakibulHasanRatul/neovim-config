return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		event = { "BufReadPre", "BufNewFile" },
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
					},
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local function skip_if_systemwide(tools)
				local mason_registry = require("mason-registry")
				local installed = vim.tbl_filter(function(pkg_name)
					local ok, pkg = pcall(mason_registry.get_package, pkg_name)
					if not ok then
						return false
					end
					-- executable(s) this package would provide
					local executables = pkg.spec.bin or {}
					-- if any executable exists on PATH, skip it
					for _, exe in ipairs(executables) do
						if vim.fn.executable(exe) == 1 then
							return false
						end
					end
					return true
				end, tools)
				return installed
			end

			local wanted_tools = {
				"ruff",
				"stylua",
				"biome",
				"clang-format",
			}

			require("mason-tool-installer").setup({
				ensure_installed = skip_if_systemwide(wanted_tools),
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local mason_registry = require("mason-registry")
			local function skip_if_systemwide(tools)
				return vim.tbl_filter(function(server_name)
					local pkg_name = require("mason-lspconfig").get_mappings().lspconfig_to_package[server_name]
					if not pkg_name then
						return true
					end -- not handled by Mason
					local ok, pkg = pcall(mason_registry.get_package, pkg_name)
					if not ok then
						return true
					end
					for _, exe in ipairs(pkg.spec.bin or {}) do
						if vim.fn.executable(exe) == 1 then
							return false
						end
					end
					return true
				end, tools)
			end

			local wanted_lsp = {
				"pyright",
				"ruff",
				"ts_ls",
				"lua_ls",
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
				"biome",
				"cspell_ls",
				"fish_lsp",
				"clangd",
			}

			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = skip_if_systemwide(wanted_lsp),
				automatic_installation = true,
			})
		end,
	},
}
