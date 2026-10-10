return function()
	require("interestingwords").setup({
		colors = { "#aeee00", "#BA5151", "#1976D2", "#b88844", "#ffa724", "#FF6D00", "#3F51B5" },
		search_count = true,
		navigation = true,
		scroll_center = true,
		search_key = "<leader>m",
		cancel_search_key = "<leader>M",
		color_key = "<leader>k",
		cancel_color_key = "<leader>K",
	})
end
