local M = {}

--- 获取指定 Buffer 的注释符号并格式化文本
--- @param bufnr number
--- @param text string
--- @return table lines 格式化好的行数组
local function get_commented_lines(bufnr, text)
  -- 1. 获取当前 buffer 的 commentstring
  -- Neovim 会根据 filetype 或 TreeSitter 自动设置这个值
  local comment_fmt = vim.api.nvim_buf_get_option(bufnr, "commentstring")

  -- 2. 兜底：如果获取不到（比如纯文本文件），默认使用 #
  if not comment_fmt or comment_fmt == "" then
    comment_fmt = "# %s"
  end

  -- 3. 将文本分行并应用注释格式
  local lines = vim.split(text, "\n")
  local commented_lines = {}

  for _, line in ipairs(lines) do
    if line ~= "" then
      -- 确保 comment_fmt 包含 %s，用于替换内容
      -- 例如: "-- %s" 变成 "-- local x = 1"
      local formatted = string.format(comment_fmt, line)
      table.insert(commented_lines, formatted)
    else
      -- 保持空行不被注释（根据个人喜好，也可以注释空行）
      table.insert(commented_lines, "")
    end
  end

  return commented_lines
end

function M.insert(text)
  local bufnr = vim.api.nvim_get_current_buf()

  -- 1. 获取带注释的文本数组
  local lines = get_commented_lines(bufnr, text)

  -- 2. 原生 API 插入到顶部
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
end

function M.insert_file_and_comment(filepath, text)
  -- 1. 添加并加载 Buffer
  local bufnr = vim.fn.bufadd(filepath)
  vim.fn.bufload(bufnr)

  -- 关键步骤：必须进行文件类型检测，否则 commentstring 可能为空
  -- 我们在一个临时的环境中执行检测，以免影响当前窗口
  vim.api.nvim_buf_call(bufnr, function()
    -- 如果没有文件类型，尝试检测
    if vim.bo.filetype == "" then
      vim.cmd("filetype detect")
    end
  end)

  -- 2. 获取带注释的文本数组 (传入目标 bufnr 以获取正确的注释符号)
  local lines = get_commented_lines(bufnr, text)

  -- 3. 写入内容
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)

  -- 4. 如果你想打开这个文件给用户看 (可选)
  vim.api.nvim_set_current_buf(bufnr)
end

-- 你的业务逻辑保持不变
local mit = require("config.filltext.mit")
local user = require("config.filltext.user")

function M.insert_mit_license(filepath)
  local text = mit.mit_license()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

function M.insert_mit_head_license(filepath)
  local text = mit.mit_head_license()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

function M.insert_user_info(filepath)
  local text = user.text()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

return M
