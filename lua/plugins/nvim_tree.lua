local nvim_tree = require("nvim-tree")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults

-- OR setup with some options
nvim_tree.setup({
	sort_by = "case_sensitive",
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
