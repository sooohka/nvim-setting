local g = vim.g

g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--nvimtree
map("n", "nt", "<cmd>NvimTreeToggle<CR>")
map("n", "nf", "<cmd>NvimTreeFocus<CR>")

--basic
vim.keymap.set("n", "<leader>ss", "<cmd> luafile %<cr>", {})
vim.keymap.set("v", "<M-c>", '<cmd>vnoremap <M-c> "+y<cr>', {})

-- telescope
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})
vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, {})

-- renamer
vim.keymap.set("n", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })

-- packer
vim.keymap.set("n", "<leader>pi", require("packer").install, {})
vim.keymap.set("n", "<leader>ps", require("packer").status, {})
vim.keymap.set("n", "<leader>pi", require("packer").install, {})

--multi cursor
vim.keymap.set("n", "<C-d>", "<Plug>(VM-Find-Under)", {})
vim.keymap.set("n", "<C-d>", "<Plug>(VM-Find-Under)", {})
vim.keymap.set("n", "<C-q>", "<Plug>(VM-Add-Cursor-Down)", {})
vim.keymap.set("n", "<C-w>", "<Plug>(VM-Add-Cursor-Up)", {})

--mason
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", {})

--bufferline
vim.keymap.set("n", "<S-L>", "<cmd>BufferLineCycleNext<cr>", {})
vim.keymap.set("n", "<S-w>", "<cmd>BufferLineCycleNext<cr>", {})
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", {})
for i = 1, 10 do
	vim.keymap.set("n", "<leader>" .. i, function()
		require("bufferline").go_to_buffer(i, true)
	end, {})
end

--toggleTerm
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", {})
