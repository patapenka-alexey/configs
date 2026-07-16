require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("v", "<C-c>", '"+y', { desc = "copy to system clipboard" })
map({ "i", "v" }, "<C-v>", '<C-r>+', { desc = "paste from system clipboard" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
