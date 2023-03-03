local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

local function themes(use)
	use("ellisonleao/gruvbox.nvim") --theme
	use("navarasu/onedark.nvim") -- theme
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use({ "nvim-tree/nvim-web-devicons", opt = true })
end

packer.startup(function(use)
	themes(use)
	use("wbthomason/packer.nvim") --package manager
	use({
		"williamboman/mason.nvim", --package manager
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
		"j-hui/fidget.nvim",
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {},
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-lua/plenary.nvim") --required
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "numToStr/Comment.nvim" }) --commenter
	use({ "filipdutescu/renamer.nvim", branch = "master", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "mg979/vim-visual-multi" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }) --buffer
	use({ "rcarriga/nvim-notify" }) --notify
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({})
		end,
	})
	if packer_bootstrap then
		packer.sync()
	end
end)

require("plugins/mason")
require("plugins/null_ls")
require("plugins/nvim_cmp")
require("plugins/nvim_treesitter")
require("plugins/nvim_tree")
require("plugins/commenter")
require("plugins/telescope")
require("plugins/renamer")
require("plugins/bufferline")
require("fidget").setup({})
require("notify").setup({})
