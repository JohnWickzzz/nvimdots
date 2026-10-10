-- smart-splits.nvim v3 适配（版本自适应）
--
-- v3 把 v2 的 `default_amount` 迁到了 `resize.amount`，旧名会触发
-- ":checkhealth smart-splits" 的迁移告警。上游 splits.lua 仍用旧名，
-- 这里在检测到 v3 时才做迁移；若插件回退到 v2 则原样保留，不会反向报错。
-- 顶层的 ignored_buftypes / ignored_filetypes 在 v3 里仍然有效，无需改动。
return function(opts)
	local ok, config = pcall(require, "smart-splits.config")
	local is_v3 = ok and type(config) == "table" and config.resize ~= nil

	if is_v3 then
		opts.resize = opts.resize or {}
		opts.resize.amount = opts.default_amount or opts.resize.amount or 3
		opts.default_amount = nil
	end

	return opts
end
