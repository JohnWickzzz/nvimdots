-- 个人编辑相关键位
local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cu = bind.map_cu

return {
	-- Insert 模式下 <C-f> 右移光标（与 <C-b> 对称）
	["i|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Move cursor to right"),

	-- hop.nvim：<leader>j 让给 Jump 分组，行跳转改为 <leader>jl
	["nv|<leader>j"] = "",
	["nv|<leader>jl"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),

	-- nvim-window：窗口跳转选择
	["n|<leader>jw"] = map_cu("lua require('nvim-window').pick()"):with_silent():with_desc("jump: Select window"),

	-- vim-visual-multi：全选
	["n|<S-C-n>"] = map_cmd("<Plug>(VM-Select-All)"):with_silent():with_noremap():with_desc("multi: Select all"),

	-- neogen：生成函数/类注释
	["n|gc/"] = map_cu("lua require('neogen').generate()")
		:with_silent()
		:with_desc("edit: Add comment for func/type/class"),
}
