return {
    'JellyApple102/flote.nvim',
    event = { 'VimEnter' },
    opts = {
        notes_dir = '~/Documents/notes/dev-notes',
        window_title = 'Notes',
        window_style = 'minimal',
        window_border = 'single',
        files = {
            cwd = function()
                return vim.fn.getcwd()
            end,
            global = '__global.md',
        },
        file_name = function(cwd)
            local base_name = vim.fs.basename(cwd)
            local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
            return parent_base_name .. '_' .. base_name .. '.md'
        end,
    },
    keys = {
        { '<leader>nn', '[[:Flote<cr>]]',        desc = 'Flote' },
        { '<leader>ng', '[[:Flote global<cr>]]', desc = 'Flote global' },
    },
}
