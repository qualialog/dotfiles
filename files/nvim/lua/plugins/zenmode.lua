return {
    'folke/zen-mode.nvim',
    event = 'VeryLazy',
    dependencies = {
        'folke/twilight.nvim',
    },
    keys = {
        { '<leader>zz', '[[:ZenMode<cr>]]', desc = 'Toggle ZenMode' },
    },
    opts = {
        width = 0.5,
    },
}
