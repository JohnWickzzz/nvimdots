-- 个人杂项初始化，由 user/event.lua 在 VimEnter 时调用
-- 内容对应旧配置里的 lua/core/tool_user.lua（该文件在新版上游已不存在）
local M = {}

local MACISM = "/usr/local/bin/macism"

-- 切回英文输入法（macOS）
local function switch_to_english()
	if vim.fn.executable(MACISM) ~= 1 then
		return
	end
	if vim.fn.system(MACISM) ~= "com.apple.keylayout.ABC\n" then
		vim.fn.system(MACISM .. " com.apple.keylayout.ABC")
	end
end

-- 新建 Java 文件时自动补 package 声明与文件头注释
local function add_java_package_and_header()
	if vim.fn.getline(1) ~= "" then
		return
	end

	local full_path = vim.fn.expand("%:p:h")
	local java_index = string.find(full_path, "/src/main/java/")
	if not java_index then
		return
	end

	local package_path = string.sub(full_path, java_index + 15):gsub("/", ".")
	local content = {
		"package " .. package_path .. ";",
		"",
		"/**",
		" * @author leebo",
		" * @since " .. os.date("%Y/%m/%d"),
		" */",
		"",
	}
	vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
end

-- git-conflict 的冲突高亮（catppuccin 默认配色辨识度不够）
local function set_conflict_highlight()
	local ok, colors = pcall(function()
		return require("modules.utils").get_palette()
	end)
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#008080" })
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#B33076", fg = (ok and colors.base) or nil })
end

function M.setup()
	-- vim-visual-multi：主题 + 进入时隐藏 lualine
	vim.g.VM_theme = "iceblue"
	local vm_group = vim.api.nvim_create_augroup("UserVisualMulti", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		group = vm_group,
		pattern = "visual_multi_start",
		callback = function()
			require("lualine").hide()
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = vm_group,
		pattern = "visual_multi_exit",
		callback = function()
			require("lualine").hide({ unhide = true })
		end,
	})

	-- eyeliner.nvim：f/F 首末字符高亮色
	vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#FF4500", bold = true, underline = true })
	vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#D762EA", underline = true })

	-- git-conflict 高亮（跟随配色方案重新应用）
	set_conflict_highlight()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("UserConflictHighlight", { clear = true }),
		callback = set_conflict_highlight,
	})

	-- 进入 normal 模式时切回英文输入法
	vim.api.nvim_create_autocmd("InsertLeave", {
		group = vim.api.nvim_create_augroup("UserInputMethod", { clear = true }),
		callback = switch_to_english,
	})

	-- 新建 Java 文件自动补包声明
	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("UserJavaHeader", { clear = true }),
		pattern = "*.java",
		callback = add_java_package_and_header,
	})
end

return M
