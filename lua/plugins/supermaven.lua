return {
  "supermaven-inc/supermaven-nvim",
  opts = {
    -- 启用内联幽灵文字 (默认为 true，但 LazyVim 的 extra 可能会为了 cmp 集成将其改为 false，这里强制设为 false 代表“不禁用”)
    disable_inline_completion = false,
    -- 禁用 cmp 集成 (如果你只想看幽灵文字，不想让它污染补全列表)
    disable_keymaps = false,
    keymaps = {
      accept_suggestion = "<C-a>", -- 自定义：按下 Ctrl+a 接受建议
      clear_suggestion = "<C-]>", -- 自定义：按下 Ctrl+] 清除建议
      accept_word = "<C-j>", -- 自定义：按下 Ctrl+j 接受一个单词
    },
  },
}
