local map = vim.keymap.set

map('n', '<C-s>', '<cmd>w<cr>', { silent = true })
map('i', '<C-s>', '<esc><cmd>w<cr>a', { silent = true })

map('n', '<A-j>', ':m .+1<cr>==', { silent = true })
map('n', '<A-k>', ':m .-2<cr>==', { silent = true })
map({ 'v', 'x' }, '<A-j>', ":m '>+1<cr>gv=gv", { silent = true })
map({ 'v', 'x' }, '<A-k>', ":m '<-2<cr>gv=gv", { silent = true })

map('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', '<Up>',   "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j',      "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k',      "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('i', '<Down>', '<Cmd>normal! gj<cr>', { noremap = true, silent = true })
map('i', '<Up>',   '<Cmd>normal! gk<cr>', { noremap = true, silent = true })

-- map('n', '<leader>d', vim.diagnostic.setloclist)
map('n', '<leader>D',  '<cmd>Trouble diagnostics toggle<cr>')
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')

map('n', '<leader>n', '<cmd>noh<cr>')
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

map('n', '<leader>l', function()
  local is_loclist_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.loclist == 1 then
      is_loclist_open = true
      break
    end
  end

  if is_loclist_open then
    vim.cmd('lclose')
  else
    pcall(function() vim.cmd('lopen') end)
  end
end)

map('n', '<leader>P', function()
  local cmd = "git ls-files 2>/dev/null | grep -E '\\.(c|h|cpp|hpp|lua|py|go|rs|ts|js)$' || find . -maxdepth 2 -type f -regex '.*\\.\\(c|h|cpp|hpp|lua|py|go|rs|ts|js\\)$'"
  local files = vim.fn.split(vim.fn.system(cmd), '\n')

  local old_shortmess = vim.opt.shortmess
  vim.opt.shortmess:append('A')

  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      local bufnr = vim.fn.bufadd(file)
      vim.fn.bufload(bufnr)
    end
  end

  vim.opt.shortmess = old_shortmess

  vim.defer_fn(function()
    vim.diagnostic.setqflist({ open = false })
    vim.cmd('Trouble qflist open focus=false')
    vim.notify('Project scan complete: ' .. #files .. ' files analyzed.', vim.log.levels.INFO)
  end, 200)
end)

map('n', '<leader>f', vim.diagnostic.open_float)
map('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
map('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

map('n', '<leader>G', function()
  local pattern = vim.fn.input('Search: ')
  if pattern ~= '' then
    vim.cmd("silent! grep -F -g '!*.d' -g '!*.o' " .. vim.fn.shellescape(pattern))
    if vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd('copen')
    else
      print('No results')
    end
  end
end)

local function open_floating_terminal(cmd)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.jobstart(cmd or vim.o.shell, { term = true })
  vim.cmd('startinsert')

  vim.keymap.set('t', '<Esc>', function()
    vim.api.nvim_buf_delete(buf, { force = true })
  end, { buffer = buf, silent = true })

  vim.api.nvim_create_autocmd('TermClose', {
    buffer = buf,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })
end

map('n', '<leader>ft', open_floating_terminal)
map('n', '<leader>T', function()
  local cmd = vim.fn.input('$ ')
  if cmd ~= '' then
    open_floating_terminal(cmd)
  end
end)
