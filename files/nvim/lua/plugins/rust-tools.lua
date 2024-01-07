local rt = require 'rust-tools'

return {
    {
        'simrat39/rust-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        ft = { 'rust' },
        config = function()
            local mason_registry = require 'mason-registry'
            mason_registry.refresh()
            local codelldb = mason_registry.get_package 'codelldb'
            local extension_path = codelldb:get_install_path() .. '/extension/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

            require('rust-tools').setup {
                dap = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    on_attach = function(_, bufnr)
                        local opts = { buffer = bufnr, silent = true }
                        vim.keymap.set('n', '<leader>kk', rt.hover_actions.hover_actions, opts)
                        vim.keymap.set('n', '<leader>aa', rt.code_action_group.code_action_group, opts)
                        vim.keymap.set('n', '<leader>rdb', rt.debuggables.debuggables, opts)
                        vim.keymap.set('n', '<leader>rr', rt.runnables.runnables, opts)
                        vim.keymap.set('n', '<leader>roc', rt.open_cargo_toml.open_cargo_toml, opts)
                        vim.keymap.set('n', '<leader>rsh', rt.inlay_hints.set, opts)
                        vim.keymap.set('n', '<leader>rhh', rt.inlay_hints.unset, opts)
                        vim.keymap.set('n', '<leader>rmu', '<cmd>RustMoveItemUp<CR>', opts)
                        vim.keymap.set('n', '<leader>rmd', '<cmd>RustMoveItemDown<CR>', opts)
                    end,
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = true,
                            },
                            check = {
                                command = 'clippy',
                                extraArgs = { '--all', '--', '-W', 'clippy::all' },
                            },
                            lens = {
                                enable = true,
                            },
                            procMacros = {
                                enabled = true,
                            },
                        },
                    },
                },
            }
        end,
    },
}
