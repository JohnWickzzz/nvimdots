-- 个人自动命令覆盖层：由 core/event.lua 末尾的 extend_config(definitions, "user.event") 追加
local definitions = {
	-- 个人杂项初始化（输入法切换、Java 文件头、vim-visual-multi 联动等）
	user_extra_setup = {
		{ "VimEnter", "*", "lua require('user.extra').setup()" },
	},
}

return definitions
