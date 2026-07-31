-- advanced multi-file config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--if vim.v.servername == "" then
--  vim.fn.serverstart("/tmp/nvim-" .. vim.fn.getpid())
--end
--if vim.fn.has("nvim") == 1 then
--    vim.env.NVIM_LISTEN_ADDRESS = "/tmp/nvim-" .. vim.fn.getpid()
--end

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
