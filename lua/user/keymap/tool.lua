-- 个人工具相关键位
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_callback = bind.map_callback

return {
	-- nvim-tree
	["n|<leader>v"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),

	-- telescope：项目内搜词
	["n|<leader>fw"] = map_callback(function()
		local ok = pcall(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		if not ok then
			require("telescope.builtin").live_grep()
		end
	end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Word in project"),

	-- telescope：查找所有文件（含 ignored / hidden）
	["n|<leader>fa"] = map_callback(function()
		require("telescope.builtin").find_files({
			no_ignore = true,
			hidden = true,
			prompt_title = "Find Files <ALL>",
		})
	end)
		:with_noremap()
		:with_silent()
		:with_desc("find: All file in project"),

	-- Java -> Mapper.xml
	["n|<leader>fx"] = map_callback(function()
		local current_buffer = vim.fn.expand("%:t")
		local target_file = current_buffer:gsub("%.java$", ".xml")
		require("telescope.builtin").find_files({ default_text = target_file })
	end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Mapper.xml in project"),

	-- Mapper.xml -> Java
	["n|<leader>fj"] = map_callback(function()
		local current_buffer = vim.fn.expand("%:t")
		local target_file = current_buffer:gsub("%.xml$", ".java")
		require("telescope.builtin").find_files({ default_text = target_file })
	end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Mapper.java in project"),

	-- dapui：切换调试面板
	["n|<leader>dt"] = map_callback(function()
		require("dapui").toggle({ reset = true })
	end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open UI toggle"),
}
