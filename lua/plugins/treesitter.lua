return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local ok, configs = pcall(require, "nvim-treesitter.configs")
            if not ok then return end
            configs.setup({
                ensure_installed = {
                    "c", "cpp", "commonlisp", "python",
                    "typescript", "javascript", "json",
                    "lua", "markdown", "bash",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
