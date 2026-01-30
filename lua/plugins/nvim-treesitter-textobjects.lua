return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	init = function()
		-- Disable entire built-in ftplugin mappings to avoid conflicts.
		-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
		vim.g.no_plugin_maps = true

		-- Or, disable per filetype (add as you like)
		-- vim.g.no_python_maps = true
		-- vim.g.no_ruby_maps = true
		-- vim.g.no_rust_maps = true
		-- vim.g.no_go_maps = true
	end,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim

				lookahead = true,

				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					-- ['@class.outer'] = '<c-v>', -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				include_surrounding_whitespace = false,
			},
		})
 -- keymaps
                -- You can use the capture groups defined in `textobjects.scm`
                local select = require("nvim-treesitter-textobjects.select").select_textobject

		vim.keymap.set({ "x", "o" }, "af", function()
			select("@function.outer", "textobjects")
		end, { desc = "Around funcion" })
		vim.keymap.set({ "x", "o" }, "if", function()
			select("@function.inner", "textobjects")
		end, { desc = "Inside funcion" })

		vim.keymap.set({ "x", "o" }, "ip", function()
			select("@parameter.inner", "textobjects")
		end, { desc = "Inside parameter" })
		vim.keymap.set({ "x", "o" }, "ap", function()
			select("@parameter.outer", "textobjects")
		end, { desc = "Around parameter" })

		vim.keymap.set({ "x", "o" }, "il", function()
			select("@loop.inner", "textobjects")
		end, { desc = "Inside loop" })
		vim.keymap.set({ "x", "o" }, "al", function()
			select("@parameter.outer", "textobjects")
		end, { desc = "Around loop" })

		vim.keymap.set({ "x", "o" }, "io", function()
			select("@conditional.inner", "textobjects")
		end, { desc = "Inside if statement(condition)" })
		vim.keymap.set({ "x", "o" }, "ao", function()
			select("@conditional.outer", "textobjects")
		end, { desc = "Around if statement(condition)" })

		vim.keymap.set({ "x", "o" }, "ac", function()
			select("@class.outer", "textobjects")
		end, { desc = "Around class" })
		vim.keymap.set({ "x", "o" }, "ic", function()
			select("@class.inner", "textobjects")
		end, { desc = "Inside class" })

                -- You can also use captures from other query groups like `locals.scm`
                vim.keymap.set({ "x", "o" }, "as", function()
                        require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
                end)
	end,
}
