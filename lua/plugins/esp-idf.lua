-- esp-idf 开发环境
local function has_esp_idf_env()
  -- 最可靠：source ESP-IDF export.sh / activate 脚本后通常会有这些变量
  if vim.env.IDF_PATH and vim.env.IDF_PATH ~= "" then
    return true
  end

  if vim.env.IDF_TOOLS_PATH and vim.env.IDF_TOOLS_PATH ~= "" then
    return true
  end

  if vim.env.IDF_PYTHON_ENV_PATH and vim.env.IDF_PYTHON_ENV_PATH ~= "" then
    return true
  end

  if vim.env.ESP_IDF_VERSION and vim.env.ESP_IDF_VERSION ~= "" then
    return true
  end

  -- 兜底：PATH 里能找到 idf.py，也认为当前 shell 是 ESP-IDF 环境
  if vim.fn.executable("idf.py") == 1 then
    return true
  end

  return false
end

local function esp_idf_query_drivers()
  local home = vim.env.HOME or "~"
  local idf_tools = vim.env.IDF_TOOLS_PATH or (home .. "/.espressif")

  return table.concat({
    idf_tools .. "/tools/**/xtensa-esp-elf-gcc",
    idf_tools .. "/tools/**/xtensa-esp32-elf-gcc",
    idf_tools .. "/tools/**/riscv32-esp-elf-gcc",

    home .. "/.espressif/tools/**/xtensa-esp-elf-gcc",
    home .. "/.espressif/tools/**/xtensa-esp32-elf-gcc",
    home .. "/.espressif/tools/**/riscv32-esp-elf-gcc",

    "/opt/esp/**/xtensa-esp-elf-gcc",
    "/opt/esp/**/xtensa-esp32-elf-gcc",
    "/opt/esp/**/riscv32-esp-elf-gcc",
  }, ",")
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 没有 ESP-IDF 环境变量时，不启用/不覆盖任何 ESP-IDF 配置
      if not has_esp_idf_env() then
        return
      end

      opts.servers = opts.servers or {}

      opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
        root_markers = {
          "sdkconfig",
          "sdkconfig.defaults",
          "CMakeLists.txt",
          "compile_commands.json",
          ".git",
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",

          -- ESP-IDF 的 compile_commands.json 一般在 build/ 下
          "--compile-commands-dir=build",

          -- 让 clangd 查询 ESP-IDF 交叉编译器的默认 include / target
          "--query-driver=" .. esp_idf_query_drivers(),
        },
      })
    end,
  },
}
