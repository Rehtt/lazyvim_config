return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = true },
      image = {
        -- 如果环境变量是 iTerm.app，则强制开启图片支持
        enabled = os.getenv("TERM_PROGRAM") == "iTerm.app" or os.getenv("LC_TERMINAL") == "iTerm2",
        force = true, -- 即使是在 tmux 中也尝试透传
      },
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
