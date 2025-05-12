require("options")
require("keymaps")
require("config.lazy")
require("my")
--Testing Area SAFE to DELETES
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
