return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local lsp_config = require 'lspconfig'

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lsp_config.emmet_ls.setup {
            capabilities = capabilities,
            filetypes = {
                'css',
                'eruby',
                'html',
                'javascript',
                'javascriptreact',
                'less',
                'sass',
                'scss',
                'svelte',
                'pug',
                'typescriptreact',
                'vue',
            },
            init_options = {
                html = {
                    options = {
                        ['bem.enabled'] = true,
                    },
                },
            },
        }

        lsp_config.lua_ls.setup {
            capabilities = capabilities,
            settings = { Lua = { diagnostics = { globals = { 'vim' } }, telemetry = { enable = false } } },
        }

        lsp_config.tsserver.setup {
            capabilities = capabilities,
        }

        lsp_config.marksman.setup {
            capabilities = capabilities,
        }

        lsp_config.pyright.setup {
            capabilities = capabilities,
            filetypes = { 'python' },
            venvPath = '.',
            venv = '.venv',
        }

        lsp_config.eslint.setup {
            capabilities = capabilities,
            bin = 'eslint_d',
            code_actions = {
                enable = true,
                apply_on_save = {
                    enable = true,
                    types = { 'directive', 'problem', 'suggestion', 'layout' },
                },
                disable_rule_comment = {
                    enable = true,
                    location = 'same_line',
                },
            },
            diagnostics = {
                enable = true,
                report_unused_disable_directives = false,
                run_on = 'save',
            },
        }
        lsp_config.tailwindcss.setup {
            capabilities = capabilities,
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            'tw([^])',
                            'tw="([^"])',
                            'tw={"([^"}])',
                        },
                    },
                },
            },
        }

        lsp_config.jsonls.setup {
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas {
                        replace = {
                            ['tsconfig.json'] = {
                                description = 'Custom JSON schema for typescript configuration files',
                                fileMatch = { 'tsconfig*.json' },
                                name = 'tsconfig.json',
                                url = 'https://json.schemastore.org/tsconfig.json',
                            },
                        },
                    },
                    validate = { enable = true },
                },
            },
        }

        lsp_config.yamlls.setup {
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                    },
                    schemas = require('schemastore').yaml.schemas(),
                },
            },
        }
    end,
}
