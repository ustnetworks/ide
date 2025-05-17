return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.move").setup()
		require("mini.indentscope").setup()
		require("mini.files").setup()
	end,
}
