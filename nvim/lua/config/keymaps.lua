vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus lower split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus upper split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right split" })
