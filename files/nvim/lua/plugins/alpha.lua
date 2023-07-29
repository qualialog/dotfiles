return {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require 'alpha'
        local startify = require 'alpha.themes.startify'

        local group = function(val)
            return {
                type = 'group',
                val = val,
            }
        end

        local function button(sc, txt, keybind, hl_shortcut)
            local btn = startify.button(sc, txt, keybind)
            btn.opts.position = 'center'
            btn.opts.width = 30
            btn.opts.hl_shortcut = {
                { 'AlphaShortcut',           0,       1 },
                { hl_shortcut or 'Operator', 1,       #sc + 1 },
                { 'AlphaShortcut',           #sc + 1, #sc + 2 },
            }

            return btn
        end

        local top_buttons = group {
            button('ff', ' Find file', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>'),
            button('fg', ' Find in files', '<cmd>Telescope live_grep<cr>'),
            button('fb', ' Browse Dir', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>'),
            button('fz', ' Change Dir', '<cmd>Telescope zoxide list<cr>'),
            button('gg', ' Git', '<cmd>LazyGit<cr>'),
        }

        local mid_buttons = group {
            button('nn', ' Local notes', '[[:Flote<cr>]]'),
            button('ng', ' Global notes', '[[:Flote global<cr>]]'),
        }

        local bottom_buttons = group {
            button('q', '  Quit', '<cmd>qa!<cr>', 'Keyword'),
        }

        -- 'Type'
        -- 'AlphaShortcut'
        -- 'AlphaButtons'
        -- 'Keyword'

        alpha.setup {
            layout = {
                { type = 'padding', val = 15 },
                top_buttons,
                { type = 'padding', val = 2 },
                mid_buttons,
                { type = 'padding', val = 2 },
                bottom_buttons,
            },
            opts = {
                position = 'center',
                margin = 5,
                noautocmd = true,
                setup = function()
                    vim.api.nvim_create_autocmd('DirChanged', {
                        pattern = '*',
                        group = 'alpha_temp',
                        callback = function()
                            require('alpha').redraw()
                        end,
                    })
                end,
            },
        }
    end,
}
