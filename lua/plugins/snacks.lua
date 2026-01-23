return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = true },
      picker = {
        sources = {
          explorer = {
            hidden = true, -- 显示隐藏文件 (以 . 开头的文件)
            ignored = true, -- 显示被 .gitignore 忽略的文件
            exclude = { "node_modules", ".git" },
          },
        },
      },
    },
  },
}
