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

return {
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
			},
		},
	},
}
