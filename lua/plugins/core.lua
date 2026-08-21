return {
  'nvim-lua/plenary.nvim',
  'dhruvasagar/vim-table-mode',

  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("nvim-silicon").setup({
        font = "JetBrains Mono=16",
        theme = "OneHalfDark",

        pad_horiz = 20,
        pad_vert = 20,

        line_offset = function(args)
          return args.line1
        end,

        to_clipboard = true,
      })
    end,
    keys = {
      {
        "<M-s>",
        function()
          require("nvim-silicon").clip()
        end,
        mode = { 'n', 'v' },
      },
    },
  }
}
