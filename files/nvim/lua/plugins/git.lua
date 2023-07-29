return {
    {
        'kdheepak/lazygit.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { '<leader>gg', '[[:LazyGit<cr>]]', desc = 'LazyGit' },
        },
        config = function()
            local git = vim.api.nvim_create_augroup('git', {})
            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                group = git,
                callback = function()
                    require('lazygit.utils').project_root_dir()
                end,
            })
        end,
    },
}
