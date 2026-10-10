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
	return opts
end
