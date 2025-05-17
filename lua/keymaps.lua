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

-- move current line / block with Alt-j/k similar to vscode.
-- vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move current line/block down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move current line/block up" })
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move current line/block down" })
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move current line/block up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move current line/block down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move current line/block down" })

--Buffer related
vim.keymap.set("n", "<leader>n", ":bn<cr>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "Unload buffer and delete buffer" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>dt", function()
	config = vim.diagnostic.config()
	vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "Toggle Diagnostic virtual text" })

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
