local M = {}

vim.api.nvim_create_user_command("MyFind", function(args)
	local builtin = require("telescope.builtin")
	local cwd = args["args"]
	builtin.find_files({ cwd = cwd })
end, { desc = "Find Files in the provided directory", nargs = "*", complete = "file" })

vim.api.nvim_create_user_command("MyTreesitter", function()
	M.MyTreesitter()
end, { desc = "Setup treesiter", nargs = "*" })

vim.api.nvim_create_user_command("MyInstallMasonPackage", function(args)
	M.InstallMyMasonPackage(args["args"])
end, { desc = "Install Mason Package(s)", nargs = "*" })

M.MyTreesitter = function()
	local parsers = { "python", "javascript", "lua", "bash", "c", "html", "css", "markdown" }
	for _, value in ipairs(parsers) do
		vim.cmd("TSInstall " .. value)
	end
end

M.InstallMyMasonPackage = function(package)
	local pkgs = {
		"eslint-lsp", -- Language Server Protocol implementation for ESLint (JavaScript static code analysis).
		"eslint_d", -- improve eslint performance
		"lua-language-server", -- LSP
		"prettierd", -- Formatter for CSS, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
		"css-lsp", -- CSS
		"ty", -- LSP for python
		"ruff", -- LSP + Linter for python
		"stylua", -- Formatter for Lua
		"typescript-language-server", --TypeScript & JavaScript Language Server
		"bash-language-server", --Bash shell
	}
	for _, value in ipairs(pkgs) do
		print("installing....=" .. value)
		vim.cmd("MasonInstall " .. value)
	end
end

return M
