return function()
	-- require("nvim-java").setup({})
	require("lspconfig").jdtls.setup({
		settings = {
			java = {
				configuration = {
					runtimes = {
						-- need update by different project or env
						{
							name = "JavaSE-21",
							path = "/Library/Java/JavaVirtualMachines/graalvm-jdk-21+35.1/Contents/Home",
							default = true,
						},
						{
							name = "JavaSE-17",
							path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
						},
					},
				},
				jdt = {
					ls = {
						vmargs = "--enable-preview",
					},
				},
			},
		},
	})
end
