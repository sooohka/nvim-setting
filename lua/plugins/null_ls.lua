local null_ls =   require("null-ls")


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end
null_ls.setup({
	sources = {
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.diagnostics.zsh,
		require("null-ls").builtins.hover.dictionary,
		require("null-ls").builtins.hover.printenv,
	},
	autoStart = true,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
