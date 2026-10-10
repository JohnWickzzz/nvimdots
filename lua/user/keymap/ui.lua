-- 个人 UI 相关键位
-- 目的：把 <A-j>/<A-k> 让给 bufferline，把窗口缩放下移到 <A-i>/<A-o>
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu

return {
	-- smart-splits：上下缩放（原来占 <A-j>/<A-k>，现在挪到 <A-i>/<A-o>）
	["n|<A-i>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 vertically"),
	["n|<A-o>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 vertically"),

	-- bufferline：切换上一个/下一个
	["n|<A-j>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
	["n|<A-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),

	-- 旧的 move 键位删除，改用 <A-S-j>/<A-S-k>
	["n|<A-S-i>"] = "",
	["n|<A-S-o>"] = "",
	["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("buffer: Move current to next"),
	["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("buffer: Move current to prev"),
}
