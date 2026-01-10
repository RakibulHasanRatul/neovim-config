return {
	"nvim-mini/mini.splitjoin",
	version = false,
	event = "InsertEnter",
	config = function()
		require("mini.splitjoin").setup()
	end,
}
