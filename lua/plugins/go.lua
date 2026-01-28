return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      lsp_inlay_hints = {
        enable = false, -- 显式设置为 false
      },
      -- 核心建议：禁用 go.nvim 管理的 LSP，让 LazyVim 的 lspconfig 统一处理
      lsp_cfg = false,
      lsp_gofumpt = true, -- 使用 gofumpt 进行格式化
      lsp_on_attach = true, -- 使用 go.nvim 的快捷键映射
      dap_debug = true, -- 启用调试支持
      test_runner = "go", -- 也可以改为 'richgo'
      verbose_tests = true,
      -- 自动命令配置
      luasnip = true,
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- 首次安装或更新时自动安装二进制工具
}
