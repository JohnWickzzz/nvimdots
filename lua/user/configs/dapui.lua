-- dapui 覆盖：底部面板加高到 0.3
return function(opts)
	for _, layout in ipairs(opts.layouts or {}) do
		if layout.position == "bottom" then
			layout.size = 0.3
		end
	end
	return opts
end
