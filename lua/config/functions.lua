local map = vim.keymap.set

--------------- macro backslashes -------------------
map("x", "<leader>m", ":EasyAlign /\\\\/<CR>")
map("n", "<leader>m", function()
  local s, e = vim.fn.line("."), vim.fn.line(".")

  while vim.fn.getline(s - 1):match("\\%s*$") do s = s - 1 end
  if not vim.fn.getline(s):match("^%s*#%s*define") then
    return vim.notify("Not in a C macro", vim.log.levels.ERROR)
  end
  while vim.fn.getline(e):match("\\%s*$") do e = e + 1 end

  vim.cmd(string.format("%d,%dEasyAlign /\\\\/", s, e))
end, { desc = "Align macro backslashes" })

map("n", "<leader>M", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local count = 0
  local i = 1

  while i <= #lines do
    if lines[i]:match("^%s*#%s*define") then
      local s = i
      local e = i

      while e <= #lines and lines[e]:match("\\%s*$") do
        e = e + 1
      end

      if e > s then
        vim.cmd(string.format("%d,%dEasyAlign /\\\\/", s, e))
        count = count + 1
        i = e
      end
    end
    i = i + 1
  end

  if count == 0 then
    vim.notify("No multi-line macros found", vim.log.levels.WARN)
  else
    vim.notify(string.format("Aligned %d macro(s)", count), vim.log.levels.INFO)
  end
end, { desc = "Align all macro backslashes in file" })

-------------- location list --------------
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

-------------------- project scan -----------------
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

map('n', '<A-l>', function()
  local cmd = "run-clang-tidy -p . -header-filter='.*' -quiet 2>/dev/null"
  local output = vim.fn.systemlist(cmd)

  vim.fn.setqflist({}, ' ', { title = 'clang-tidy', lines = output })

  local qf = vim.fn.getqflist()
  local filtered = vim.tbl_filter(function(item)
    local fname = item.bufnr > 0 and vim.api.nvim_buf_get_name(item.bufnr) or ""

    return item.valid == 1
      and not item.text:match("note:")
      and not fname:match("tests/")
      and not fname:match("/usr/include")
  end, qf)

  vim.fn.setqflist(filtered, 'r')
  vim.cmd('copen')
end)

---------------- floating terminal ------------------
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

  map('t', '<Esc>', function()
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
