return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local nvim_treesitter = require("nvim-treesitter")
		nvim_treesitter.install({
			"python",
			"c",
			"cpp",
			"java",
			"bash",
			"javascript",
			"typescript",
			"lua",
			"rust",
			"fish",
			"yaml",
			"dockerfile",
			"desktop",
			"gitignore",
			"git_config",
			"json",
			"jsx",
			"tsx",
		})

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "<filetype>" },
            callback = function()
                vim.treesitter.start()
            end,
        })

        -- Enable incremental selection with Treesitter
        -- Press <Enter> in Normal/Visual mode to start/expand selection progressively
        local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
        if ok and ts_configs then
            ts_configs.setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",        -- Start selection
                        node_incremental = "<CR>",      -- Expand to next node
                        node_decremental = "<BS>",       -- Shrink (backspace)
                    },
                },
            })
        end
	end,
}
