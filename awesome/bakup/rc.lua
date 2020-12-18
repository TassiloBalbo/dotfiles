-- rc.lua
-- Main Config

pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
require("collision")()

-- Custom imports
local helpers = require("helpers")

-- Autostart and Errors --------------------------------------------------------

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end

-- Variables & Inits -----------------------------------------------------------

theme = "ghosts"
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
gui_editor = os.getenv("GUI_EDITOR") or "code"
browser = "firefox"
--filemanager = "thunar"
discord = "discord"
modkey = "Mod4"
altkey = "Mod1"
ctrl = "Control"

local vi_focus = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274

-- Set Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/" .. theme .. "/theme.lua")

-- Layouts
require("windows")

local icons = require("icons")
icons.init("sheet")

-- Menu
myawesomemenu = {
	{
		"hotkeys",
		function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
	}, {"edit config", editor_cmd .. " " .. awesome.conffile},
	{"restart", awesome.restart}, {"quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
	items = {
		{"awesome", myawesomemenu, icons.awesome_menu}, {"Terminal", terminal},
		{"Web Browser", browser}, {"File Manager", filemanager}
	}
})

-- Keys ------------------------------------------------------------------------

root.buttons(gears.table.join(awful.button({}, 3,
							function() mymainmenu:toggle() end),
								awful.button({}, 4, awful.tag.viewnext),
								awful.button({}, 5, awful.tag.viewprev)))

-- Key Bindings
require("keys")

-- Rules -----------------------------------------------------------------------

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
			rule = {},
			properties = {
					border_width = beautiful.border_width,
					border_color = beautiful.border_normal,
					focus = awful.client.focus.filter,
					raise = true,
					size_hints_honor = false,
					keys = clientkeys,
					buttons = clientbuttons,
					screen = awful.screen.preferred,
					placement = awful.placement.centered + awful.placement.no_overlap +
							awful.placement.no_offscreen
			}
	}, {rule = {}, properties = {}, callback = awful.client.setslave}, -- so items in tasklist have the right order 
	-- Floating clients.
	{
			rule_any = {
					instance = {
							"DTA", -- Firefox addon DownThemAll.
							"copyq", -- Includes session name in class.
							"pinentry"
					},
					class = {
							"Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
							"Sxiv", "fzfmenu", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
							"Wpa_gui", "veromix", "xtightvncviewer", "Steam"
					},

					-- Note that the name property shown in xprop might be set slightly after creation of the client
					-- and the name shown there might not match defined rules here.
					name = {
							"Event Tester" -- xev.
					},
					role = {
							"AlarmWindow", -- Thunderbird's calendar.
							"ConfigManager", -- Thunderbird's about:config.
							"pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
					}
			},
			properties = {floating = true}
	},

	-- Add titlebars to normal clients and dialogs (UNCOMMENT FOR DOUBLE BORDERS)
	{rule_any = {type = {"dialog"}}, properties = {titlebars_enabled = false}},
	{
			rule_any = {class = {"Steam"}},
			properties = {titlebars_enabled = false, ontop = true}
	}, -- Set Firefox to always map on the tag named "2" on screen 1.
	--   { rule = { class = "Firefox" },
	--     properties = {  tag = 2 } },
	{
			rule_any = {
					instance = {"scratch"},
					class = {"scratch"},
					icon_name = {"scratchpad_urxvt"}
			},
			properties = {
					skip_taskbar = false,
					floating = true,
					ontop = false,
					minimized = true,
					sticky = false,
					width = screen_width * 0.5,
					height = screen_height * 0.5
			},
			callback = function(c)
					awful.placement.centered(c, {
							honor_padding = true,
							honor_workarea = true
					})
					gears.timer.delayed_call(function() c.urgent = false end)
			end
	}
}

-- Signals & Imports ----------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and
			not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
	end

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
										function(c) c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus",
										function(c) c.border_color = beautiful.border_normal end)

-- Import Daemons and Widgets
require("ears")
require("notifs")
require("bloat")



--[[
awful.util.terminal = terminal
awful.util.tagnames = { "[www]", "[code0]", "[code1]", "[chat]", "[spotify]" }
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	--awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier,
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.corner.ne,
	--awful.layout.suit.corner.sw,
	--awful.layout.suit.corner.se,
	--lain.layout.cascade,
	--lain.layout.cascade.tile,
	--lain.layout.centerwork,
	--lain.layout.centerwork.horizontal,
	--lain.layout.termfair,
	--lain.layout.termfair.center,
}


awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)--]]

--[[ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
--]]

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- possible workaround for tag preservation when switching back to default screen:
-- https://github.com/lcpz/awesome-copycats/issues/251

-- ### Double click on titlebar to maximize/minimize ###
	-- Double click titlebar
function double_click_event_handler(double_click_event)
	if double_click_timer then
		double_click_timer:stop()
		double_click_timer = nil
		return true
	end
	
	double_click_timer = gears.timer.start_new(0.20, function()
		double_click_timer = nil
		return false
	end)
end

awful.util.spawn('bash -c "setxkbmap cz"')

-- Autostart

