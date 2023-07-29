return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<cr>' },
            { '<leader>fa', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>' },
            { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>' },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
            { '<leader>fz', '<cmd>Telescope zoxide list<cr>' },
            { '<leader>fd', '<cmd>Telescope diagnostics<cr>' },
            { '<leader>fr', '<cmd>Telescope lazygit<cr>' },
        },
        init = function()
            require('telescope').load_extension 'fzf'
            require('telescope').load_extension 'zoxide'
            require('telescope').load_extension 'file_browser'
            require('telescope').load_extension 'media_files'
            require('telescope').load_extension 'lazygit'
            require('telescope').load_extension 'tasks'

            local menu_default_gen = require('telescope').extensions.tasks.generators.default
            menu_default_gen.all()

            local trouble = require 'trouble.providers.telescope'

            local zoxide_group = vim.api.nvim_create_augroup('zoxide', {})
            vim.api.nvim_create_autocmd({ 'DirChanged' }, {
                group = zoxide_group,
                callback = function(ev)
                    vim.fn.system { 'zoxide', 'add', ev.file }
                end,
            })

            return {
                defaults = {
                    mappings = {
                        i = { ['<c-t>'] = trouble.open_with_trouble },
                        n = { ['<c-t>'] = trouble.open_with_trouble },
                    },
                },
                extensions = {
                    file_browser = {
                        theme = 'ivy',
                        hijack_netrw = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                    zoxide = {
                        prompt_title = 'zoxide',
                        mappings = {
                            default = {
                                after_action = function(selection)
                                    print('Update to (" .. selection.z_score .. ")' .. selection.path)
                                    vim.cmd 'e .'
                                end,
                            },
                        },
                    },
                    media_files = {
                        filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'ico' },
                    },
                    tasks = {
                        theme = 'ivy',
                        output = {
                            style = 'float',   -- "split" | "float" | "tab"
                            layout = 'center', -- "left" | "right" | "center" | "below" | "above"
                            scale = 0.4,       -- output window to editor size ratio
                            -- NOTE: scale and "center" layout are only relevant when style == "float"
                        },
                        -- other picker setup values
                    },
                },
            }
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>b', ':Telescope file_browser path=%:p:h select_buffer=true<CR>' },
        },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    {
        'jvgrootveld/telescope-zoxide',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'nvim-telescope/telescope-media-files.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        keys = {
            { '<leader>fm', ':Telescope media_files<cr>' },
        },
        opts = {},
    },
    {
        'lpoto/telescope-tasks.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
}
