-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- 使用OSC 52联通剪切板
-- 大多数终端由于安全原因只支持单向OSC 52，双向互通可以用xclip
-- 支持OSC 52的终端有：
-- Windows - Windows Terminal
-- MacOS - iTerm2
-- Chromebook - hterm
-- alacritty
-- kitty
-- 复用终端 - tmux (支持双向)
-- 复用终端 - screen
local function my_paste()
  return function()
    --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      -- 单向OSC 52在lvim中使用p粘贴的时候会卡住，所以返回在nvim寄存器的值可以避免卡住
      ["+"] = my_paste(),
      ["*"] = my_paste(),

      -- 如果终端支持双向OSC 52，可以使用以下方式
      -- ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      -- ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
