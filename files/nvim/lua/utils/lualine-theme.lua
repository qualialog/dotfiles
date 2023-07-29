return function(mode)
    local colors = {
        dark = {
            bg = nil,
            fg = '#ebdbb2',
        },
        light = {

            bg = nil,
            fg = '#282828',
        },
    }

    local fg = colors[mode].fg
    local bg = colors[mode].bg

    local modeColors = {
        a = { fg = fg, bg = bg, gui = 'bold' },
        b = { fg = fg, bg = bg },
        c = { fg = fg, bg = bg },
    }

    return {
        normal = modeColors,
        command = modeColors,
        inactive = modeColors,
        insert = modeColors,
        replace = modeColors,
        terminal = modeColors,
        visual = modeColors,
    }
end
