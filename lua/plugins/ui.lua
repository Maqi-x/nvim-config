return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
        vimgrep_arguments = {
          'rg', '--color=never', '--no-heading', '--with-filename',
          '--line-number', '--column', '--smart-case'
        },
        }
      }
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup({
        --kind = 'floating'
      })
      require('diffview').setup({
        keymaps = {
          view = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
          },
          file_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
          },
        },
      })
    end,
  },

  {
    'vyfor/cord.nvim',
    build = ':Cord update',
    event = 'VeryLazy',
    opts = {
      editor = {
        client = 'neovim',
      },
      display = {
        show_time = true,
      },
    }
  },

  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      highlights = {
        Normal = { bg = '$bg_d' },
        NormalNC = { bg = '$bg_d' },
        EndOfBuffer = { bg = '$bg_d' },
        FloatBorder = { bg = '$bg_d' },
        NvimTreeFloatBorder = { bg = '$bg_d' },
      },
      style = 'darker',
    },
    config = function(_, opts)
      require('onedark').setup(opts)
      require('onedark').load()
    end,
  },
}
