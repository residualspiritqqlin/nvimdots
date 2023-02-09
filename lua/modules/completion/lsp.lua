local formatting = require("modules.completion.formatting")

vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd aerial.nvim]])
vim.cmd([[packadd vim-illuminate]])
vim.cmd([[packadd nvim-cmp]])

local nvim_lsp = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function custom_attach(client)
	require("aerial").on_attach(client)
	require("illuminate").on_attach(client)
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = nvim_lsp.util.validate_bufnr(bufnr)
	local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	if clangd_client then
		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				print("Corresponding file can’t be determined")
				return
			end
			vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
		end)
	else
		print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
	end
end

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	if server.name == "gopls" then
		nvim_lsp.gopls.setup({
			on_attach = custom_attach,
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
			cmd = { "gopls", "-remote=auto" },
			settings = {
				gopls = {
					usePlaceholders = true,
					analyses = {
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusewrites = true,
					},
				},
			},
		})
	elseif server.name == "sumneko_lua" then
		-- Override server settings here
		local library = {}
		local path = vim.split(package.path, ";")
		-- this is the ONLY correct way to setup your path
		table.insert(path, "lua/?.lua")
		table.insert(path, "lua/?/init.lua")

		local function add_lib(lib)
			for _, p in pairs(vim.fn.expand(lib, false, true)) do
				p = vim.loop.fs_realpath(p)
				library[p] = true
			end
		end
		-- add runtime
		add_lib("$VIMRUNTIME")
		-- add your config
		add_lib("~/.config/nvim")

		-- add plugins
		-- if you're not using packer, then you might need to change the paths below
		add_lib("~/.local/share/nvim/site/pack/packer/opt/*")
		add_lib("~/.local/share/nvim/site/pack/packer/start/*")
		nvim_lsp.sumneko_lua.setup({
			capabilities = capabilities,
			on_attach = custom_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim", "packer_plugins" } },
					workspace = {
						-- Make the server aware of Neovim runtime files
						maxPreload = 100000,
						preloadFileSize = 10000,
						library = library,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	elseif server.name == "clangd" then
		local copy_capabilities = capabilities
		copy_capabilities.offsetEncoding = { "utf-16" }
		nvim_lsp.clangd.setup({
			capabilities = copy_capabilities,
			single_file_support = true,
			on_attach = custom_attach,
			args = {
				"--background-index",
				"-std=c++20",
				"--pch-storage=memory",
				"--clang-tidy",
				"--suggest-missing-includes",
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header_splitcmd(0, "edit")
					end,
					description = "Open source/header in current buffer",
				},
				ClangdSwitchSourceHeaderVSplit = {
					function()
						switch_source_header_splitcmd(0, "vsplit")
					end,
					description = "Open source/header in a new vsplit",
				},
				ClangdSwitchSourceHeaderSplit = {
					function()
						switch_source_header_splitcmd(0, "split")
					end,
					description = "Open source/header in a new split",
				},
			},
		})
	elseif server.name == "jsonls" then
		nvim_lsp.jsonls.setup({
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
			on_attach = custom_attach,
			settings = {
				json = {
					-- Schemas https://www.schemastore.org
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
						{
							fileMatch = {
								".prettierrc",
								".prettierrc.json",
								"prettier.config.json",
							},
							url = "https://json.schemastore.org/prettierrc.json",
						},
						{
							fileMatch = { ".eslintrc", ".eslintrc.json" },
							url = "https://json.schemastore.org/eslintrc.json",
						},
						{
							fileMatch = {
								".babelrc",
								".babelrc.json",
								"babel.config.json",
							},
							url = "https://json.schemastore.org/babelrc.json",
						},
						{
							fileMatch = { "lerna.json" },
							url = "https://json.schemastore.org/lerna.json",
						},
						{
							fileMatch = {
								".stylelintrc",
								".stylelintrc.json",
								"stylelint.config.json",
							},
							url = "http://json.schemastore.org/stylelintrc.json",
						},
						{
							fileMatch = { "/.github/workflows/*" },
							url = "https://json.schemastore.org/github-workflow.json",
						},
					},
				},
			},
		})
	else
		nvim_lsp[server.name].setup({
			capabilities = capabilities,
			on_attach = custom_attach,
		})
	end
end

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin

nvim_lsp.html.setup({
	cmd = { "html-languageserver", "--stdio" },
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
	settings = {},
	single_file_support = true,
	flags = { debounce_text_changes = 500 },
	capabilities = capabilities,
	on_attach = custom_attach,
})

nvim_lsp.pylsp.setup({
	language_server = "jedi_language_server",
	capabilities = capabilities,
	on_attach = custom_attach,
	flags = {
		-- This will be the default in neovim 0.7+
		debounce_text_changes = 150,
	},
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = { enabled = false },
			},
		},
	},
})

local efmls = require("efmls-configs")

-- Init `efm-langserver` here.
efmls.init({
	on_attach = custom_attach,
	capabilities = capabilities,
	init_options = { documentFormatting = true, codeAction = true },
})

-- Require `efmls-configs-nvim`'s config here

local vint = require("efmls-configs.linters.vint")
local clangtidy = require("efmls-configs.linters.clang_tidy")
local eslint = require("efmls-configs.linters.eslint")
local flake8 = require("efmls-configs.linters.flake8")
local shellcheck = require("efmls-configs.linters.shellcheck")

--local black = require("efmls-configs.formatters.black")
local fs = require("efmls-configs.fs")
local formatter = "black"
local command = string.format("%s --no-color -q --preview -S -C --line-length 120 -", fs.executable(formatter, nil))
local black = {
	formatCommand = command,
	formatStdin = true,
}

local luafmt = require("efmls-configs.formatters.stylua")
local clangfmt = {
	formatCommand = "clang-format -style='{BasedOnStyle: LLVM, ColumnLimit: 120}'",
	formatStdin = true,
}
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = require("efmls-configs.formatters.shfmt")

-- Add your own config for formatter and linter here

-- local rustfmt = require("modules.completion.efm.formatters.rustfmt")

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
