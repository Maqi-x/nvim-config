-- note: vibecoded slop don't judge me

local bufnr = vim.api.nvim_get_current_buf()

-- 1. Highlight namespace & group definitions
local ns = vim.api.nvim_create_namespace("post_syntax_styles")
vim.api.nvim_set_hl(ns, "@markup.italic", { bold = true })
vim.api.nvim_set_hl(ns, "@markup.italic.markdown_inline", { bold = true })

vim.api.nvim_set_hl(0, "postItalic", { italic = true })
vim.api.nvim_set_hl(0, "postH1", { link = "@markup.heading.1.markdown" })
vim.api.nvim_set_hl(0, "postH2", { link = "@markup.heading.2.markdown" })
vim.api.nvim_set_hl(0, "postComment", { link = "Comment" })
vim.api.nvim_set_hl(0, "postPropKey", { link = "@property" })
vim.api.nvim_set_hl(0, "postPropVal", { link = "String" })

-- 2. Activate rules for the window showing this .post buffer
local function activate_post_syntax()
  vim.api.nvim_win_set_hl_ns(0, ns)

  if not vim.w.post_match_ids then
    vim.w.post_match_ids = {
      vim.fn.matchadd("postItalic", [[\/[^/]\+\/]]),
      vim.fn.matchadd("postH1", [[^==\s*.\{-}\s*$]]),
      vim.fn.matchadd("postH2", [[^---\s*.\{-}\s*$]]),
      vim.fn.matchadd("postComment", [[^\s*::.*$]]),
      vim.fn.matchadd("postPropKey", [[^\s*:[^:\n]\+:]]),
      vim.fn.matchadd("postPropVal", [[^\s*:[^:\n]\+:\zs.*$]]),
    }
  end
end

-- 3. Deactivate rules when switching away from this .post buffer
local function deactivate_post_syntax()
  vim.api.nvim_win_set_hl_ns(0, 0)

  if vim.w.post_match_ids then
    for _, id in ipairs(vim.w.post_match_ids) do
      pcall(vim.fn.matchdelete, id)
    end
    vim.w.post_match_ids = nil
  end
end

-- Run immediately for current window
activate_post_syntax()

-- Attach buffer-local lifecycle handlers (only affects this specific buffer)
local group = vim.api.nvim_create_augroup("PostSyntax_" .. bufnr, { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  buffer = bufnr,
  group = group,
  callback = activate_post_syntax,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  buffer = bufnr,
  group = group,
  callback = deactivate_post_syntax,
})
