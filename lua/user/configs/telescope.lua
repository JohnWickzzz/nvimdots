-- 让 telescope 的输入框(prompt)落在窗口顶部、结果向下排列。
--
-- 两个坑：
-- 1. prompt 窗口位置由 layout_config.<策略>.prompt_position 决定（默认 "bottom"），
--    不是 sorting_strategy —— 后者只控制第 1 条结果落在结果窗口的最上还是最下。
--    两者要一起改，只改 sorting_strategy 是看不到效果的。
-- 2. 必须写进 horizontal / vertical 子表，顶层 prompt_position 会被忽略：
--    validate_layout_config 优先取 values[strategy][key]，而 telescope 的默认值
--    早已填进子表，顶层值永远被压住。上游 layout_strategy = "flex" 会在
--    horizontal / vertical 之间切换，所以两个子表都要设。
return {
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
			vertical = {
				prompt_position = "top",
			},
		},
	},
}
