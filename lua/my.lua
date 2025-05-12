function InstallMyMasonPackages(package)
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
	for key, value in ipairs(pkgs) do
		vim.cmd("MasonInstall " .. value)
	end
end

function GetPythonPath()
	local cmd = "which python"
	if vim.fn.has("win32") == 1 then
		cmd = "where python"
	end
	local paths = vim.fn.system(cmd)
	for line in paths:gmatch("([^\n]*)\n?") do
		if string.len(line) then
			print(line)
			return line
		end
	end
end

function InitVSCode(path)
	if not path then
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
	file = io.open(path, "w")
	file:write(python)
	file:close()
end
