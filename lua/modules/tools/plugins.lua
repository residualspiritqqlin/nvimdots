local tools = {}
local conf = require("modules.tools.config")

--tools["RishabhRD/popfix"] = { opt = false }

-- depend by telescope
tools["nvim-lua/plenary.nvim"] = {
	opt = false,
	commit = "54b2e3d58f567983feabaeb9408eccf6b7f32206",
}
tools["nvim-telescope/telescope.nvim"] = {
	opt = true,
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = true },
	},
	tag = "nvim-0.6",
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
	opt = true,
	run = "make",
	after = "telescope.nvim",
	commit = "f0dba7df9536ddb0c8f7b6482ede77940d728d23",
}
tools["nvim-telescope/telescope-project.nvim"] = {
	opt = true,
	after = "telescope-fzf-native.nvim",
	commit = "4658d78523a5a005af80243f1d0b4e7e2a118dae",
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
	opt = true,
	after = "telescope-project.nvim",
	requires = { { "tami5/sqlite.lua", opt = true } },
	commit = "68ac8cfe6754bb656b4f84d6c3dafa421b6f9697",
}
tools["jvgrootveld/telescope-zoxide"] = {
	opt = true,
	after = "telescope-frecency.nvim",
	tag = "v2.0",
}
tools["michaelb/sniprun"] = {
	opt = true,
	run = "bash ./install.sh",
	cmd = { "SnipRun", "'<,'>SnipRun" },
	tag = "v1.2.4",
}
tools["folke/which-key.nvim"] = {
	opt = true,
	keys = ",",
	config = conf.which_key,
	commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71",
}
tools["folke/trouble.nvim"] = {
	opt = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = conf.trouble,
	commit = "da61737d860ddc12f78e638152834487eabf0ee5",
}
tools["dstein64/vim-startuptime"] = {
	opt = true,
	cmd = "StartupTime",
	commit = "a8ab56f30c603f8022f5fb6a436f5183beeb7b27",
}
tools["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = conf.wilder,
	requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
	commit = "6332b51762faaec0685769111ace06fecf673341",
}
tools["nathom/filetype.nvim"] = {
	opt = false,
	config = conf.filetype,
	tag = "v0.4",
}

return tools
