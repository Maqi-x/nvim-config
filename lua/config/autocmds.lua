local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.bufhidden = 'wipe'
  end,
})

autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.treesitter.start()
  end,
})

autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {'*.tmLanguage.json', '*.css', '*.zp', '*.lua'},
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

vim.filetype.add({
  extension = {
    zp = 'zap',
    eu = 'elash',
    eh = 'elash',
    al = 'alang',
    rux = 'rux',
    tasm = 'tasm',
    htpl = 'html',
    b = 'b',
  },
})

local function remove_suffix(str, suffix)
  if str:sub(-#suffix) == suffix then
    return str:sub(1, -#suffix - 1)
  end
  return str
end

vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = '󰅚',
        [vim.diagnostic.severity.WARN]  = '󰀪',
        [vim.diagnostic.severity.INFO]  = '󰋽',
        [vim.diagnostic.severity.HINT]  = '󰌶',
      }
      return icons[diagnostic.severity] or '●'
    end,
    source = 'if_many',
    format = function(d)
      if not d.source then
        return remove_suffix(d.message, '.')
      end
      return string.format(
        '%s: %s',
        remove_suffix(d.source, '.'),
        remove_suffix(d.message, '.')
      )
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
