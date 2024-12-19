-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local wezconfig = wezterm.config_builder()

-- This is where you actually apply your config choices
wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

wezconfig.font_size = 13 
wezconfig.font = wezterm.font 'Fira Code'
--wezconfig.use_resize_increments = true
wezconfig.native_macos_fullscreen_mode = true


-- Color scheme
-- (Inspired by theherk https://github.com/wez/wezterm/issues/2376#issuecomment-1208816450)
local selected_scheme = 'Kanagawa (Gogh)'
local scheme = wezterm.get_builtin_color_schemes()[selected_scheme]
local C_BG = scheme.background;
local C_HL_1 = scheme.ansi[3];
local C_HL_2 = scheme.ansi[4];
local C_HL_3 = scheme.ansi[1];
local C_INACTIVE_FG;
local bg = wezterm.color.parse(scheme.background);
local _, _, l, _ = bg:hsla();
if l > 0.5 then
    C_INACTIVE_FG = bg:complement_ryb():darken(0.3);
else
    C_INACTIVE_FG = bg:complement_ryb():lighten(0.3);
end

scheme.tab_bar = {
    background = C_BG,
}

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
    if tab.is_active then
        return {
            {Background={Color=C_BG}},
            {Foreground={Color=C_HL_1}},
            {Text=" " .. tab.tab_index+1},
            {Foreground={Color=C_HL_2}},
            {Text=": "},
            {Text=tab.active_pane.title .. " "},
            {Foreground={Color=C_HL_1}},
        }
    end
    return {
        {Background={Color=C_HL_3}},
        {Foreground={Color=C_HL_1}},
        {Text=" " .. tab.tab_index+1},
        {Foreground={Color=C_HL_2}},
        {Text=": "},
        {Foreground={Color=C_INACTIVE_FG}},
        {Text=tab.active_pane.title .. " "},
        {Foreground={Color=C_HL_1}},
    }
end
)

wezconfig.color_schemes = {
    [selected_scheme] = scheme
}
wezconfig.color_scheme = selected_scheme
wezconfig.use_fancy_tab_bar = false
wezconfig.tab_bar_at_bottom = true
wezconfig.hide_tab_bar_if_only_one_tab = true
wezconfig.show_new_tab_button_in_tab_bar = false

return wezconfig
