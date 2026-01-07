return {
  "neovim/nvim-lspconfig",
  opts = {
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
