return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "clangd",
                    "pyright",
                    "rust_analyzer",
                    "lua_ls",
                    "ts_ls",
                    "denols",
                    "bashls",
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            end

            vim.lsp.config("gopls", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            vim.lsp.config("clangd", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--query-driver=" .. os.getenv("HOME") .. "/.platformio/packages/toolchain-xtensa-esp32s3/bin/*",
                    "--all-scopes-completion",
                    "--completion-style=detailed",
                },
            })

            vim.lsp.config("bashls", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                checkOnSave = {
                    enable = true,
                    command = "check",
                },
                diagnostics = {
                    experimental = {
                        enable = false,
                    },
                },
            })

            vim.lsp.config("eslint", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = { "vim" },
                            disable = { "undefined-global" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
              pattern = "pascal",
              callback = function(args)
                vim.lsp.start({
                    name = "pasls",
                    cmd = { "pasls" },
                    root_dir = vim.fs.root(args.buf, { ".pasls.json", ".git" }),
                    settings = {},
                    capabilities = capabilities,
                    on_attach = on_attach,
                        fpcOptions = {
                            "-Fu/usr/lib/fpc/3.2.2/units/x86_64-linux/rtl",
                            "-Fu" .. vim.fn.getcwd() .. "/**",
                        },
                        symbolDatabase = vim.fn.stdpath("cache") .. "/pasls_symbols.db"
                    })
                end,
            })

            -- made by ai; don't ask me how this works
            -- MANUAL DENO SETUP (Bypassing lspconfig root detection issues)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
                callback = function(ev)
                    local root = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { path = ev.file, upward = true })[1])
                    if root then
                        vim.lsp.start({
                            name = "denols",
                            cmd = { "deno", "lsp" },
                            root_dir = root,
                            capabilities = capabilities,
                            on_attach = on_attach,
                            init_options = {
                                enable = true,
                                lint = true,
                                unstable = true,
                            },
                        })
                    end
                end,
            })
        end,
    },

    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("clangd_extensions").setup()
      end,
    },

    {
      "davidmh/mdx.nvim",
      dependencies = {"nvim-treesitter/nvim-treesitter"}
    },

    {
      "akinsho/flutter-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
      config = function()
        require("flutter-tools").setup({
          flutter_path = "/usr/bin/flutter",
          dart_path = "/usr/bin/dart",
          widget_guides = {
            enabled = true,
          },
          dev_log = {
            enabled = true,
            open_cmd = "tabedit",
          },
          lsp = {
            color = { enabled = true },
            on_attach = function(_, bufnr)
              local bufopts = { noremap=true, silent=true, buffer=bufnr }
              vim.keymap.set('n', '<leader>rf', "<cmd>FlutterReload<CR>", bufopts)
              vim.keymap.set('n', '<leader>rh', "<cmd>FlutterRestart<CR>", bufopts)
            end,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          },
          debugger = {
            enabled = true,
            run_via_dap = true,
          },
        })
      end
    },
}
