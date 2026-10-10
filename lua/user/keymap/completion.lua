-- 个人补全相关键位
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_callback = bind.map_callback

local mappings = {}

-- 全局键位（不需要，留空）
mappings["plug_map"] = {}

-- 仅在挂载了 LSP 的 buffer 中生效的键位
---@param buf number
mappings["lsp"] = function(buf)
	return {
		["n|gf"] = map_cr("Lspsaga finder")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Show references and implementation"),
		["n|gM"] = map_callback(function()
			vim.lsp.buf.declaration()
		end)
			:with_buffer(buf)
			:with_desc("lsp: Goto declaration"),
	}
end

return mappings
