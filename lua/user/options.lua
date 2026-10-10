-- 个人选项覆盖层：由 core/options.lua 末尾的 extend_config(options, "user.options") 合并
local options = {
	-- 竖线位置
	colorcolumn = "100,120",

	-- 光标形状：normal 为方块、insert 为竖线，并带闪烁
	guicursor = "n-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff500-blinkon350-Cursor/lCursor,"
		.. "sm:block-blinkwait175-blinkoff150-blinkon175,v-ve:block-blinkon0",

	-- 上下留白
	scrolloff = 5,
}

return options
