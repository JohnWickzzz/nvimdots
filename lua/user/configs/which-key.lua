-- which-key 覆盖：用函数形式拿到默认 opts 再改，避免深合并踩嵌套
-- 1) 取消 delay 与 timeoutlen 的绑定，恢复 which-key 自身的默认延迟
-- 2) 补上 <leader>j（Jump）分组
return function(opts)
	opts.delay = nil

	local ui_icons = require("modules.utils.icons").get("ui")
	opts.spec = opts.spec or {}
	table.insert(opts.spec, { "<leader>j", group = (ui_icons.ChevronRight or "") .. " Jump" })
	return opts
end
