-- advanced multi-file config
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.functions')

-- local configuration
pcall(require, 'local.init')

-- lazy bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local spec = {
  { import = "plugins" },
}

local local_plugins = vim.fn.stdpath("config") .. "/lua/local/plugins"
if vim.uv.fs_stat(local_plugins) then
  table.insert(spec, { import = "local.plugins" })
end

require("lazy").setup({
  spec = spec,
})
