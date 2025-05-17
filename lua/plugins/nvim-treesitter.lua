return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"bash",
				"c",
				"python",
				"html",
				"css",
				"javascript",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
			},
			textobjects = {
				enable = false,
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
			-- 		node_incremental = "<leader>si",
			-- 		scope_incremental = "<leader>sc",
			-- 		node_decremental = "<leader>sd",
			-- 	},
			-- },
		})
	end,
}
