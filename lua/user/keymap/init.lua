-- 个人键位覆盖层：由 keymap/init.lua 通过 modules.utils.keymap.replace 应用
-- 语义说明：同名键位是「完全替换」而不是追加；值为 "" 表示删除该键位
return vim.tbl_extend(
	"force",
	require("user.keymap.completion").plug_map,
	require("user.keymap.editor"),
	require("user.keymap.tool"),
	require("user.keymap.ui")
)
