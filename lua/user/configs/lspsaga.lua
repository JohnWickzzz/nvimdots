-- lspsaga 覆盖（函数形式拿完整 opts，避免猜嵌套路径）
-- 1) winbar 上显示文件名
-- 2) implementation 用 virtual_text 展示
-- 3) 请求超时放宽到 8s（Java 项目首次索引较慢）
return function(opts)
	opts.ui = opts.ui or {}
	opts.ui.symbol_in_winbar = opts.ui.symbol_in_winbar or {}
	opts.ui.symbol_in_winbar.show_file = true

	opts.implement = opts.implement or {}
	opts.implement.virtual_text = true

	opts.request_timeout = 8000
	return opts
end
