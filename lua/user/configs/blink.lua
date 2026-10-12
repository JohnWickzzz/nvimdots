-- blink.cmp 覆盖：修掉上游的一个不一致
--
-- 上游 modules/configs/completion/blink.lua 里：
--   * 补全源列表 sources_default 是按 `use_copilot` / `use_minuet` 条件拼的（正常）
--   * 但 sources.providers.copilot / .minuet 是**无条件注册**的
-- 对应插件（fang2hou/blink-copilot、milanglacier/minuet-ai.nvim）却是按
-- edit_prediction_source 条件安装，于是没装插件时健康检查会报
--   module 'blink-copilot' not found
-- 这里用同样的条件把用不到的 provider 摘掉，逻辑与上游门控保持一致。
return function(opts)
	local settings = require("core.settings")
	local source = settings["edit-prediction-source"] or settings.edit_prediction_source
	local use_copilot = settings.use_copilot and source == "copilot"
	local use_minuet = source == "oai-compatible"

	opts.sources = opts.sources or {}
	local providers = opts.sources.providers or {}

	if not use_copilot then
		providers.copilot = nil
	end
	if not use_minuet then
		providers.minuet = nil
	end

	opts.sources.providers = providers

	-- `:` 命令行的回车行为，两件事要一起改才安全
	--
	-- 1) 键位：cmdline 有自己独立的 keymap，上游默认 preset = 'cmdline'，
	--    这个 preset 里根本没有 <CR>（只有 Tab/S-Tab/C-n/C-p/C-y/C-e 等），
	--    而顶层 opts.keymap 只作用于插入模式。于是 `:` 下菜单虽然会弹出、
	--    第一项也高亮，回车却完全绕过 blink 直接交给 nvim 执行命令，
	--    结果 `:mas` + 回车 → E492: Not an editor command: mas。
	--    这里补上 <CR>：有选中项就接受该补全并追加一个回车去执行它，
	--    没有选中项时 accept 返回 false，落到 fallback，回车保持原生行为。
	--
	-- 2) 预选范围：不能无条件 preselect，否则菜单会在参数区把 nvim 自带的
	--    cmdline 补全（变量名等）也模糊匹配进来抢走回车 —— 实测 `:echo 1`
	--    回车会被吃成 `:echo terminal_color_1`。所以只在“正在补命令名”
	--    （光标前没有空格）时才预选第一项，进了参数区就不再预选。
	opts.cmdline = opts.cmdline or {}
	opts.cmdline.keymap = {
		preset = "cmdline",
		["<CR>"] = { "accept_and_enter", "fallback" },
	}

	opts.cmdline.completion = opts.cmdline.completion or {}
	opts.cmdline.completion.list = opts.cmdline.completion.list or {}
	opts.cmdline.completion.list.selection = {
		auto_insert = true,
		preselect = function()
			-- getcmdline() 不含开头的 ":" / "/"，getcmdpos() 含，
			-- 所以光标之前的正文是 cmd:sub(1, pos - 2)
			local cmd = vim.fn.getcmdline()
			local before = cmd:sub(1, math.max(vim.fn.getcmdpos() - 2, 0))
			return not before:find("%s")
		end,
	}

	return opts
end
