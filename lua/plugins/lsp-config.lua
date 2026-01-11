return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
		-- LSP file operations support
		{
			"antosha417/nvim-lsp-file-operations",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "InsertEnter",
		},
		{
			"mfussenegger/nvim-jdtls", -- required for jdtls
		},
	},
	config = function()
		-- Helper function to detect Python venv
		local function get_python_path()
			local venv_names = { ".venv", "venv", "env", ".env" }
			for _, name in ipairs(venv_names) do
				local path = vim.fn.getcwd() .. "/" .. name .. "/bin/python"
				if vim.fn.executable(path) == 1 then
					return path
				end
			end
			return nil
		end

		-- Helper function to skip system-wide installations for tools
		local function skip_if_system_wide_tools(tools)
			local mason_registry = require("mason-registry")
			return vim.tbl_filter(function(tool_name)
				local ok, pkg = pcall(mason_registry.get_package, tool_name)
				if not ok then
					return true
				end
				-- Check if any executable from this package exists on PATH
				for _, exe in ipairs(pkg.spec.bin or {}) do
					if vim.fn.executable(exe) == 1 then
						return false
					end
				end
				return true
			end, tools)
		end

		-- Helper function to skip system-wide installations for LSP servers
		local function skip_if_system_wide_lsp(servers)
			local mason_registry = require("mason-registry")
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
			end, servers)
		end

		-- LspAttach autocommand for keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = vim.keymap.set

				-- Navigation
				map("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "[G]oto [D]efinition" })
				map("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
				map("n", "gi", vim.lsp.buf.implementation, { buffer = event.buf, desc = "[G]oto [I]mplementation" })
				map("n", "gr", vim.lsp.buf.references, { buffer = event.buf, desc = "[G]oto [R]eferences" })
				map("n", "gt", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "[G]oto [T]ype Definition" })

				-- Document symbols
				map(
					{ "n", "v" },
					"gO",
					require("telescope.builtin").lsp_document_symbols,
					{ buffer = event.buf, desc = "Open Document Symbols" }
				)

				-- Workspace symbols
				map(
					{ "n", "v" },
					"gW",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					{ buffer = event.buf, desc = "Open Workspace Symbols" }
				)

				-- Documentation
				map("n", "<leader>k", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover documentation" })
				map(
					{ "n", "i" },
					"<C-Space>",
					vim.lsp.buf.signature_help,
					{ buffer = event.buf, desc = "Signature help" }
				)

				-- Code actions
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })

				-- Rename
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "[R]e[n]ame" })

				-- Diagnostics
				map("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, { buffer = event.buf, desc = "Previous diagnostic" })
				map("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, { buffer = event.buf, desc = "Next diagnostic" })
				map("n", "<leader>ld", vim.diagnostic.open_float, { buffer = event.buf, desc = "Show diagnostic" })
				map("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = event.buf, desc = "LSP Info" })
				map("n", "<leader>lr", "<cmd>LspRestart<cr>", { buffer = event.buf, desc = "Restart LSP" })

				-- Highlight references under cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Toggle inlay hints
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, { buffer = event.buf, desc = "[T]oggle Inlay [H]ints" })
				end
			end,
		})

		-- Diagnostic configuration
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = true },
			underline = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		-- Get capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- LSP server configurations (cherry-picked the best settings from your config)
		local servers = {
			-- C/C++
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
				},
			},
			-- Python - pyright
			pyright = {
				settings = {
					pyright = {
						disableOrganizeImports = true,
						pythonPath = get_python_path(),
						analysis = {
							typeCheckingMode = "strict",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
							importFormat = "relativeOrAbsolute",
							extraPaths = { "./", "./src", "./packages" },
						},
					},
				},
			},
			-- Ruff for Python linting/formatting
			ruff = {
				init_options = {
					settings = {
						args = {},
						organizeImports = true, -- <-- add this
					},
				},
			},
			-- Java lsp
			jdtls = {},
			-- JavaScript/TypeScript
			ts_ls = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						preferences = {
							importModuleSpecifierPreference = "non-relative",
							jsxAttributeCompletionStyle = "auto",
							includePackageJsonAutoImports = "auto",
						},
						suggest = {
							includeCompletionsForModuleExports = true,
							autoImports = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						preferences = {
							importModuleSpecifierPreference = "non-relative",
							jsxAttributeCompletionStyle = "auto",
							includePackageJsonAutoImports = "auto",
						},
						suggest = {
							includeCompletionsForModuleExports = true,
							autoImports = true,
						},
					},
				},
			},

			-- Tailwind CSS
			tailwindcss = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			},

			-- HTML
			html = {},

			-- CSS
			cssls = {
				filetypes = { "css", "scss", "less" },
			},

			-- JSON
			jsonls = {
				filetypes = { "json", "jsonc" },
			},

			-- Biome (modern alternative to ESLint)
			biome = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"json",
					"jsonc",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
				},
			},

			cspell_ls = {},

			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								"${3rd}/busted/library",
							},
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						format = {
							enable = false, -- Use stylua instead
						},
					},
				},
			},
		}

		-- Tools to install (formatters, linters, etc.)
		local tools = {
			"stylua",
			"clang-format",
			"biome",
			"ruff",
			-- Java
			"google-java-format",
			"checkstyle",
		}

		-- Install tools (skipping system-wide installations)
		require("mason-tool-installer").setup({
			ensure_installed = skip_if_system_wide_tools(tools),
			auto_update = true,
			run_on_start = true,
		})

		-- Setup mason-lspconfig with automatic installation (skipping system-wide)
		require("mason-lspconfig").setup({
			ensure_installed = skip_if_system_wide_lsp(vim.tbl_keys(servers)),
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
