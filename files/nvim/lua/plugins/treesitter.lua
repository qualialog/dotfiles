return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
        {
            'kylechui/nvim-surround',
            version = '*',
            event = 'VeryLazy',
            opts = {},
        },
        {

            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            opts = {
                disable_filetype = {
                    'TelescopePrompt',
                    'vim',
                },
            },
        },
        {
            'windwp/nvim-ts-autotag',
            opts = {},
        },
        {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        {
            'numToStr/Comment.nvim',
            opts = {},
        },
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'vimdoc',
                'javascript',
                'tsx',
                'typescript',
                'toml',
                'php',
                'json',
                'yaml',
                'swift',
                'css',
                'html',
                'lua',
                'markdown',
                'markdown_inline',
                'regex',
                'vim',
                'bash',
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
        }
    end,
}
