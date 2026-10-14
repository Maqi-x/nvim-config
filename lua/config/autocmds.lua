local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.bufhidden = 'wipe'
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
  pattern = {
    '*.tmLanguage.json',
    '*.html', '*.css',
    '*.zp', '*.lua',
  },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

local function is_source_keyvalue(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, 10, false)
  if #lines == 0 then return false end

  for _, line in ipairs(lines) do
    if line:match('^%s*[%w_]+%s*:') then
      return false
    end
  end

  local kv_pattern = '^%s*"([^"]+)"%s*"([^"]*)"'
  local kv_block_pattern = '^%s*"([^"]+)"%s*{'

  for _, line in ipairs(lines) do
    if line:match(kv_pattern) or line:match(kv_block_pattern) then
      return true
    end
  end

  return false
end

vim.treesitter.language.register('markdown', 'post')
vim.filetype.add({
  extension = {
    zp = 'zap',
    eu = 'elash',
    eh = 'elash',
    al = 'alang',
    rux = 'rux',
    tasm = 'tasm',
    htpl = 'html',
    post = 'post',
    nut = 'rsquirrel',
    gnut = 'rsquirrel',
    b = 'b',

    yate = function(path, _)
      local base_ext = path:match("%.([%w_]+)%.yate$")
      if base_ext then
        return base_ext .. '.yate'
      end
      return 'yate'
    end,
  },
  pattern = {
    ['.*%.txt'] = {
      function(_, bufnr)
        if is_source_keyvalue(bufnr) then
          return 'kv'
        end
        return nil
      end,
      priority = 100,
    },
  },
})

-- lua sucks
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
      return remove_suffix(d.message, '.')
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
