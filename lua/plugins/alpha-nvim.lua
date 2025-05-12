return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		-- local dashboard = require("alpha.themes.startify")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[           ▄ ▄                   ]],
			[[       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ]],
			[[       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ]],
			[[    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ]],
			[[  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ]],
			[[  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄]],
			[[▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █]],
			[[█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █]],
			[[    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("<c-n>", "  > Toggle file explorer", "<cmd>Neotree<CR>"),
			dashboard.button("<leader>sf", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("<leader>sg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			--      dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}