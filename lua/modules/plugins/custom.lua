local custom = {}

custom["mg979/vim-visual-multi"] = {
	lazy = false,
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
	lazy = false,
	config = require("custom.interestingwords"),
}

custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.todo-comments"),
}

custom["jinh0/eyeliner.nvim"] = {
	lazy = false,
	event = "VeryLazy",
	config = require("custom.eyeliner"), -- Require that config
}

return custom
