local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'linrongbin16/lsp-progress.nvim',
    },
    opts = function()
        vim.cmd [[
                augroup lualine_augroup
                autocmd!
                autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
                augroup END
            ]]
        local theme = require 'utils.lualine-theme'

        keymap('n', '<leader>lh', "<cmd>lua require('lualine').hide()<cr>", opts)
        keymap('n', '<leader>ls', "<cmd>lua require('lualine').hide({unhide=true})<cr>", opts)

        return {
            options = {
                icons_enabled = true,
                theme = theme 'light',
                section_separators = '',
                component_separators = '',
                fmt = string.lower,
                disabled_filetypes = { 'alpha' },
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str)
                            return (' ' .. str:sub(1, 1)):lower() .. ' '
                        end,
                    },
                },
                lualine_b = {
                    { 'branch' },
                },
                lualine_c = {
                    {

                        'filename',
                        file_status = true,
                        path = 0,
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[nn]',
                            newfile = '[New]',
                        },
                    },
                },
                lualine_x = {
                    {
                        function()
                            return vim.fn.getcwd()
                        end,
                        fmt = function(str)
                            str = str:gsub('%/Users/qualialog/', '~')
                            str = str:gsub('%~Documents/', 'docs/')
                            return str
                        end,
                    },
                    {
                        'diagnostics',
                        sources = {
                            'nvim_diagnostic',
                        },
                        symbols = {
                            error = ' ',
                            warn = ' ',
                            info = ' ',
                            hint = ' ',
                        },
                    },
                },
                lualine_y = {
                    {
                        require('lazy.status').updates,
                        cond = require('lazy.status').has_updates,
                    },
                },
                lualine_z = {
                    {
                        "require('lsp-progress').progress()",
                    },
                },
            },
            inactive_sections = {
                lualine_a = {
                    {
                        'filename',
                        file_status = true,
                        path = 0,
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[nn]',
                            newfile = '[New]',
                        },
                    },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
