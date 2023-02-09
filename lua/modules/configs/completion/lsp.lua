return function()
	local formatting = require("completion.formatting")

	local nvim_lsp = require("lspconfig")
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	require("lspconfig.ui.windows").default_options.border = "single"

	local icons = {
		ui = require("modules.utils.icons").get("ui", true),
		misc = require("modules.utils.icons").get("misc", true),
	}

	mason.setup({
		ui = {
			border = "rounded",
			icons = {
				package_pending = icons.ui.Modified_alt,
				package_installed = icons.ui.Check,
				package_uninstalled = icons.misc.Ghost,
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},
	})
	mason_lspconfig.setup({
		ensure_installed = {
			"bashls",
			"clangd",
			"efm",
			"gopls",
			"jedi_language_server",
			"sumneko_lua",
		},
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	local opts = {
		on_attach = function()
			require("lsp_signature").on_attach({
				bind = true,
				use_lspsaga = false,
				floating_window = true,
				fix_pos = true,
				hint_enable = true,
				hi_parameter = "Search",
				handler_opts = {
					border = "rounded",
				},
			})
		end,
		capabilities = capabilities,
	}

	mason_lspconfig.setup_handlers({
		function(server)
			require("lspconfig")[server].setup({
				capabilities = opts.capabilities,
				on_attach = opts.on_attach,
			})
		end,

		bashls = function()
			local _opts = require("completion.servers.bashls")
			local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
			nvim_lsp.bashls.setup(final_opts)
		end,

		clangd = function()
			local _capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, capabilities)
			local _opts = require("completion.servers.clangd")
			local final_opts =
				vim.tbl_deep_extend("keep", _opts, { on_attach = opts.on_attach, capabilities = _capabilities })
			nvim_lsp.clangd.setup(final_opts)
		end,

		efm = function()
			-- Do not setup efm
		end,

		gopls = function()
			local _opts = require("completion.servers.gopls")
			local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
			nvim_lsp.gopls.setup(final_opts)
		end,

		jsonls = function()
			local _opts = require("completion.servers.jsonls")
			local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
			nvim_lsp.jsonls.setup(final_opts)
		end,

		sumneko_lua = function()
			local _opts = require("completion.servers.sumneko_lua")
			local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
			nvim_lsp.sumneko_lua.setup(final_opts)
		end,
	})

	if vim.fn.executable("html-languageserver") then
		local _opts = require("completion.servers.html")
		local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
		nvim_lsp.html.setup(final_opts)
	end

	local efmls = require("efmls-configs")

	-- Init `efm-langserver` here.

	efmls.init({
		on_attach = opts.on_attach,
		capabilities = capabilities,
		init_options = { documentFormatting = true, codeAction = true },
	})

	-- Require `efmls-configs-nvim`'s config here

	local vint = require("efmls-configs.linters.vint")
	local clangtidy = require("efmls-configs.linters.clang_tidy")
	local eslint = require("efmls-configs.linters.eslint")
	local flake8 = require("efmls-configs.linters.flake8")

	local fs = require("efmls-configs.fs")
	local formatter = "black"
	local command = string.format("%s --no-color -q --preview -S -C --line-length 120 -", fs.executable(formatter, nil))
	local black = {
		formatCommand = command,
		formatStdin = true,
	}
	local luafmt = require("efmls-configs.formatters.stylua")
	-- local stylua = require("efmls-configs.formatters.stylua")
	local prettier = require("efmls-configs.formatters.prettier")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	-- Add your own config for formatter and linter here

	-- local rustfmt = require("completion.efm.formatters.rustfmt")
	local clangfmt = require("completion.efm.formatters.clangfmt")

	-- Override default config here
	flake8 = vim.tbl_extend("force", flake8, {
		prefix = "flake8: max-line-length=120, ignore F403 and F405 and E203 and E402 and E731 and W605",
		lintStdin = true,
		lintIgnoreExitCode = true,
		lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
		lintCommand = "flake8 --max-line-length 120 --extend-ignore F403,F405,E203,E402,E731,W605 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
	})
	-- Setup formatter and linter for efmls here

	efmls.setup({
		vim = { formatter = vint },
		lua = { formatter = luafmt },
		c = { formatter = clangfmt, linter = clangtidy },
		cpp = { formatter = clangfmt, linter = clangtidy },
		python = { formatter = black, linter = flake8 },
		vue = { formatter = prettier },
		typescript = { formatter = prettier, linter = eslint },
		javascript = { formatter = prettier, linter = eslint },
		typescriptreact = { formatter = prettier, linter = eslint },
		javascriptreact = { formatter = prettier, linter = eslint },
		yaml = { formatter = prettier },
		html = { formatter = prettier },
		css = { formatter = prettier },
		scss = { formatter = prettier },
		sh = { formatter = shfmt, linter = shellcheck },
		markdown = { formatter = prettier },
		-- rust = {formatter = rustfmt},
	})
	formatting.configure_format_on_save()
end
