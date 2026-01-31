vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " "
vim.g.netrw_liststyle = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false -- Don't show the mode, since it's already in status line
vim.opt.clipboard = "unnamedplus"
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
-- vim.opt.undofile = true
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { eol = "⏎", tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 10
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.foldcolumn = "1"
vim.opt.termguicolors = true⏎
vim.opt.foldlevel = 99
-- sets the default border for all floating windows
vim.o.winborder = "rounded"

-- turn one virtual_line line by line
-- vim.diagnostic.config({
-- 	virtual_text = { current_line = true, virtual_lines = true },
-- })
-- vim.diagnostic.config({ virtual_lines = { current_line = true } })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
--
-- nvim-treesitter:
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "javascript", "html", "css", "c", "bash", "markdown" },
	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- folds, provided by Neovim
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		-- indentation, provided by nvim-treesitter
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.o.timeoutlen = 1000
