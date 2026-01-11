return {
	"nvim-mini/mini.surround",
	version = false,
	event = "InsertEnter",
	config = function()
		require("mini.surround").setup()
	end,
}
