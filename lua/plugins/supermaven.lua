return {
  "supermaven-inc/supermaven-nvim",
  opts = {
    -- 启用内联幽灵文字 (默认为 true，但 LazyVim 的 extra 可能会为了 cmp 集成将其改为 false，这里强制设为 false 代表“不禁用”)
    disable_inline_completion = false,
    -- 禁用 cmp 集成 (如果你只想看幽灵文字，不想让它污染补全列表)
    disable_keymaps = false,
  },
}
