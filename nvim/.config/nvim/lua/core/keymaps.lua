vim.g.mapleader= " "

local keymap = vim.keymap

-- ------------- INSERT MODE --------------- --


-- ------------- VISUAL MODE --------------- --
-- Line Movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- ------------- NORMAL MODE --------------- --
-- Windows Split
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
-- Navigate vim panes better
keymap.set('n', '<c-k>', ':wincmd k<CR>')
keymap.set('n', '<c-j>', ':wincmd j<CR>')
keymap.set('n', '<c-h>', ':wincmd h<CR>')
keymap.set('n', '<c-l>', ':wincmd l<CR>')
-- Visual Block
vim.api.nvim_set_keymap('n', '<C-S-v>', '<C-V>', { noremap = true, silent = true })


-- --------------- Plugins ------------------ --
-- telescope
-- vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- neo-tree
-- H -- show/hide dotfile
