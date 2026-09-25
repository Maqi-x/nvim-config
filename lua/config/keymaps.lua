local map = vim.keymap.set

map('n', '<A-j>', ':m .+1<cr>==', { silent = true })
map('n', '<A-k>', ':m .-2<cr>==', { silent = true })
map({ 'v', 'x' }, '<A-j>', ":m '>+1<cr>gv=gv", { silent = true })
map({ 'v', 'x' }, '<A-k>', ":m '<-2<cr>gv=gv", { silent = true })

map('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', '<Up>',   "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j',      "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k',      "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('i', '<Down>', '<cmd>normal! gj<cr>', { noremap = true, silent = true })
map('i', '<Up>',   '<cmd>normal! gk<cr>', { noremap = true, silent = true })

map('n', '<leader>D',  '<cmd>Trouble diagnostics toggle<cr>')
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')

map('n', '<leader>n', '<cmd>noh<cr>')
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>d', '<cmd>ClangdSwitchSourceHeader<cr>')

map('n', '<leader>p', '<cmd>Telescope find_files<cr>', { silent = true })
map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')

map({ 'n', 'i', 'v' }, '<A-q>', '<cmd>wqa<cr>')

map('n', '<A-f>', '<cmd>Telescope lsp_references<cr>')
map('n', '<A-d>', '<cmd>Telescope lsp_definitions<cr>')
map('n', '<A-i>', '<cmd>Telescope lsp_implementations<cr>')
map('n', '<A-t>', '<cmd>Telescope lsp_type_definitions<cr>')

map('n', '<A-g>', '<cmd>Neogit<cr>',                { silent = true })
map('n', '<A-e>', '<cmd>DiffviewOpen --staged<cr>', { silent = true })
map('n', '<A-w>', '<cmd>DiffviewOpen<cr>',          { silent = true })

map({ 'n', 'v' }, '<A-d>', '"_d', { silent = true })
map({ 'n', 'v' }, '<A-c>', '"_c', { silent = true })

map('n', '<A-m>', '<cmd>make<cr>')
map('n', '<A-r>', '<cmd>GrugFar<cr>', { silent = true })

map('n', '<leader>f', vim.diagnostic.open_float)
map('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
map('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
