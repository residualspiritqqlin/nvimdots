local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
	opt = true,
	event = "BufReadPre",
	config = conf.nvim_lsp,
}
completion["creativenull/efmls-configs-nvim"] = {
	opt = false,
	requires = "neovim/nvim-lspconfig",
	commit = "fddb1af051f9be3cfbdbbb8d486dccdb839dbb84",
}
completion["williamboman/nvim-lsp-installer"] = {
	opt = false,
	--commit = "f5f6538984b5bc9bccfc544960e05d47304f3c5e",
}
completion["kevinhwang91/nvim-bqf"] = {
	opt = true,
	ft = "qf",
	config = conf.bqf,
	commit = "0cc539c52e51d32d8febf1f04c5e7ed5353fead2",
}
completion["tami5/lspsaga.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
	--commit = "cb0e35d2e594ff7a9c408d2e382945d56336c040",
}
completion["stevearc/aerial.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.aerial,
	commit = "ece90c4820e7cea7be0aade9d19ef11f53bbc028",
}
completion["kosayoda/nvim-lightbulb"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.lightbulb,
	commit = "1adc99adcfe2f3e2b3051f6449e1673e66643e77",
}
completion["ray-x/lsp_signature.nvim"] = { opt = true, after = "nvim-lspconfig" }
completion["hrsh7th/nvim-cmp"] = {
	config = conf.cmp,
	event = "InsertEnter",
	requires = {
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
		{ "andersevenrud/cmp-tmux", after = "cmp-nvim-lua" },
		{ "hrsh7th/cmp-path", after = "cmp-tmux" },
		{ "f3fora/cmp-spell", after = "cmp-path" },
		{ "hrsh7th/cmp-buffer", after = "cmp-spell" },
		{ "kdheepak/cmp-latex-symbols", after = "cmp-buffer" },
		-- {
		--     'tzachar/cmp-tabnine',
		--     run = './install.sh',
		--     after = 'cmp-spell',
		--     config = conf.tabnine
		-- }
		commit = "033a817ced907c8bcdcbe3355d7ea67446264f4b",
	},
}
completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	config = conf.luasnip,
	requires = "rafamadriz/friendly-snippets",
	commit = "52f4aed58db32a3a03211d31d2b12c0495c45580",
}
completion["windwp/nvim-autopairs"] = {
	after = "nvim-cmp",
	config = conf.autopairs,
	commit = "b9cc0a26f3b5610ce772004e1efd452b10b36bc9",
}
completion["github/copilot.vim"] = { opt = true, cmd = "Copilot" }

return completion
