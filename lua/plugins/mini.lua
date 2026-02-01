return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.move").setup()
		require("mini.files").setup()
	end,
}
