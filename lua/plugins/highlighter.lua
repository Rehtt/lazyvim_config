return {
  "azabiong/vim-highlighter",
  event = "BufRead",
  config = function()
    -- 自定义快捷键映射 (可选)
    -- 默认快捷键是 f<Enter> 高亮， f<Backspace> 清除
    vim.g.HiSet = "f<CR>"
    vim.g.HiErase = "f<BS>"
    vim.g.HiClear = "f<C-L>"
    vim.g.HiFind = "fn" .. "fp"
  end,
}
