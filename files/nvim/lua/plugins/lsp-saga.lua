local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

return {
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            symbol_in_winbar = {
                enable = false,
            },
            ui = {
                border = 'rounded',
            },
            lightbulb = {
                enable = false,
            },
        },
        init = function()
            keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
            keymap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
            keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
            -- keymap('n', 'gr', '<cmd>Lspsaga rename ++project<CR>', opts)
            keymap('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
            keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
            keymap('n', 'gt', '<cmd>Lspsaga peek_type_definition<CR>', opts)
            keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<CR>', opts)

            keymap('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)

            keymap('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
            keymap('n', '<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
            keymap('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
            keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
            keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
            keymap('n', '[E', function()
                require('lspsaga.diagnostic'):goto_prev {
                    severity = vim.diagnostic.severity.ERROR,
                }
            end, opts)
            keymap('n', ']E', function()
                require('lspsaga.diagnostic'):goto_next {
                    severity = vim.diagnostic.severity.ERROR,
                }
            end, opts)
            keymap('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)
            keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
            keymap('n', '<Leader>ci', '<cmd>Lspsaga incoming_calls<CR>', opts)
            keymap('n', '<Leader>co', '<cmd>Lspsaga outgoing_calls<CR>', opts)
            keymap({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<CR>', opts)

            keymap('n', '<leader>f', vim.lsp.buf.format)

            -- format on save
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup 'format_on_save',
                callback = function(event)
                    vim.lsp.buf.format { buffer = event.buf }
                end,
            })
        end,
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            -- Lua
            vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
            vim.keymap.set(
                'n',
                '<leader>xw',
                '<cmd>TroubleToggle workspace_diagnostics<cr>',
                { silent = true, noremap = true }
            )
            vim.keymap.set(
                'n',
                '<leader>xd',
                '<cmd>TroubleToggle document_diagnostics<cr>',
                { silent = true, noremap = true }
            )
            vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true, noremap = true })
            vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', { silent = true, noremap = true })
        end,
    },
}
