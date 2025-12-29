local conf = {
  clangd = "/Applications/Arduino IDE.app/Contents/Resources/app/lib/backend/resources/clangd",
  arduino_cli = "/Applications/Arduino IDE.app/Contents/Resources/app/lib/backend/resources/arduino-cli",
  cli_config = "~/Library/Arduino15/arduino-cli.yaml",
  fqbn = "esp8266:esp8266:generic",
  -- fqbn = "arduino:avr:uno",
}

local util = require("lspconfig.util")
local function find_fqbn(root)
  if not root then
    return nil
  end
  local yaml = root .. "/sketch.yaml"
  local fh = io.open(yaml, "r")
  if not fh then
    return nil
  end

  for line in fh:lines() do
    local m = line:match("^%s*fqbn:%s*([%w%p:]+)") -- 稍微增强了正则，支持冒号
    if m then
      fh:close()
      return vim.trim(m)
    end
  end
  fh:close()
  return nil
end

-- 路径兜底
if vim.fn.executable(conf.clangd) == 0 then
  conf.clangd = "clangd"
end
if vim.fn.executable(conf.arduino_cli) == 0 then
  conf.arduino_cli = "arduino-cli"
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      arduino_language_server = {
        filetypes = { "arduino", "ino" },

        -- 3. 基础 CMD (不包含动态的 fqbn)
        -- 注意：这里必须是 Table，不能是函数
        cmd = {
          "arduino-language-server",
          "-clangd",
          vim.fn.exepath(conf.clangd),
          "-cli",
          vim.fn.exepath(conf.arduino_cli),
          "-cli-config",
          vim.fn.expand(conf.cli_config),
          "-fqbn",
          conf.fqbn,
        },

        -- 4. 正确的 root_dir 写法
        -- 只要这里能返回正确的路径，on_new_config 就会触发
        root_dir = function(fname, on_dir)
          fname = vim.api.nvim_buf_get_name(fname)
          on_dir(util.root_pattern("sketch.yaml")(fname) or vim.fs.dirname(fname))
        end,
        --
        -- -- 5. 动态修改配置的核心钩子
        -- on_new_config = function(new_config, new_root_dir)
        --   -- 在这里获取 fqbn，因为这里有确定的 root_dir
        --   local fqbn = find_fqbn(new_root_dir)
        --
        --   if fqbn then
        --     -- 将 fqbn 追加到 cmd 参数末尾
        --     table.insert(new_config.cmd, "--fqbn=" .. fqbn)
        --
        --     -- 调试日志：你可以通过 :LspLog 查看是否成功
        --     vim.notify("Arduino FQBN found: " .. fqbn, vim.log.levels.INFO)
        --   else
        --     -- 默认 FQBN (如果 sketch.yaml 没找到)
        --     table.insert(new_config.cmd, "--fqbn=arduino:avr:uno")
        --     vim.notify("Arduino FQBN not found, utilizing default.", vim.log.levels.WARN)
        --   end
        -- end,
      },
    },
  },
}
