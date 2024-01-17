local custom = {}

custom["mg979/vim-visual-multi"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.vim-visual-multi"), -- Require that config
}

custom["kylechui/nvim-surround"] = {
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}

custom["Mr-LLLLL/interestingwords.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("custom.interestingwords"),
}

custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.todo-comments"),
}

custom["jinh0/eyeliner.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("custom.eyeliner"), -- Require that config
}

custom["nvim-java/nvim-java"] = {
	lazy = true,
	ft = "java",
	config = require("custom.nvim-java"),
	-- event = "LspAttach",
	dependencies = {
		"nvim-java/lua-async-await",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-dap",
		"MunifTanjim/nui.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		{
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				handlers = {
					["jdtls"] = function()
						require("java").setup({
							jdk = {
								auto_install = false,
							},
						})
					end,
				},
			},
		},
	},
	opts = {},
}

custom["akinsho/git-conflict.nvim"] = {
	version = "*",
	event = "VeryLazy",
	config = function()
		require("git-conflict").setup({
			default_mappings = true, -- disable buffer local mapping created by this plugin
			default_commands = true, -- disable commands created by this plugin
			disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
			list_opener = "copen", -- command or function to open the conflicts list
			highlights = { -- They must have background color, otherwise the default color will be used
				incoming = "DiffAdd",
				current = "DiffText",
			},
		})
	end,
}

custom["xiyaowong/virtcolumn.nvim"] = {
	event = "VeryLazy",
}

custom["gregorias/coerce.nvim"] = {
	tag = "v0.1.1",
	config = true,
	event = "VeryLazy",
}

custom["yorickpeterse/nvim-window"] = {
	event = "VeryLazy",
	config = function()
		require("nvim-window").setup({
			normal_hl = "DiffAdd",
			hint_hl = "Bold",
			border = "none",
		})
	end,
}

return custom
