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
