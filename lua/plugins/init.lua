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
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }) --buffer
	use({ "nvim-tree/nvim-web-devicons" })
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
		"jose-elias-alvarez/null-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
	})
	use({ "nvim-tree/nvim-tree.lua" })
	use("nvim-lua/plenary.nvim") --required
	use({
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		"hrsh7th/cmp-buffer", -- buffer
		"hrsh7th/cmp-path", -- path
		"hrsh7th/cmp-cmdline", -- pcmdlinelugin
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"hrsh7th/cmp-nvim-lua", -- Lua source for nvim-cmp
		"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
		"L3MON4D3/LuaSnip", -- Snippets plugin
		"f3fora/cmp-spell",
		"rafamadriz/friendly-snippets", -- 스니펫 추천
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("plugins/copilot").copilotSetup()
			end,
		},
		{
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua" },
			config = function()
				require("plugins/copilot").copilotCmpSetup()
			end,
		},
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "numToStr/Comment.nvim" }) --commenter
	use({ "filipdutescu/renamer.nvim", branch = "master", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "mg979/vim-visual-multi" }) --multicursor
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "rcarriga/nvim-notify" }) --notify
	use("folke/which-key.nvim")
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({})
		end,
	})
	use({
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					-- require('hover.providers.gh')
					-- require('hover.providers.gh_user')
					-- require('hover.providers.jira')
					-- require("hover.providers.man")
					require("hover.providers.dictionary")
				end,
				preview_opts = {
					border = nil,
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
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
require("plugins/lsp")
