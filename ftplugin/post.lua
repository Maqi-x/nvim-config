local ns = vim.api.nvim_create_namespace("post_syntax_styles")

vim.api.nvim_set_hl(ns, "@markup.italic", { bold = true })
vim.api.nvim_set_hl(ns, "@markup.italic.markdown_inline", { bold = true })

vim.api.nvim_win_set_hl_ns(0, ns)

vim.fn.matchadd("postItalic", [[\/[^/]\+\/]])
vim.api.nvim_set_hl(0, "postItalic", { italic = true })

vim.fn.matchadd("postH1", [[^==\s*.\{-}\s*$]])
vim.fn.matchadd("postH2", [[^---\s*.\{-}\s*$]])

vim.api.nvim_set_hl(0, "postH1", { link = "@markup.heading.1.markdown" })
vim.api.nvim_set_hl(0, "postH2", { link = "@markup.heading.2.markdown" })

vim.fn.matchadd("postComment", [[^\s*::.*$]])
vim.api.nvim_set_hl(0, "postComment", { link = "Comment" })

vim.fn.matchadd("postPropKey", [[^\s*:[^:\n]\+:]])
vim.fn.matchadd("postPropVal", [[^\s*:[^:\n]\+:\zs.*$]])

vim.api.nvim_set_hl(0, "postPropKey", { link = "@property" })
vim.api.nvim_set_hl(0, "postPropVal", { link = "String" })
