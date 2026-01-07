return {
  "neovim/nvim-lspconfig",
  opts = {
    -- 关闭内联提示
    -- 使用快捷键 <S>uh可以打开
    inlay_hints = { enabled = false },
    servers = {
      gopls = {
        settings = {
          gopls = {
            -- 关闭参数占位符
            usePlaceholders = false,
          },
        },
      },
    },
  },
}
