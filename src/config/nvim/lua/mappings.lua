require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<leader>w", ":w<cr>")
map("n", "H", ":bp<cr>")
map("n", "L", ":bn<cr>")
map("n", "<leader>nh", ":nohl<cr>")
