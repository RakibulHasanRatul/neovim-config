return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} }, -- Better Lua LSP for nvim config
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- LSP keybindings (applied when LSP attaches to buffer)
		local on_attach = function(_, bufnr)
			local map = vim.keymap.set

			-- Navigation
			map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
			map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
			map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
			map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Show references" })
			map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })

			-- Documentation (changed from K to avoid conflict)
			map("n", "<leader>k", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
			map("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })

			-- Code actions
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })

			-- Reanme Symbols
			map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol (workspace-wide)" })

			-- Diagnostics
			map("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, { buffer = bufnr, desc = "Previous diagnostic" })
			map("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, { buffer = bufnr, desc = "Next diagnostic" })
			map("n", "<leader>cd", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })
			map("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = bufnr, desc = "LSP Info" })
			-- Restart LSP
			map("n", "<leader>lr", "<cmd>LspRestart<cr>", { buffer = bufnr, desc = "Restart LSP" })
			-- Format
			map({ "n", "v" }, "<leader>cf", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = bufnr, desc = "Format" })
		end

		-- Enhanced capabilities for autocompletion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic icons
		local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "" }

		-- Diagnostic config
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
			virtual_text = {
				prefix = "●",
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = true, -- Changed from "always" to true (new API)
			},
		})

		-- Helper function to detect venv
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

		-- Configure LSP servers using the new vim.lsp.config API
		-- Python
		vim.lsp.config.pyright = {
			default_config = {
				root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
			},
			settings = {
				pyright = {
					disableOrganizeImports = true, -- for ruff
				},
				python = {
					pythonPath = get_python_path(),
					analysis = {
						typeCheckingMode = "strict",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
						autoImportCompletions = true,
						autoImportExactMatchOnly = true,
						-- stubPath = "typings",
						extraPaths = {
							"./",
							"./src",
							"./packages",
						},
						importFormat = "relativeOrAbsolute",
					},
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- Ruff
		vim.lsp.config.ruff = {
			default_config = {
				root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
				cmd = { "ruff", "server" },
				filetypes = { "python" },
			},
			init_options = {
				settings = {
					args = {},
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- TypeScript/JavaScript
		vim.lsp.config.ts_ls = {
			default_config = {
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			},
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
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- Lua
		vim.lsp.config.lua_ls = {
			default_config = {
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
			},
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
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
						enable = false,
					},
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- HTML
		vim.lsp.config.html = {
			default_config = {
				root_markers = { ".git" },
				cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html" },
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- CSS
		vim.lsp.config.cssls = {
			default_config = {
				root_markers = { ".git" },
				cmd = { "vscode-css-language-server", "--stdio" },
				filetypes = { "css", "scss", "less" },
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- JSON
		vim.lsp.config.jsonls = {
			default_config = {
				root_markers = { ".git" },
				cmd = { "vscode-json-language-server", "--stdio" },
				filetypes = { "json", "jsonc" },
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- Tailwind CSS
		vim.lsp.config.tailwindcss = {
			default_config = {
				root_markers = { "tailwind.config.js", "tailwind.config.ts", ".git" },
				cmd = { "tailwindcss-language-server", "--stdio" },
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
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- CSpell
		vim.lsp.config.cspell = {
			default_config = {
				root_markers = { ".git" },
				cmd = { "cspell-lsp", "--stdio" },
				filetypes = {
					"python",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"css",
					"html",
					"json",
					"yaml",
					"markdown",
					"lua",
					"text",
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- Biome
		vim.lsp.config.biome = {
			default_config = {
				root_markers = {
					"package-lock.json",
					"yarn.lock",
					"pnpm-lock.yaml",
					"bun.lockb",
					"bun.lock",
					"biome.json",
				},
				cmd = { "biome", "lsp-proxy" },
				filetypes = {
					"astro",
					"css",
					"graphql",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"jsonc",
					"svelte",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
					"vue",
				},
			},
			on_attach = function(client, bufnr)
				-- Call the default on_attach first
				on_attach(client, bufnr)

				-- Add organize imports and fix all on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						-- Organize imports
						vim.lsp.buf.code_action({
							context = {
								only = { "source.organizeImports" },
								diagnostics = {},
							},
							apply = true,
						})

						-- Fix all
						vim.lsp.buf.code_action({
							context = {
								only = { "source.fixAll" },
								diagnostics = {},
							},
							apply = true,
						})
					end,
				})
			end,
			capabilities = capabilities,
		}

		-- Enable LSP servers using new API
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("html")
		vim.lsp.enable("cssls")
		vim.lsp.enable("jsonls")
		vim.lsp.enable("tailwindcss")
		vim.lsp.enable("cspell")
		vim.lsp.enable("biome")

		-- Rounded borders for hover and signature help
		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
