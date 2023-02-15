-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/sumneko_lua.lua
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "packer_plugins" },
				disable = { "different-requires" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("~/.config/nvim/")] = true,
					[vim.fn.expand("./lua/?.lua")] = true,
					[vim.fn.expand("./lua/?/?.lua")] = true,
					[vim.fn.expand("~/.config/nvim/")] = true,
					[vim.fn.expand("~/.local/share/nvim/site/lazy/?/*")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			telemetry = { enable = false },
			-- Do not override treesitter lua highlighting with sumneko lua highlighting
			semantic = { enable = false },
		},
	},
}
