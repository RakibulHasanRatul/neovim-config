-- Auto-detect and activate virtual environment
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		local venv_names = { ".venv", "venv", "env", ".env" }
		for _, name in ipairs(venv_names) do
			local venv = vim.fn.getcwd() .. "/" .. name
			if vim.fn.isdirectory(venv) == 1 then
				vim.env.VIRTUAL_ENV = venv
				vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
				break
			end
		end
	end,
})
