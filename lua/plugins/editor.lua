return {
  {
    'windwp/nvim-autopairs',
    opts = {
      disable_filetype = { 'TelescopePrompt' },
      check_ts = true,
    },
  },

  'mg979/vim-visual-multi',

  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    'folke/trouble.nvim',
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },

  {
    'junegunn/vim-easy-align',
    lazy = false,
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
    },
  },

  {
    'luochen1990/rainbow',
    lazy = false,
    config = function()
      vim.g.rainbow_active = 1
    end
  },
}
