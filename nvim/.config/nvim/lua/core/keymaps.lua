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
