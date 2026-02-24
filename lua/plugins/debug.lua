local M = {}

function M.set_keymaps()
	local dap = require("dap")
	local dapui = require("dapui")

	vim.keymap.set("n", "<F1>", function()
		dap.continue()
	end, { desc = "DAP Continue" })
	vim.keymap.set("n", "<F2>", function()
		dap.step_into()
	end, { desc = "DAP Step Into" })
	vim.keymap.set("n", "<F3>", function()
		dap.step_over()
	end, { desc = "DAP Step Over" })
	vim.keymap.set("n", "<F4>", function()
		dap.step_out()
	end, { desc = "DAP Step Out" })
	vim.keymap.set("n", "<F5>", function()
		dap.restart()
	end, { desc = "DAP Restart" })

	vim.keymap.set("n", "<Leader>dk", function()
		require("dap.ui.widgets").hover()
	end, { desc = "Hover" })

	vim.keymap.set("n", "<Leader>du", function()
		dapui.toggle()
	end, { desc = "Toggle Debug UI" })
	vim.keymap.set("n", "<Leader>dq", function()
		dap.terminate()
	end, { desc = "Terminate Debug session" })
	vim.keymap.set("n", "<Leader>db", function()
		dap.toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })
	vim.keymap.set("n", "<Leader>dB", function()
		dap.set_breakpoint()
	end, { desc = "Set Breakpoint" })

	--Helpers
	vim.keymap.set("n", "<Leader>df", function()
		M.create_frappe_launch_json()
	end, { desc = "Create Frappe Launch.json" })

	vim.api.nvim_create_user_command("DebugCurrentFileArgs", function(args)
		M.debug_current_file_args(args)
	end, { desc = "Debug current file w/ or w/o arguments", nargs = "*" })
end

function M.debug_current_file_args(args)
	--<f-args> splits arguments by whitespace by default, but spaces can be embedded by preceding them
	--with a backslash e.g. DebugCurrentFileArgs arg1 arg2 arg\ 3
	local prog_args = args.fargs
	-- local prog_args = vim.split(vim.fn.expand(args.args), "\n")
	print(args.fargs)
	local dap = require("dap")
	dap.run({
		type = "debugpy",
		request = "launch",
		name = "Debug current file w/ or w/o arguments",
		program = "${file}",
		args = prog_args,
	})
end

function M.create_frappe_launch_json()
	local frappe_config = [[
    {
    "version": "0.2.0",
    "configurations": [
        {
                "name": "Bench",
                "type": "python",
                "request": "launch",
                "justMyCode": false,
                "console":"integratedTerminal",
                "program": "${workspaceFolder}/frappe/frappe/utils/bench_helper.py",
                "args": [
                 "frappe", "serve", "--port", "8000", "--noreload", "--nothreading"
                ],
                "cwd": "${workspaceFolder}/../sites",
                "env": {
                 "DEV_SERVER": "1"
                }
            }
        ]
    }

    ]]
	local apps_path = vim.fn.getcwd()
	apps_path = apps_path .. "/.vscode/"
	vim.fn.system("mkdir -p " .. apps_path)
	apps_path = apps_path .. "launch.json"
	local file = io.open(apps_path, "w")
	if file then
		file:write(frappe_config)
		file:close()
		print(apps_path .. " has been created")
	else
		print("ERROR: Writing " .. apps_path)
	end
end

function M.resolve_python_path()
	--[[
    The Algorithm
    1. Start at the Current Working Directory (CWD).
    2. Traverse the directory tree upward.
    3. Search for directories named: env, .env, venv, or .venv.
    4. If found, attempt to execute the Python interpreter within that directory.
    5. Validation: Verify the interpreter by requesting its version.
    6. Fallback: If no virtual environment is found or the interpreter fails the version check, default to the system-wide Python.
    --]]
	local cwd = vim.fn.getcwd()
	local venv_names = { "env", ".env", "venv", ".venv" }

	-- Determine OS-specific path for the python executable
	local is_windows = vim.fn.has("win32") == 1
	local python_bin = is_windows and "Scripts\\python.exe" or "bin/python"

	-- Traverse upward from CWD
	for _, name in ipairs(venv_names) do
		-- Search for the directory upward
		local venv_path = vim.fs.find(name, {
			upward = true,
			stop = vim.loop.os_homedir(),
			path = cwd,
			type = "directory",
		})[1]

		if venv_path then
			local candidate = venv_path .. "/" .. python_bin
			-- Replace forward slashes with backslashes on Windows for consistency
			if is_windows then
				candidate = candidate:gsub("/", "\\")
			end

			-- Check if executable exists
			if vim.fn.executable(candidate) == 1 then
				-- Validate by checking if 'python --version' executes successfully
				local handle = io.popen(candidate .. " --version 2>&1")
				local result = handle:read("*a")
				handle:close()

				if result and result:match("Python") then
					return candidate
				end
			end
		end
	end

	-- Fallback to system-wide python
	return is_windows and "python.exe" or "python3"
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dapvt = require("nvim-dap-virtual-text")
			dapvt.setup({
				commented = true,
			})
			dap.adapters.debugpy = function(cb, config)
				-- Use our common tool function to resolve the path
				cb({
					type = "executable",
					command = M.resolve_python_path(),
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end

			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			M.set_keymaps()
		end,
	},
}
