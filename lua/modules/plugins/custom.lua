local custom = {}

-- https://github.com/mg979/vim-visual-multi
custom["mg979/vim-visual-multi"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.vim-visual-multi"), -- Require that config
}

-- https://github.com/kylechui/nvim-surround
custom["kylechui/nvim-surround"] = {
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = require("custom.nvim-surround"),
}

-- https://github.com/Mr-LLLLL/interestingwords.nvim
custom["Mr-LLLLL/interestingwords.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("custom.interestingwords"),
}

-- https://github.com/folke/todo-comments.nvim
custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.todo-comments"),
}

-- quick-scope for nvim, f/F color
-- https://github.com/jinh0/eyeliner.nvim
custom["jinh0/eyeliner.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("custom.eyeliner"), -- Require that config
}

-- https://github.com/nvim-java/nvim-java
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

-- https://github.com/akinsho/git-conflict.nvim/
custom["akinsho/git-conflict.nvim"] = {
	version = "*",
	event = "VeryLazy",
	config = function()
		require("git-conflict").setup({
			default_mappings = {
				ours = "<leader>gco",
				theirs = "<leader>gct",
				none = "<leader>gc0",
				both = "<leader>gcb",
				next = "<leader>gcn",
				prev = "<leader>gcp",
			}, -- disable buffer local mapping created by this plugin
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

-- vertical line
-- https://github.com/xiyaowong/virtcolumn.nvim
custom["zoriya/virtcolumn.nvim"] = {
	event = "VeryLazy",
}

-- cr key for string word case
-- https://github.com/gregorias/coerce.nvim
custom["gregorias/coerce.nvim"] = {
	event = "VeryLazy",
	config = function()
		require("coerce").setup({
			keymap_registry = require("coerce.keymap").keymap_registry(),
			-- The notification function used during error conditions.
			notify = function(...)
				return vim.notify(...)
			end,
			-- If you don’t like the default cases and modes, you can override them.
			cases = require("coerce").default_cases,
			modes = require("coerce").default_modes,
		})
		require("coerce").register_case({
			keymap = "l",
			case = function(str)
				return vim.fn.tolower(str)
			end,
			description = "lowercase",
		})
	end,
}

-- buffer window jump
-- https://github.com/yorickpeterse/nvim-window
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

-- generate code method comment
-- https://github.com/danymat/neogen
custom["danymat/neogen"] = {
	lazy = true,
	event = "BufReadPre",
	config = true,
	-- config = function()
	-- 	require("neogen").setup({ snippet_engine = "luasnip" })
	-- end,
}

-- https://github.com/nacro90/numb.nvim
-- for :lineNumber show
custom["nacro90/numb.nvim"] = {
	event = "VeryLazy",
	config = true,
}

-- https://github.com/levouh/tint.nvim
custom["levouh/tint.nvim"] = {
	event = "VeryLazy",
	config = function()
		require("tint").setup()
	end,
}

return custom
