local wezterm = require("wezterm")

Color_schemes = {
    dark = "GruvboxDark",
    light = "Gruvbox Light",
}

local function get_mode(appearance)
    if appearance:find("Dark") then
        return "dark"
    else
        return "light"
    end
end

wezterm.on("window-config-reloaded", function(window)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local mode = get_mode(appearance)
    if overrides.color_scheme ~= Color_schemes[mode] then
        overrides.color_scheme = Color_schemes[mode]
        window:set_config_overrides(overrides)
    end
end)
