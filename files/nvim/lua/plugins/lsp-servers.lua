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
        'jay-babu/mason-null-ls.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        opts = function()
            local nls = require 'null-ls'
            return {
                ensure_installed = {
                    'stylua',
                    'eslint_d',
                    'prettierd',
                    'mypy',
                    'ruff',
                    'black',
                    'debugpy',
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
