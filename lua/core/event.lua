-- Now use `<A-k>` or `<A-1>` to back to the `dotstutor`.
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command("augroup END")
	end
end

-- defer setting LSP-related keymaps till LspAttach
local mapping = require("keymap.completion")
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
	callback = function(event)
		if not _G._debugging then
			mapping.lsp(event.buf)
		end
	end,
})

-- auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(layout[2]) }) == "NvimTree"
			and layout[3] == nil
		then
			vim.api.nvim_command([[confirm quit]])
		end
	end,
})

-- auto close some filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"nofile",
		"lspinfo",
		"terminal",
		"prompt",
		"toggleterm",
		"copilot",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
	end,
})

-- Fix fold issue of files opened by telescope
vim.api.nvim_create_autocmd("BufRead", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx",
		})
	end,
})

function autocmd.load_autocmds()
	local definitions = {
		lazy = {},
		bufs = {
			-- Reload vim config automatically
			{
				"BufWritePost",
				[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
			},
			-- Reload Vim script automatically if setlocal autoread
			{
				"BufWritePost,FileWritePost",
				"*.vim",
				[[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
			},
			{ "BufWritePre", "/tmp/*", "setlocal noundofile" },
			{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
			{ "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
			{ "BufWritePre", "*.tmp", "setlocal noundofile" },
			{ "BufWritePre", "*.bak", "setlocal noundofile" },
			-- auto place to last edit
			{
				"BufReadPost",
				"*",
				[[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
			},
			-- Auto toggle fcitx5
			-- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
			-- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
			-- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
			-- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
		},
		wins = {
			-- Highlight current line only on focused window
			{
				"WinEnter,BufEnter,InsertLeave",
				"*",
				[[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
			},
			{
				"WinLeave,BufLeave,InsertEnter",
				"*",
				[[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
			},
			-- Attempt to write shada when leaving nvim
			{
				"VimLeave",
				"*",
				[[if has('nvim') | wshada | else | wviminfo! | endif]],
			},
			-- Check if file changed when its window is focus, more eager than 'autoread'
			{ "FocusGained", "* checktime" },
			-- Equalize window dimensions when resizing vim window
			{ "VimResized", "*", [[tabdo wincmd =]] },
		},
		ft = {
			{ "FileType", "alpha", "set showtabline=0" },
			{ "FileType", "markdown", "set wrap" },
			{ "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
			{ "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
			{
				"FileType",
				"*",
				[[setlocal formatoptions-=cro]],
			},
			{
				"FileType",
				"c,cpp",
				"nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>",
			},
		},
		yank = {
			{
				"TextYankPost",
				"*",
				[[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
			},
		},
	}
	autocmd.nvim_create_augroups(require("modules.utils").extend_config(definitions, "user.event"))
end

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

local jdtCnt = 0
local function autoJavaDap()
	local clients = vim.lsp.get_active_clients()
	if jdtCnt == 0 then
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

	-- 在文件顶部添加 package 声明和注释
	vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
end

-- 为新创建的 Java 文件设置自动命令
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.java",
	callback = function()
		add_java_package_and_header()
	end,
})

autocmd.load_autocmds()
