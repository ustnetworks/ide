local keymap = vim.keymap
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save

--Buffer related
vim.keymap.set("n", "<leader>n", ":bn<cr>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "Go to next buffer in buffer list" })
-- vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "Unload buffer and delete buffer" })

-------------------------------------------------------------------------------
----------------------------------------TERMINAL MAPS--------------------------
-------------------------------------------------------------------------------
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
keymap.set("n", "<leader>td", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.cmd(":startinsert")
end, { desc = "[Terminal] [D]own" })

keymap.set("n", "<leader>tr", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("L")
	vim.cmd(":startinsert")
end, { desc = "[Terminal] [L]eft" })

keymap.set("n", "<leader>ts", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
	vim.cmd(":startinsert")
end, { desc = "[Terminal] [Small]" })

-------------------------------------------------------------------------------
----------------------------------------LSP------------------------------------
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function()
		keymap.set("n", "<leader>ld", function()
			vim.lsp.buf.definition()
		end, { desc = "Go to [D]efinition" })
		keymap.set("n", "<leader>lr", function()
			vim.lsp.buf.references()
		end, { desc = "List [R]eferences" })
		keymap.set("n", "<leader>ln", function()
			vim.lsp.buf.rename()
		end, { desc = "[R]ename [R]eferences" })

		keymap.set("n", "<leader>lx", function()
			vim.cmd(":Trouble diagnostics toggle filter.buf=0")
		end, { desc = "Diagnostics (Buffer)" })

		keymap.set("n", "<leader>lX", function()
			vim.cmd(":Trouble diagnostics toggle")
		end, { desc = "Diagnostics (All)" })

		keymap.set("n", "<leader>ls", function()
			vim.cmd(":Trouble symbols toggle")
		end, { desc = "Document Symbols" })

		keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format()
		end, { desc = "[F]ormat Document" })

		keymap.set("n", "<leader>lv", function()
			config = vim.diagnostic.config()
			vim.diagnostic.config({ virtual_text = not config.virtual_text })
		end, { desc = "Diagnostic virtual text" })
	end,
})

--Scrolling:
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line/block down" })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line/block up" })
-- vim.cmd("nnoremap <A-j> :m .+1<CR>==")
-- vim.cmd("nnoremap <A-k> :m .-2<CR>==")
-- vim.cmd("inoremap <A-j> <Esc>:m .+1<CR>==gi")
-- vim.cmd("inoremap <A-k> <Esc>:m .-2<CR>==gi")
-- vim.cmd("vnoremap <A-j> :m '>+1<CR>gv=gv")
-- vim.cmd("vnoremap <A-k> :m '<-2<CR>gv=gv-")

keymap.set({ "n", "v" }, "-", function()
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end, { desc = "Open File Explorer" })
