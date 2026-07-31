return {
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt" },
                check_ts = true,
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    "mg979/vim-visual-multi",

    {
        "folke/trouble.nvim",
        opts = {},
    },

    {
      "junegunn/vim-easy-align",
      lazy = false,
      keys = {
        { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
      },
    },

    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    },

    {
        'luochen1990/rainbow',
        lazy = false,
        config = function()
            vim.g.rainbow_active = 1
        end
    },
}
