local util = require('util')

vim.opt.clipboard = 'unnamedplus'
vim.opt.inccommand = 'split'

vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

vim.opt.backspace = 'indent,eol,start'
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo//'

vim.g.mapleader = ' '

if util.windows then
  local ALL = { 'n', 'v', 'i', 'c' }

  vim.opt.mouse = 'a'
  vim.keymap.set(ALL, '<LeftMouse>', '<Nop>')
  vim.keymap.set(ALL, '<RightMouse>', '<Nop>')
  vim.keymap.set(ALL, '<MiddleMouse>', '<Nop>')
  vim.keymap.set(ALL, '<ScrollWheelUp>', '5k')
  vim.keymap.set(ALL, '<ScrollWheelDown>', '5j')

  vim.keymap.set('i', '<ScrollWheelUp>', '<C-o>5k')
  vim.keymap.set('i', '<ScrollWheelDown>', '<C-o>5j')
else
  vim.opt.mouse = ''
end
