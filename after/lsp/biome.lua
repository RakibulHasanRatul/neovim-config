return {
	filetypes = {
		"astro",
		"css",
		"graphql",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
	},
	-- vim.lsp.enable calls root_dir asynchronously: (bufnr, on_dir) => on_dir(root)
	root_dir = function(bufnr, on_dir)
		on_dir(vim.fs.root(bufnr, { "biome.json", "biome.jsonc", "package.json" }))
	end,
	workspace_required = true,
}
