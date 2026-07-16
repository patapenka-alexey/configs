require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("v", "<C-c>", '"+y<Esc>i', { desc = "copy to clipboard" })
map("v", "<C-x>", '"+d<Esc>i', { desc = "cut to clipboard" })
map("n", "<C-v>", '"+pi', { desc = "paste from clipboard" })
map("i", "<C-v>", '<Esc>"+pi', { desc = "paste from clipboard" })

map("n", "<C-F>", "<cmd>Telescope live_grep<CR>", { desc = "search in all files" })

map({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>:w<CR>", { desc = "save and enter normal mode" })

