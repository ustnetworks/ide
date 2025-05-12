return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	event = "VeryLazy",
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
	end,
	config = function()
		require("ufo").setup({
			--TODO: add tet here
			provider_selector = function(bufnr, filetype, buftype)
				return { "lsp", "indent" }
			end,
		})
	end,
}
