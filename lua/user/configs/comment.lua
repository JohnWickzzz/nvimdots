-- Comment.nvim 的 pre_hook 覆盖层。
--
-- 背景（.zshrc 上 gcc 没反应 + 弹 "[Comment.nvim] nil"）：
--   上游 modules/configs/editor/comment.lua 用的是 ts_context_commentstring 官方 pre_hook。
--   当 buffer 没有对应的 treesitter parser 时该 hook 返回 nil（它内部用 is_treesitter_active()
--   判断，nvim 0.12 下是假的），于是 Comment.nvim 的 parse_cstr 会继续走
--   `U.is_fn(pre_hook, ctx) or F.calculate(ctx)` 里的 F.calculate(ctx)：
--
--     function ft.calculate(ctx)
--       local ok, parser = pcall(vim.treesitter.get_parser, ...)
--       if not ok then return ft.get(vim.bo.filetype, ctx.ctype) end   -- 只在「抛错」时回退
--       local lang = ft.contains(parser, {...}):lang()                 -- parser 为 nil 就炸在这
--     end
--
--   nvim < 0.12 时 get_parser 对没有 parser 的语言是「抛错」，所以 pcall 失败、正常回退；
--   nvim 0.12 改成「返回 nil」，ok 为真但 parser 是 nil，于是
--   ft.contains(nil, ...) → "attempt to index local 'tree' (a nil value)"。
--   而这个错误又会被 Comment.nvim 自己的 U.catch 吞掉 —— 它的处理器只打印 err.msg，
--   普通 Lua 错误是字符串、没有 .msg，最终就变成一句 "[Comment.nvim] nil"，gcc 静默失效。
--
--   受影响的是「所有没有 treesitter parser 的文件类型」，不只 zsh：.zshrc 因为 ft=zsh
--   而本机只装了 bash 解析器，所以必然命中。
--
-- 修法：在用户层自己包一层 pre_hook，没有 parser 时直接返回原生 commentstring，
--   短路掉上游那个会崩的 ft.calculate。有 parser 时行为完全不变（仍走 ts_context_commentstring）。
local buffer_has_parser = function(bufnr)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	return ok and parser ~= nil
end

return function(opts)
	local ts_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

	opts.pre_hook = function(ctx)
		if not buffer_has_parser(vim.api.nvim_get_current_buf()) then
			return vim.bo.commentstring
		end
		return ts_hook(ctx)
	end

	return opts
end
