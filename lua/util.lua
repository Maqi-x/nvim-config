local M = {}

M.hostname =
  vim.uv.os_gethostname()

M.windows =
  package.config:sub(1,1) == "\\"

M.mainpc =
  not M.windows and M.hostname == "maqix-pc"

M.laptop =
  not M.windows and M.hostname == "maqix-laptop"

local NONE = {}

function M.when(cond, value)
  return cond and value or NONE
end

function M.compact(t)
  local out = {}
  for i = 1, #t do
    if t[i] ~= NONE then
      out[#out + 1] = t[i]
    end
  end
  return out
end

M.shell = vim.o.shell
if M.windows then
  M.shell = "pwsh.exe"
end

return M
