---------------------------
--     awesome theme     --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local config_path = gfs.get_configuration_dir()

local awful = require("awful")

local shared = {}
local theme = {}

-- path to background folder
theme.wallpaper_folder     = config_path.."/backgrounds/"

local wallpapers = {
    "aurora.jpg",
    "iss.jpg",
    "sunset.jpg",
    "snowy.jpg",
}

shared.wallpaper_current = 1

shared.wallpaper_current_increment = function()
    if shared.wallpaper_current + 1 > #wallpapers then
        shared.wallpaper_current = 1
    end
    shared.wallpaper_current = shared.wallpaper_current + 1
end

--local wallpaper = "aurora.jpg"

--local wallpaper_current = 2
--local wallpaper = "iss.jpg"

--local wallpaper_current = 3
--local wallpaper = "sunset.jpg"

--local wallpaper_current = 4
--local wallpaper = "snowy.jpg"

-- path to background
if shared.wallpaper_current then
    wallpaper = wallpapers[shared.wallpaper_current]
end

theme.wallpaper     = theme.wallpaper_folder..wallpaper

local accents = {}
accents[wallpaper]      = "#00cccc" -- default
accents["aurora.jpg"]   = "#00cccc"
accents["iss.jpg"]      = "#55cc77"
accents["sunset.jpg"]   = "#ba8fff"
accents["snowy.jpg"]    = "#888888"

local recursed = false
function configure_wallpaper(predefined)
    if predefined then
        theme.accent = accents[wallpaper]
        return
    end
    local contrast = 1000
    local brightness = 50
    local handle = io.open(theme.wallpaper .. ".cached")
    if handle ~= nil then
        theme.accent = handle:read"*a"
        handle:close()
    else
        if recursed then return end
        os.execute("convert " .. theme.wallpaper .. " -resize 1920x1080 -crop 1280x720+320+180 -brightness-contrast " .. brightness .. " -contrast-stretch " .. contrast .. " -colors 1 -unique-colors -depth 6 txt:- | sed -n '2p' | cut -f 4 -d ' ' | tr -d '\n' > " .. theme.wallpaper .. ".cached")
        configure_wallpaper()
    end
end
shared.configure_wallpaper = configure_wallpaper

configure_wallpaper(true)

theme.font          = "Source Code Pro Bold 10"

theme.bg_normal     = "#121212"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ffd5cd"
theme.fg_focus      = theme.accent
theme.fg_urgent     = "#d6295a"
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = 20
theme.border_width  = 3
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.accent
theme.border_marked = "#91231c"

theme.wibar_height = 14


theme.bar_x         = 15
theme.bar_height    = 26
theme.bar_gap       = 5

theme.tagbox_width  = 252
theme.tagbox_round  = 10
theme.tagbox_hover_bg = "#202020"
theme.tagbox_hover_fg = "#ff0000"

theme.keyboardlayoutbox_width = 32
theme.timebox_width = 75

theme.sysbox_width  = 120
theme.sysbox_icon_size  = theme.bar_height - 10
theme.systray_icon_spacing = 5

theme.taglist_fg_empty = "#404040"
theme.taglist_fg_occupied = theme.fg_normal

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

--[[
-- Generate taglist squares:
local taglist_square_size = 8
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
]]--
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_opacity = 0.5

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

--[[ unused
-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
]]--

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.shared = shared
theme.shared.theme = theme
return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
