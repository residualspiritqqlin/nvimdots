local lang = {}
local conf = require("modules.lang.config")

lang["fatih/vim-go"] = {
	opt = true,
	ft = "go",
	run = ":GoInstallBinaries",
	config = conf.lang_go,
	tag = "v1.26",
}
lang["rust-lang/rust.vim"] = {
	opt = true,
	ft = "rust",
	commit = "4aa69b84c8a58fcec6b6dad6fe244b916b1cf830",
}
lang["simrat39/rust-tools.nvim"] = {
	opt = true,
	ft = "rust",
	config = conf.rust_tools,
	requires = { { "nvim-lua/plenary.nvim", opt = false } },
	commit = "11dcd674781ba68a951ab4c7b740553cae8fe671",
}
lang["iamcco/markdown-preview.nvim"] = {
	opt = true,
	ft = "markdown",
	run = "cd app && yarn install",
	tag = "v0.0.10",
}
lang["chrisbra/csv.vim"] = {
	opt = true,
	ft = "csv",
	commit = "eb284c4e33b57fc828012cb9ebb420a9ae6ecbe7",
}
return lang
