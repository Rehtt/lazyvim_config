-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<C-q>", "<ESC>:q<CR>")
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight Search" })

-- 插入模式下 Ctrl+← 跳到上一个词首并继续插入
map("i", "<C-Left>", "<Esc>bi", { silent = true })
-- 插入模式下 Ctrl+→ 跳到下一个词尾并继续插入（光标停在词尾后面）
map("i", "<C-Right>", "<Esc>ea", { silent = true })

map("n", "<M-h>", "<Esc>:bp<CR>", { desc = "上一buffer" })
map("n", "<M-l>", "<Esc>:bn<CR>", { desc = "下一buffer" })

map({ "n", "v" }, "s", "s")
map({ "n", "v" }, "S", "S")

local filltext = require("config.filltext.filltext")
map("n", "<leader>Fm", function()
  filltext.insert_mit_license()
end, { desc = "Insert MIT license" })
map("n", "<leader>Fh", function()
  filltext.insert_mit_head_license()
end, { desc = "Insert MIT head license" })
map("n", "<leader>Fu", function()
  filltext.insert_user_info()
end, { desc = "Insert user info" })
