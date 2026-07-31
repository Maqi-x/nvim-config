return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width = 30, side = "left" },
                update_focused_file = { enable = true },
                filters = { dotfiles = false },
                git = { ignore = false },
                actions = { open_file = { quit_on_open = false } },
            })
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true })
            vim.keymap.set("n", "<C-d>", "<cmd>NvimTreeToggle<cr>", { silent = true })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('telescope').setup {
              defaults = {
                vimgrep_arguments = {
                  "rg", "--color=never", "--no-heading", "--with-filename",
                  "--line-number", "--column", "--smart-case"
                },
              }
            }

            vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', {silent=true})
            vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope live_grep<CR>', {silent=true})
        end,
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("neogit").setup({
                kind = "floating"
            })
        end,
    },

    {
      "vyfor/cord.nvim",
      build = ":Cord update",
      event = "VeryLazy",
      opts = {
        editor = {
          client = "neovim",
        },
        display = {
          show_time = true,
        },
      }
    },

    {
      "navarasu/onedark.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("onedark").setup({
          style = "deep",
        })
        require("onedark").load()
      end,
    },
}
