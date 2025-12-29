return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- 这里定义你的快捷键，'show' 命令即为手动触发
        ["<C-z>"] = { "show", "show_documentation", "hide_documentation" },
      },
    },
  },
}
