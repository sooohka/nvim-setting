local mason = require("mason")
local masonLspconfig = require("mason-lspconfig")
local masonToolInstaller = require("mason-tool-installer")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},

		keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = "<CR>",
			-- Keymap to install the package under the current cursor position
			install_package = "i",
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = "u",
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = "c",
			-- Keymap to update all installed packages
			update_all_packages = "U",
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = "C",
			-- Keymap to uninstall a package
			uninstall_package = "X",
			-- Keymap to cancel a package installation
			cancel_installation = "<C-c>",
			-- Keymap to apply language filter
			apply_language_filter = "<C-f>",
		},
	},
})

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	--vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	--Highlight
	if client.server_capabilities.documentHighlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local lsp_flags = {
	debounce_text_changes = 150,
}

masonLspconfig.setup({
	ensure_installed = {
		"cssls",
		"dockerls",
		"eslint",
		"html",
		"jsonls",
		"lua_ls",
		"pyright",
		"rust_analyzer",
		"tailwindcss",
		"tsserver",
		"vimls",
		"yamlls",
	},
	automatic_installation = true,
})
masonLspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			flags = lsp_flags,
		})
	end,
	["lua_ls"] = function()
		require("lspconfig")["lua_ls"].setup({
			on_attach = on_attach,
			flags = lsp_flags,
			settings = {
				Lua = {
					format = {
						enable = false,
					},
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = {
							vim.api.nvim_get_runtime_file("", true),
						},
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
	-- ["rust_analyzer"] = function()
	-- 	require("rust-tools").setup({})
	-- end,
})

masonToolInstaller.setup({
	ensure_installed = {
		"actionlint",
		"bashls",
		"beautysh",
		"black",
		"commitlint",
		"css-lsp",
		"dockerfile-language-server",
		"eslint-lsp",
		"eslint_d",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		"nginx-language-server",
		"prettier",
		"pylint",
		"rust-analyzer",
		"shfmt",
		"stylua",
		"tailwindcss-language-server",
		"typescript-language-server",
		"vim-language-server",
		"yaml-language-server",
		"yamllint",
	},

	run_on_start = true,
	debounce_hours = 24,
})
