return {
    {

        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy',
            'petertriho/cmp-git',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind.nvim',
            'f3fora/cmp-spell',
            {
                'David-Kunz/cmp-npm',
                dependencies = { 'nvim-lua/plenary.nvim' },
                ft = 'json',
                config = function()
                    require('cmp-npm').setup {}
                end,
            },
            {
                'KadoBOT/cmp-plugins',
                config = function()
                    require('cmp-plugins').setup {
                        files = { '.*\\.lua' },
                    }
                end,
            },
        },
        opts = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'

            return {
                snippet = {
                    expand = function(args)
                        require('snippy').expand_snippet(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                },
                formatting = {
                    format = lspkind.cmp_format {
                        mode = 'symbol_text',
                        menu = {
                            buffer = '[buf]',
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[api]',
                            path = '[path]',
                            snippy = '[snip]',
                            cmdline = '[cmd]',
                            spell = '[spell]',
                            npm = '[npm]',
                        },
                    },
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'snippy' },
                    {
                        name = 'buffer',
                        keyword_length = 5,
                    },
                    { name = 'path' },
                    { name = 'plugins' },
                    {
                        name = 'npm',
                        keyword_length = 4,
                    },
                    {
                        name = 'spell',
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return true
                            end,
                        },
                    },
                }, {
                    { name = 'buffer' },
                }),
                cmp.setup.filetype('gitcommit', {
                    sources = cmp.config.sources({
                        { name = 'git' },
                    }, {
                        { name = 'buffer' },
                    }),
                }),
                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' },
                    },
                }),
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'path' },
                    }, {
                        { name = 'cmdline' },
                    }),
                }),
                experimental = {
                    -- ghost_text = { enabled = true },
                },
            }
        end,
    },
    {
        'onsails/lspkind.nvim',
        init = function()
            local lspkind = require 'lspkind'
            lspkind.init()
        end,
    },
}
