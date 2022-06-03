local editor = {}
local conf = require("modules.editor.config")

editor["junegunn/vim-easy-align"] = {
	opt = true,
	cmd = "EasyAlign",
	tag = "2.10.0",
}
editor["RRethy/vim-illuminate"] = {
	event = "BufRead",
	config = function()
		vim.g.Illuminate_highlightUnderCursor = 0
		vim.g.Illuminate_ftblacklist = {
			"help",
			"dashboard",
			"alpha",
			"packer",
			"norg",
			"DoomInfo",
			"NvimTree",
			"Outline",
			"toggleterm",
		}
	end,
	commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5",
}
editor["terrortylor/nvim-comment"] = {
	opt = false,
	config = function()
		require("nvim_comment").setup({
			hook = function()
				require("ts_context_commentstring.internal").update_commentstring()
			end,
		})
	end,
	commit = "861921706a39144ea528a6200a059a549b02d8f0",
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufRead",
	config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
	event = "BufRead",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
	opt = true,
	ft = { "html", "xml" },
	config = conf.autotag,
}
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.matchup,
    commit = "976ebfe61b407d0a75d87b4a507bf9ae4ffffbaa",
	--tag = "v0.7.0",
}
editor["rhysd/accelerated-jk"] = {
	opt = true,
	event = "BufReadPost",
	tag = "ver1.0.0",
}
editor["hrsh7th/vim-eft"] = {
	opt = true,
	event = "BufReadPost",
	commit = "e38bd7427fbbb859ef21a106431dc6c04c654415",
}
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
	commit = "27ad4ecf7532b750fadca9f36e1c5498fc225af2",
}
editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v1",
	event = "BufReadPost",
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
	end,
	tag = "v1.3.0",
}
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "WinScrolled",
	config = conf.neoscroll,
	commit = "07242b9c29eed0367cb305d41851b2e04de9052e",
}
editor["vimlab/split-term.vim"] = {
	opt = true,
	cmd = { "Term", "VTerm" },
	tag = "v1.0.3",
}
editor["akinsho/toggleterm.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.toggleterm,
	tag = "v2.0.0",
}
editor["numtostr/FTerm.nvim"] = {
	opt = true,
	event = "BufRead",
	commit = "2628685bddb50370bec6c65be95b68b343ed8443",
}
editor["rmagatti/auto-session"] = {
	opt = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
	commit = "7c9477614fb95b103c277a98bf3f588e337cd7ac",
}
editor["jdhao/better-escape.vim"] = {
	opt = true,
	event = "InsertEnter",
	commit = "6b16a45a839727977277f6ab11bded63e9ed86bb",
}
editor["rcarriga/nvim-dap-ui"] = {
	opt = false,
	config = conf.dapui,
	requires = {
		{ "mfussenegger/nvim-dap", config = conf.dap },
		{
			"Pocco81/dap-buddy.nvim",
			opt = true,
			cmd = { "DIInstall", "DIUninstall", "DIList" },
			commit = "24923c3819a450a772bb8f675926d530e829665f",
			config = conf.dapinstall,
		},
	},
	tag = "v0.33.1",
}
editor["tpope/vim-fugitive"] = {
	opt = true,
	cmd = { "Git", "G" },
	tag = "v2.4",
}
editor["famiu/bufdelete.nvim"] = {
	opt = true,
	cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
	commit = "46255e4a76c4fb450a94885527f5e58a7d96983c",
}
editor["edluffy/specs.nvim"] = {
	opt = true,
	event = "CursorMoved",
	config = conf.specs,
	commit = "e043580a65409ea071dfe34e94284959fd24e3be",
}
editor["sindrets/diffview.nvim"] = {
	opt = true,
	cmd = { "DiffviewOpen" },
	commit = "3ffe4a70c4b434ee933cb869b1706632c4407495",
}

return editor
