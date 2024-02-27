local M = {}

---------------------------------------- neovim setting --------------------------------------------
-- 竖线位置
vim.opt.colorcolumn = "100,120"

---------------------------------------- none-ls plugin --------------------------------------------
vim.g.nonels_supress_issue58 = true

------------------------------------ vim-sisual-multi plugin ---------------------------------------
-- vim-visual-multi theme
vim.g.VM_theme = "iceblue"

-- 适配lualine
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "visual_multi_start",
	callback = function()
		require("lualine").hide()
	end,
})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "visual_multi_exit",
	callback = function()
		require("lualine").hide({ unhide = true })
	end,
})

------------------------------------ eyeliner.nvim plugin ------------------------------------------
--f/F first/second color
vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#FF4500", bold = true, underline = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#D762EA", underline = true })

---------------------------------------- 输入法切换 ------------------------------------------------
-- 记录当前输入法
Current_input_method = vim.fn.system("/usr/local/bin/macism")

-- 切换到英文输入法
function Switch_to_English_input_method()
	Current_input_method = vim.fn.system("/usr/local/bin/macism")
	if Current_input_method ~= "com.apple.keylayout.ABC\n" then
		vim.fn.system("/usr/local/bin/macism com.apple.keylayout.ABC")
	end
end

-- 设置输入法
-- function Set_input_method()
-- 	if Current_input_method ~= "com.apple.keylayout.ABC\n" then
-- 		vim.fn.system("/usr/local/bin/macism " .. string.gsub(Current_input_method, "\n", ""))
-- 	end
-- end

-- 进入 normal 模式时切换为英文输入法
vim.cmd([[
augroup input_method
  autocmd!
  " autocmd InsertEnter * :lua Set_input_method()
  autocmd InsertLeave * :lua Switch_to_English_input_method()
augroup END
]])

-------------------------------------- auto java dap -----------------------------------------------
-- 首次打开java文件 dap自动配置
local jdtCnt = 0
local function autoJavaDap()
	if jdtCnt == 0 then
		local clients = vim.lsp.get_active_clients()
		for _, client in pairs(clients) do
			if client.name == "jdtls" then
				jdtCnt = jdtCnt + 1
				require("java").dap.config_dap()
			end
		end
	end
end
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.java",
	callback = function()
		vim.defer_fn(autoJavaDap, 1000)
	end,
})

----------------------------------- auto add java file package -------------------------------------
-- 在文件顶部添加 package 声明和注释
local function add_java_package_and_header()
	-- 检查文件是否为空
	if vim.fn.getline(1) ~= "" then
		return
	end

	-- 获取文件的完整路径
	local full_path = vim.fn.expand("%:p:h")
	local java_index = string.find(full_path, "/src/main/java/")
	if not java_index then
		return
	end

	-- 提取包路径
	local package_path = string.sub(full_path, java_index + 15)
	package_path = package_path:gsub("/", ".")

	-- 获取当前日期
	local date = os.date("%Y/%m/%d")

	-- 构建 package 声明和注释
	local content = {
		"package " .. package_path .. ";",
		"",
		"/**",
		" * @author leebo",
		" * @since " .. date,
		" */",
		"",
	}

	vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
end

-- 为新创建的 Java 文件设置自动命令
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.java",
	callback = function()
		add_java_package_and_header()
	end,
})

return M
