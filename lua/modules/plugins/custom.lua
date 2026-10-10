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

-- quick-scope for nvim, f/F color
-- https://github.com/jinh0/eyeliner.nvim
custom["jinh0/eyeliner.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.eyeliner"), -- Require that config
}

-- https://github.com/nvim-java/nvim-java
-- custom["nvim-java/nvim-java"] = {
-- 	lazy = true,
-- 	ft = "java",
-- 	config = require("custom.nvim-java"),
-- 	-- event = "LspAttach",
-- 	dependencies = {
-- 		"nvim-java/lua-async-await",
-- 		"nvim-java/nvim-java-core",
-- 		"nvim-java/nvim-java-test",
-- 		"nvim-java/nvim-java-dap",
-- 		"nvim-java/nvim-java-refactor",
-- 		"MunifTanjim/nui.nvim",
-- 		"neovim/nvim-lspconfig",
-- 		"mfussenegger/nvim-dap",
-- 		{
-- 			"williamboman/mason.nvim",
-- 			opts = {
-- 				registries = {
-- 					"github:nvim-java/mason-registry",
-- 					"github:mason-org/mason-registry",
-- 				},
-- 			},
-- 		},
-- 		{
-- 			"williamboman/mason-lspconfig.nvim",
-- 			opts = {
-- 				handlers = {
-- 					["jdtls"] = function()
-- 						require("java").setup({
-- 							jdk = {
-- 								auto_install = false,
-- 							},
-- 							verification = {
-- 								duplicate_setup_calls = false,
-- 							},
-- 						})
-- 					end,
-- 				},
-- 			},
-- 		},
-- 	},
-- 	opts = {},
-- }

-- https://github.com/akinsho/git-conflict.nvim/
custom["akinsho/git-conflict.nvim"] = {
	version = "*",
	-- event = "VeryLazy",
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
	dependencies = { "gregorias/coop.nvim" }, -- v5 起的必装依赖
	config = function()
		-- v5 API：setup 只接受 cases；键位不再自动注册，需显式绑定 <Plug>(coerce-*)
		require("coerce").setup()
		-- normal 模式：转换光标下的当前词。gcr 与 cr 同义，用 gcr 的好处是按 g 能看到 which-key 提示
		vim.keymap.set("n", "cr", "<Plug>(coerce-normal)", { desc = "Coerce word" })
		vim.keymap.set("n", "gcr", "<Plug>(coerce-normal)", { desc = "Coerce word" })
		-- visual 模式：转换选中的文本
		vim.keymap.set("x", "gcr", "<Plug>(coerce-visual)", { desc = "Coerce selection" })
		-- motion 模式（要再补一个 motion，如 gcr<case>iw）暂不占键位：<Plug>(coerce-motion) 已注册，需要时自行绑定
		require("coerce").register_case({
			keymap = "l",
			case = function(str)
				return vim.fn.tolower(str)
			end,
			description = "lowercase",
		})
		-- which-key 提示：按下 cr / gcr 后弹出可选的 case 列表（v5 不再自动注册键位，提示也要自己接）
		local wke = require("coerce.keymaps").which_key_expand
		pcall(function()
			require("which-key").add({
				{ "cr", group = "+Coerce word", expand = wke.normal_mode, mode = "n" },
				{ "gcr", group = "+Coerce word", expand = wke.normal_mode, mode = "n" },
				{ "gcr", group = "+Coerce visual", expand = wke.visual_mode, mode = "x" },
			})
		end)
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

-- https://github.com/mistricky/codesnap.nvim
-- command: CodeSnapPreviewOn
custom["mistricky/codesnap.nvim"] = {
	event = "VeryLazy",
	build = "make",
	config = function()
		require("codesnap").setup({
			has_breadcrumbs = true,
			watermark = "JohnWickzzz/nvimdots",
			has_line_number = true,
		})
	end,
}

return custom
