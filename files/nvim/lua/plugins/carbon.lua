return {
    {
        'kristijanhusak/vim-carbon-now-sh',
        init = function()
            vim.keymap.set('v', '<leader>cn', ':CarbonNowSh<CR>', { silent = true })
            vim.g.carbon_now_sh_options = {
                ln = 'true',
                fm = 'Source Code Pro',
            }
        end,
    },
}
