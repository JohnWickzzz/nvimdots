local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local findHiddenOpts = {}
findHiddenOpts.no_ignore = true
findHiddenOpts.hidden = true
findHiddenOpts.prompt_title = "Find Files <ALL>"

local plug_map = {
	-- Plugin: vim-fugitive
	["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
	["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),
	["n|<leader>gG"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: Open git-fugitive"),

	-- Plugin: nvim-tree
	["n|<leader>v"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
	["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),

	-- Plugin: sniprun
	["v|<leader>r"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
	["n|<leader>r"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),

	-- Plugin: toggleterm
	["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
	-- disable this as it makes long press with `j` not rendering until sometime after the key release.
	-- see https://github.com/akinsho/toggleterm.nvim/issues/63 for more details
	-- ["t|jk"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["n|<C-\\>"] = map_cr("ToggleTerm direction=horizontal")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["t|<C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
	["n|<A-\\>"] = map_cr("ToggleTerm direction=vertical")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["i|<A-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["t|<A-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
	["n|<F5>"] = map_cr("ToggleTerm direction=vertical")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["i|<F5>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["t|<F5>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
	["n|<A-d>"] = map_cr("ToggleTerm direction=float"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
	["i|<A-d>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle float"),
	["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
	["n|<leader>gg"] = map_callback(function()
			_toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),

	-- Plugin: trouble
	["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent():with_desc("lsp: Toggle trouble list"),
	["n|<leader>ll"] = map_cr("TroubleToggle lsp_references")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show lsp references"),
	["n|<leader>ld"] = map_cr("TroubleToggle document_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show document diagnostics"),
	["n|<leader>lw"] = map_cr("TroubleToggle workspace_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show workspace diagnostics"),
	["n|<leader>lq"] = map_cr("TroubleToggle quickfix")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show quickfix list"),
	["n|<leader>lL"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent():with_desc("lsp: Show loclist"),

	-- Plugin: telescope
	["n|<C-p>"] = map_callback(function()
			_command_panel()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Toggle command panel"),
	["n|<leader>u"] = map_callback(function()
			require("telescope").extensions.undo.undo()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("edit: Show undo history"),
	["n|<leader>fp"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<leader>fr"] = map_callback(function()
			require("telescope").extensions.frecency.frecency({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<leader>fw"] = map_callback(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Word in project"),
	["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
	["n|<leader>fa"] = map_callback(function()
			require("telescope.builtin").find_files(findHiddenOpts)
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: All file in project"),
	["n|<leader>fc"] = map_callback(function()
			require("telescope.builtin").colorscheme({ enable_preview = true })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("ui: Change colorscheme for current session"),
	["n|<leader>bn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),
	["n|<leader>fg"] = map_cu("Telescope git_files")
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("edit: Change current direrctory by zoxide"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),
	["v|<leader>fs"] = map_callback(function()
			require("telescope.builtin").grep_string({ search = _buf_vtext() }) -- luacheck: ignore
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Selection text"),
	["n|<leader>fd"] = map_cu("Telescope persisted"):with_noremap():with_silent():with_desc("find: Session"),

	-- Plugin: dap
	["n|<F6>"] = map_callback(function()
			require("dap").continue()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run/Continue"),
	["n|<F7>"] = map_callback(function()
			require("dap").terminate()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Stop"),
	["n|<F8>"] = map_callback(function()
			require("dap").toggle_breakpoint()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Toggle breakpoint"),
	["n|<F9>"] = map_callback(function()
			require("dap").step_into()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step into"),
	["n|<F10>"] = map_callback(function()
			require("dap").step_out()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step out"),
	["n|<F11>"] = map_callback(function()
			require("dap").step_over()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step over"),
	["n|<leader>db"] = map_callback(function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Set breakpoint with condition"),
	["n|<leader>dc"] = map_callback(function()
			require("dap").run_to_cursor()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run to cursor"),
	["n|<leader>dl"] = map_callback(function()
			require("dap").run_last()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run last"),
	["n|<leader>do"] = map_callback(function()
			require("dap").repl.open()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open REPL"),
	-- ["n|<leader>duo"] = map_callback(function()
	-- 		require("dapui").open({ reset = true })
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Dap UI open"),
	-- ["n|<leader>duc"] = map_callback(function()
	-- 		require("dapui").close()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("debug: Open UI close"),
	["n|<leader>dt"] = map_callback(function()
			require("dapui").toggle({ reset = true })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open UI toggle"),

	-- Plugin: nvim-java
	["n|<leader>dj"] = map_cr("JavaDapConfig"):with_noremap():with_silent():with_desc("debug: Java dap config"),
	["n|<leader>dm"] = map_cr("JavaTestDebugCurrentMethod")
		:with_noremap()
		:with_silent()
		:with_desc("debug: Java test debug current method"),
}

bind.nvim_load_mapping(plug_map)
