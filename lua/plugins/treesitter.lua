return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,

    config = function()
      local ts = require('nvim-treesitter')

      ts.install({
        'c', 'cpp', 'commonlisp', 'python',
        'typescript', 'javascript', 'json',
        'lua', 'markdown', 'bash'
      });

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
