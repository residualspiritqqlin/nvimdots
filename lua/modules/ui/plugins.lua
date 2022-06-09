local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = {
	opt = false,
	commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e",
}

ui["shaunsingh/nord.nvim"] = {
	opt = false,
	config = conf.nord,
	commit = "db98740c9429232508a25a98b7d41705f4d2fc1c",
}

ui["sainnhe/edge"] = {
	opt = false,
	config = conf.edge,
	tag = "v0.2.2",
}

ui["catppuccin/nvim"] = {
	opt = false,
	as = "catppuccin",
	commit = "f079dda3dc23450d69b4bad11bfbd9af2c77f6f3",
	config = conf.catppuccin,
}
ui["nvim-lualine/lualine.nvim"] = {
	opt = true,
	after = "lualine-lsp-progress",
	config = conf.lualine,
	commit = "3362b28f917acc37538b1047f187ff1b5645ecdd",
}
ui["SmiteshP/nvim-gps"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.nvim_gps,
	commit = "8f950881c6308884e1262f1a10eadede1ad4253c",
}
ui["arkav/lualine-lsp-progress"] = {
	opt = true,
	after = "nvim-gps",
	commit = "56842d097245a08d77912edf5f2a69ba29f275d7",
}
ui["glepnir/dashboard-nvim"] = {
	opt = false,
	--commit = "a990f2c0ae59e043b07b557a6a48f290c63289e3",
}
ui["kyazdani42/nvim-tree.lua"] = {
	opt = true,
	cmd = { "NvimTreeToggle" },
	config = conf.nvim_tree,
	commit = "6abc87b1d92fc8223f1e374728ea45c848bfdf6d",
}
ui["lewis6991/gitsigns.nvim"] = {
	opt = true,
	event = { "BufRead", "BufNewFile" },
	config = conf.gitsigns,
	requires = { "nvim-lua/plenary.nvim", opt = true },
	commit = "27aeb2e715c32cbb99aa0b326b31739464b61644",
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.indent_blankline,
	tag = "v2.18.4",
}
ui["akinsho/bufferline.nvim"] = {
	opt = true,
	tag = "*",
	event = "BufRead",
	config = conf.nvim_bufferline,
}
-- ui["petertriho/nvim-scrollbar"] = {
-- 	opt = true,
-- 	event = "BufRead",
-- 	config = function()
-- 		require("scrollbar").setup()
-- 	end,
-- }
-- ui["wfxr/minimap.vim"] = {
-- 	opt = true,
-- 	event = "BufRead",
-- }
ui["mbbill/undotree"] = {
	opt = true,
	cmd = "UndotreeToggle",
}

return ui
