return {
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        opts = {
            ensure_installed = {
                'lua_ls',
                'tsserver',
                'marksman',
                'eslint',
                'tailwindcss',
                'jsonls',
                'yamlls',
                'pyright',
                'emmet_ls',
            },
        },
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = function()
            return {
                ensure_installed = {
                    'codelldb',
                },
            }
        end,
    },
    {
        'jay-babu/mason-null-ls.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        opts = function()
            local nls = require 'null-ls'
            local lsp_config = require 'lspconfig'
            return {
                ensure_installed = {
                    'stylua',
                    'eslint_d',
                    'prettier_d',
                    'mypy',
                    'ruff',
                    'black',
                    'debugpy',
                    'rust-analyzer',
                },
                automatic_installation = false,
                handlers = {
                    mypy = nls.builtins.diagnostics.mypy.with {
                        extra_args = function()
                            return { '--python-executable', '~/.pyenv/shims/python' }
                        end,
                    },
                    eslint_d = nls.builtins.diagnostics.eslint_d.with {
                        env = {
                            ESLINT_D_LOCAL_ESLINT_ONLY = true,
                        },
                        settings = {
                            workingDirectory = { mode = 'location' },
                        },
                        root_dir = lsp_config.util.find_git_ancestor,
                    },
                    prettier_d = nls.builtins.formatting.prettierd.with {
                        prefer_local = true,
                        exe = 'prettierd',
                        args = { vim.api.nvim_buf_get_name(0) },
                        stdin = true,
                    },
                },
            }
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        opts = {},
    },
}
