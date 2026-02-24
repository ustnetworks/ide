return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		log_level = vim.log.levels.DEBUG,
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_fix" },
			javascript = { "prettierd", stop_after_first = true },
			html = { "prettierd" },
			css = { "prettierd" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 2500 },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
