return {
  'nvim-lua/plenary.nvim',
  'dhruvasagar/vim-table-mode',

  {
    'MagicDuck/grug-far.nvim',
    opts = {},
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = {
      hijack_netrw = true,
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = math.floor(screen_w * 0.8)
            local window_h = math.floor(screen_h * 0.8)
            return {
              border = 'rounded',
              relative = 'editor',
              row = math.floor((screen_h - window_h) / 2),
              col = math.floor((screen_w - window_w) / 2),
              width = window_w,
              height = window_h,
            }
          end,
        },
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        git_clean = false,

        custom = {
          '^\\.git$'
        },
      },
      update_focused_file = {
        enable = true,
        --update_root = true,
      },
    },
    keys = {
      { '-', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle Floating NvimTree' },
    },
  },

  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    opts = {
      font = "JetBrains Mono=16",
      theme = "OneHalfDark",

      pad_horiz = 20,
      pad_vert = 20,

      language = function()
        if vim.bo.filetype == "elash" then
          return "c"
        end

        return vim.bo.filetype
      end,

      line_offset = function(args)
        return args.line1
      end,

      to_clipboard = true,
    },
    keys = {
      {
        "<A-s>",
        function()
          require("nvim-silicon").clip()
        end,
        mode = { 'n', 'v' },
      },
    },
  },
}
