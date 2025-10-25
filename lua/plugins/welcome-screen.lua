return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████
    ]]
		dashboard.section.header.val = vim.split(logo .. "\n" .. os.date(" %Y-%m-%d-%A %H:%M:%S "), "\n")
		local init_path = vim.fn.stdpath("config")
		dashboard.section.buttons.val = {
			dashboard.button("e", "🗁  Open File Explorer", ":Neotree toggle<CR>"),
			dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
			dashboard.button("c", "󰈞  Config", ":cd " .. init_path .. " | e init.lua<CR>"),
			dashboard.button("q", "󰿅  Quit", "<cmd>qa<CR>"),
		}
		vim.api.nvim_set_hl(0, "AlphaLogo", { fg = "#95d3bf" })
		dashboard.section.buttons.opts.hl = "AlphaLogo"
		dashboard.opts.layout[1].val = 4
		return dashboard
	end,
	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		-- load the dashboard
		require("alpha").setup(dashboard.opts)

		-- Show alpha when opening a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("alpha_on_directory", { clear = true }),
			callback = function()
				local buf_number = vim.api.nvim_get_current_buf()
				local bufname = vim.fn.bufname(buf_number)
				local buftype = vim.fn.getbufvar(buf_number, "&buftype")

				if bufname == "" and buftype == "" then
					vim.cmd("ALpha")
				end

				-- Check if we opened with a directory argument
				if vim.fn.isdirectory(bufname) == 1 then
					-- Delete the directory buffer and show alpha
					vim.api.nvim_buf_delete(buf_number, { force = true })
					vim.cmd("Alpha")
				end
			end,
		})

		-- show neovim loading status
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
