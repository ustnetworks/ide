local M = {}

vim.api.nvim_create_user_command("MyInstallMasonPackage", function(args)
	M.InstallMyMasonPackage(args["args"])
end, { desc = "Install Mason Package(s)", nargs = "*" })

vim.api.nvim_create_user_command("MyInitVSCode", function(args)
	M.InitVSCode(args["args"])
end, { desc = "Init .vscode launch file", nargs = "*" })

M.InstallMyMasonPackage = function(package)
	local pkgs = {
		"eslint-lsp", -- Language Server Protocol implementation for ESLint (JavaScript static code analysis).
		"eslint_d", -- improve eslint performance
		"lua-language-server", -- LSP
		"prettierd", -- Formatter for CSS, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
		"pyright", -- LSP for python
		"ruff", -- LSP + Linter for python
		"stylua", -- Formatter for Lua
		"typescript-language-server", --TypeScript & JavaScript Language Server
	}
	if package then
		return vim.cmd("MasonInstall " .. package)
	end
	for _, value in ipairs(pkgs) do
		vim.cmd("MasonInstall " .. value)
	end
end

M.GetPythonPath = function()
	local cmd = "which python"
	print("hereerererererer")
	if vim.fn.has("win32") == 1 then
		cmd = "where python"
	end
	local paths = vim.fn.system(cmd)
	for line in paths:gmatch("([^\n]*)\n?") do
		if string.len(line) then
			return line
		end
	end
end

M.InitVSCode = function(path)
	if path == nil or path == "" then
		path = vim.fn.getcwd()
	end

	local python = [[

{
    "$schema": "https://raw.githubusercontent.com/mfussenegger/dapconfig-schema/master/dapconfig-schema.json",
    "version": "0.2.0",
    "configurations": [
        {
            "type": "python",
            "request": "launch",
            "name": "Debug Current Buffer",
            "program":"${file}",
            "cwd" : "${workspaceFolder}"
        }
    ]
}
]]
	if vim.fn.has("win32") == 1 then
		path = path .. "\\.vscode\\"
		vim.fn.system("mkdir " .. path)
	else
		path = path .. "/.vscode/"
		vim.fn.system("mkdir -p " .. path)
	end
	path = path .. "launch.json"
	print("Path is:" .. path)
	local file = io.open(path, "w")
	if file then
		file:write(python)
		file:close()
	else
		print("ERROR: Writing " .. path)
	end
end

return M
