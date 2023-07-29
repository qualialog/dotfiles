local set_theme_opts = function(mode, refresh_lualine)
    vim.api.nvim_set_option('background', mode)
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    if refresh_lualine then
        local lualine_theme = require 'utils.lualine-theme'
        require('lualine').setup { options = { theme = lualine_theme(mode) } }
    end
end

return {
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox',
        priority = 1000,
        init = function()
            vim.opt.termguicolors = true
            vim.cmd.colorscheme 'gruvbox'
            set_theme_opts 'light'
        end,
    },
    {
        'f-person/auto-dark-mode.nvim',
        config = {
            update_interval = 1000,
            set_dark_mode = function()
                set_theme_opts('dark', true)
            end,
            set_light_mode = function()
                set_theme_opts('light', true)
            end,
        },
        init = function()
            require('auto-dark-mode').init()
        end,
    },
}
