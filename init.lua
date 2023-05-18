if not vim.g.vscode then
	require("core")

	-- Release note
	vim.schedule(function()
		vim.notify_once(
			[[
]],
			vim.log.levels.WARN
		)
	end)
end
