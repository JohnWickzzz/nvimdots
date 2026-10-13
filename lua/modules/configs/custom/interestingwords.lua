return function()
	require("interestingwords").setup({
		colors = { "#aeee00", "#BA5151", "#1976D2", "#b88844", "#ffa724", "#FF6D00", "#3F51B5" },
		search_count = true,
		-- navigation 必须保持关闭（原为 true）。
		-- 开启后本插件会全局改写 n/N 为 NavigateToWord()，而它的
		-- nearest_word_at_cursor() 有个判断写成了 `match_item.id >= m.limits.min
		-- or match_item.id <= m.limits.max` —— `or` 恒真（本意应是 and），
		-- 于是它会从 fn.getmatches() 里把 mini.cursorword 注入的动态 match
		-- `\(\k*\%#\k*\)\@!\&\V\<word\>` 当成「当前关注词」拿去 fn.search()。
		-- 该 pattern 里的 \%# 是「光标位置」断言，会把光标所在的那个匹配排除掉，
		-- 结果：n 跳到词尾/最后一个匹配时报
		--   Pattern not found: \(\k*\%#\k*\)\@!\&\V\<env\>
		-- 并且匹配计数也由这个依赖光标位置的 pattern 驱动，换个位置数字就变。
		-- 关掉后 n/N 回归原生搜索跳转；用 <leader>m 高亮时它仍会写入 @/，
		-- 所以原生 n/N 一样能在高亮词之间跳，功能并无损失。
		navigation = false,
		scroll_center = true,
		search_key = "<leader>m",
		cancel_search_key = "<leader>M",
		color_key = "<leader>k",
		cancel_color_key = "<leader>K",
	})
end
