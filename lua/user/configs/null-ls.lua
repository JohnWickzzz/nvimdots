-- none-ls 覆盖：追加 google-java-format 作为 java 的格式化源
-- 注意：sources 是列表，合并语义为「追加」，不会覆盖上游的两个源
local btns = require("null-ls").builtins

return {
	sources = {
		btns.formatting.google_java_format.with({
			filetypes = { "java" },
			extra_args = { "--aosp" },
		}),
	},
}
