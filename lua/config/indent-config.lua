vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"lua",
		"tsx",
		"jsx",
		"c",
		"cpp",
		"cxx",
		"h",
		"hpp",
		"hxx",
		"cuda",
		"objc",
		"objcpp",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})
