local keymap = vim.keymap
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk
keymap.set("n", "<leader>be", ":vsp<cr>:term python %:p<cr>", { desc = "Execute run.bat shell script" })
--Buffer related
vim.keymap.set("n", "<leader>bn", ":bn<cr>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>bp", ":bp<cr>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>bx", ":bd<cr>", { desc = "Unload buffer and delete buffer" })
vim.keymap.set("n", "<leader>bq", ":bd<cr>", { desc = "Quit Window. Prompt for unsaved" })
vim.keymap.set("n", "<leader>bc", ":bp|bd#<cr>", { desc = "Delete buffer and move previous one buffer" })
vim.keymap.set("n", "<leader>bw", ":w<cr>", { desc = "Write current buffer" })
vim.keymap.set("n", "<leader>by", ":set wrap!<cr>", { desc = "Toggle line wrapping" })
vim.keymap.set("n", "<leader>bz", ":tabedit %<cr>", { desc = "Zen Mode Enter - new tab" })
vim.keymap.set("n", "<leader>br", ":tabclose<cr>", { desc = "Zen Mode exit - close tab tab" })
-- Prevent deleting from also copying
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true })
-------------------------------------------------------------------------------
----------------------------------------TERMINAL MAPS--------------------------
-------------------------------------------------------------------------------
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

local create_terminal_keymap = function(term_type)
	local desc = "Put [T]erminal window on the [R]ight"
	local leader_key = "<leader>tr"
	local move_to_wincmd = "L" --move to the right
	local is_mini = false
	local vim_mode = { "n" }
	if term_type == "MINI" then
		is_mini = true
		desc = "Put [M]ini terminal at the bottom"
		leader_key = "<leader>tm"
		move_to_wincmd = "J"
	end
	if term_type == "LEFT" then
		desc = "Put [T]erminal window on the [L]eft"
		leader_key = "<leader>tl"
		move_to_wincmd = "H"
	end

	if term_type == "TOP" then
		desc = "Put [T]erminal window on [T]op"
		leader_key = "<leader>tt"
		move_to_wincmd = "K"
	end
	if term_type == "BOTTOM" then
		desc = "Put [T]erminal window on the [B]ottom"
		leader_key = "<leader>tb"
		move_to_wincmd = "J"
	end
	keymap.set(vim_mode, leader_key, function()
		vim.cmd.vnew()
		vim.cmd.term()
		vim.cmd.wincmd(move_to_wincmd)
		vim.cmd(":startinsert")
		if is_mini then
			vim.api.nvim_win_set_height(0, 10)
		end
	end, { desc = desc })
end
create_terminal_keymap("TOP", "")
create_terminal_keymap("BOTTOM", "")
create_terminal_keymap("LEFT", "")
create_terminal_keymap("RIGHT", "")
create_terminal_keymap("MINI", "")


-------------------------------------------------------------------------------
----------------------------------------LSP------------------------------------
-------------------------------------------------------------------------------

--Scrolling:
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set({ "n", "v" }, "-", function()
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end, { desc = "Open File Explorer" })

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
			local config = vim.diagnostic.config() or true
			vim.diagnostic.config({ virtual_text = not config.virtual_text })
		end, { desc = "Diagnostic virtual text" })
	end,
})
