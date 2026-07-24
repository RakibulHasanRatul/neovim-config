return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				enabled = true,
				width = 60,
				preset = {
					keys = {
						{ key = "e", desc = "Open File Explorer", action = ":Neotree toggle" },
						{ key = "n", desc = "New Buffer", action = ":ene | startinsert" },
						{ key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{
							key = ".",
							desc = "Scratch Buffer",
							action = function()
								Snacks.scratch()
							end,
						},
						{ key = "u", desc = "Update Plugins", action = ":Lazy update" },
						{ key = "q", desc = "Quit", action = ":qa" },
					},
					header = {
						"      ███████████           █████      ██                    ",
						"     ███████████             █████                            ",
						"     ████████████████ ███████████ ███   ███████    ",
						"    ████████████████ ████████████ █████ ██████████████  ",
						"   █████████████████████████████ █████ █████ ████ █████  ",
						" ██████████████████████████████████ █████ █████ ████ █████ ",
						"██████  ███ █████████████████ ████ █████ █████ ████ ██████",
						"██████   ██  ███████████████   ██ █████████████████",
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},
}
