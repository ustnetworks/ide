--ALI: Here is my understanding of this:
--nvim-lspconfig provides configurations for various LSP servers
--mason is the plugin that manages/installs LSP servers, DAP servers, linters, and formatters
--mason-lspconfig  ensures servers installed with mason.nvim are set up with the necessary configuration
--and translate between lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)

return {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	-- 	dependencies = { "williamboman/mason.nvim" },
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"eslint_d",
	-- 			"lua-language-server",
	-- 			"prettierd",
	-- 			"pyright",
	-- 			"ruff",
	-- 			"stylua",
	-- 			"typescript-language-server",
	-- 		},
	-- 	},
	-- },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },

		opts = {},
	},
}
