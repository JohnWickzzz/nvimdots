local custom = {}

custom["mg979/vim-visual-multi"] = {
	lazy = true,
	-- event = "BufRead",
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
	config = require("custom.nvim-java"),
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
						require("java").setup()
					end,
				},
			},
		},
	},
	opts = {},
}

return custom
