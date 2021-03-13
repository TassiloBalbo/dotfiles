-- keys.lua
-- Contains Global Keys
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")

-- Custom modules
local notifPop = require("bloat.pop.notif")
local panelPop = require("bloat.pop.panel")
local calPop = require("bloat.pop.cal")
local bling = require("bling")

globalkeys = gears.table.join(
	-- Tabs
	awful.key(
		{ altkey }, "a",
		function() bling.module.tabbed.pick() end,
		{ description = "pick a client to add to tabbing group", group = "Tabs"}
	),
	awful.key(
		{ altkey }, "s",
		function() bling.module.tabbed.iter() end,
		{ description = "iterate through tabbing group", group = "Tabs"}
	),
	awful.key(
		{ altkey }, "d",
		function() bling.module.tabbed.pop() end,
		{ description = "remove focused client from tabbing group", group = "Tabs" }
	),
	-- Show help
	awful.key(
		{ modkey }, "F1",
		hotkeys_popup.show_help,
		{description = "show help", group = "Awesome"}
	),
	-- Go back in tag
	awful.key(
		{ modkey }, "Escape",
		awful.tag.history.restore,
		{description = "go back", group = "Tags"}
	),
	awful.key(
		{ modkey }, "j",
		function() awful.client.focus.byidx(1) end,
		{ description = "focus next by index", group = "Client" }
	),
	awful.key(
		{ modkey }, "k",
		function() awful.client.focus.byidx(-1) end,
		{description = "focus previous by index", group = "Client"}
	),
	awful.key(
		{modkey, shift}, "w",
		function() notifPop.visible = not notifPop.visible end,
		{description = "show notifs", group = "Awesome"}),
	awful.key(
		{modkey, shift}, "d",
		function() panelPop.visible = not panelPop.visible calPop.visible = not calPop.visible end,
		{description = "show panel", group = "Awesome"}
	),
	-- Layout manipulation
	awful.key(
		{modkey, shift}, "j",
		function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "Client" }
	),
	awful.key(
		{modkey, shift}, "k",
		function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "Client" }
	),
	awful.key(
		{modkey, ctrl}, "j",
		function() awful.screen.focus_relative(1) end,
		{ description = "focus the next screen", group = "Screen" }
	),
	awful.key(
		{modkey, ctrl}, "k",
		function() awful.screen.focus_relative(-1) end,
		{ description = "focus the previous screen", group = "Screen" }
	),
	awful.key(
		{ modkey }, "u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "Client" }
	),
	awful.key(
		{ altkey }, "Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then client.focus:raise() end
		end,
		{ description = "go back", group = "Client" }
	),
	awful.key(
		{ modkey }, "x",
		function() exit_screen_show() end,
		{ description = "show exit screen", group = "Awesome"}
	),
	awful.key(
		{ modkey }, "d",
		function() awful.spawn("rofi -show drun") end,
		{ description = "show rofi ", group = "Launcher" }
	),
	awful.key(
		{ modkey }, ".",
		function() awful.spawn("rofi -show emoji -modi emoji") end,
		{ description = "show rofi emoji", group = "Launcher" }
	),
	-- Volume control !! not working
	awful.key(
		{ }, "XF86AudioRaiseVolume",
		function() awful.spawn("pamixer -i 3") end -- os.execute("pamixer -i 3")
	),
	awful.key(
		{ }, "XF86AudioLowerVolume",
		function() awful.spawn("pamixer -d 3") end -- awful.spawn.with_shell("pamixer -d 3")
	),
	awful.key(
		{ }, "XF86AudioMute",
		function() awful.spawn("pamixer -t") end
	),
	-- Spotify control
	awful.key(
		{ }, "XF86AudioPlay",
		helpers.sendToSpotify("PlayPause")
	),
	awful.key(
		{ }, "XF86AudioPrev",
		helpers.sendToSpotify("Previous")
	),
	awful.key(
		{ }, "XF86AudioNext",
		helpers.sendToSpotify("Next")
	),
	-- Screemshots
	awful.key(
		{ }, "Print",
		function() awful.spawn.with_shell("maim -s --format=png /dev/stdout | xclip -selection clipboard -t image/png -i") end
	),
	awful.key(
		{ modkey }, "Print",
		function() awful.spawn.with_shell("maim --format=png ~/Pictures/screenshots/%F_%T.png") end
	),
	awful.key(
		{ modkey, shift }, "Print",
		function() awful.spawn.with_shell("maim -s --format=png ~/Pictures/screenshots/%F_%T.png") end
	),
	-- Launching apps
	awful.key(
		{ modkey }, "Return",
		function() awful.spawn(terminal) end,
		{ description = "open a terminal", group = "Launcher" }
	),
	awful.key(
		{ modkey }, "e",
		function() awful.spawn(filemanager) end,
		{ description = "open file browser", group = "Launcher" }
	),
	awful.key(
		{ modkey }, "w",
		function() awful.spawn.with_shell(browser) end,
		{ description = "open firefox", group = "Launcher" }
	),
	-- restart Awesome
	awful.key(
		{modkey, ctrl}, "r",
		awesome.restart,
		{ description = "reload awesome", group = "Awesome" }
	),
	-- quit Awesome
	awful.key(
		{modkey, shift}, "q",
		awesome.quit,
		{ description = "quit awesome", group = "Awesome" }
	),
	awful.key(
		{ modkey }, "l",
		function() awful.tag.incmwfact(0.05) end,
		{ description = "increase master width factor", group = "Layout" }
	),
	awful.key(
		{ modkey }, "h",
		function() awful.tag.incmwfact(-0.05) end,
		{ description = "decrease master width factor", group = "Layout"}
	),
	awful.key(
		{modkey, shift}, "h",
		function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }
	),
	awful.key(
		{modkey, shift}, "l",
		function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }
	),
	awful.key(
		{modkey, ctrl}, "h",
		function() awful.tag.incncol(1, nil, true) end,
		{ description = "increase the number of columns", group = "layout" }
	),
	awful.key(
		{modkey, ctrl}, "l",
		function() awful.tag.incncol(-1, nil, true) end,
		{ description = "decrease the number of columns", group = "layout" }
	),
	awful.key(
		{ modkey }, "space",
		function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }
	),
	awful.key(
		{modkey, "Shift"}, "space",
		function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }
	),
	-- Set Layout 
	awful.key(
		{modkey, "Control"}, "w",
		function() awful.layout.set(awful.layout.suit.max) end,
		{ description = "set max layout", group = "tag" }
	),
	awful.key(
		{ modkey }, "s",
		function() awful.layout.set(awful.layout.suit.tile) end,
		{ description = "set tile layout", group = "tag" }
	),
	awful.key(
		{modkey, shift}, "s",
		function() awful.layout.set(awful.layout.suit.floating) end,
		{ description = "set floating layout", group = "tag" }
	),
	awful.key(
		{modkey, "Control"}, "n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", {raise = true})
			end
		end,
		{ description = "restore minimized", group = "client" }
	)
)

clientkeys = gears.table.join(
	awful.key(
		{modkey, "Shift"}, "f",
		function(c) c.fullscreen = not c.fullscreen c:raise() end,
		{ description = "toggle fullscreen", group = "client" }
	),
	awful.key(
		{ modkey }, "q",
		function(c) c:kill() end,
		{ description = "close", group = "client" }
	),
	awful.key(
		{modkey, "Control"}, "space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key(
		{modkey, "Control"}, "Return",
		function(c) c:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" }
	),
	awful.key(
		{ modkey }, "o",
		function(c) c:move_to_screen() end,
		{ description = "move to screen", group = "client" }
	),
--	awful.key(
--		{modkey, "Shift"}, "t",
--		function (c) c.ontop = not c.ontop end,
--		{ description = "toggle keep on top", group = "client" }
--	),
	awful.key(
		{modkey, shift}, "b",
		function(c)
			c.floating = not c.floating
			c.width = 400
			c.height = 200
			awful.placement.bottom_right(c)
			c.sticky = not c.sticky
		end,
		{ description = "toggle keep on top", group = "client" }
	),
	awful.key(
		{ modkey }, "n",
		function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end,
		{ description = "minimize", group = "client" }
	),
	awful.key(
		{ modkey }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{ description = "(un)maximize", group = "client" }
	),
	awful.key(
		{modkey, "Control"}, "m",
		function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
		{ description = "(un)maximize vertically", group = "client" }
	),
	awful.key(
		{modkey, "Shift"}, "m",
		function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end,
		{ description = "(un)maximize horizontally", group = "client" }
	),
	-- On the fly useless gaps change
	awful.key(
		{ modkey }, "=",
		function() helpers.resize_gaps(5) end
	),
	awful.key(
		{ modkey }, "-",
		function() helpers.resize_gaps(-5) end
	),
	-- Single tap: Center client 
	-- Double tap: Center client + Floating + Resize
	awful.key(
		{ modkey }, "c",
		function(c)
			awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
			helpers.single_double_tap(nil, function()
				helpers.float_and_resize(c, screen_width * 0.25, screen_height * 0.28)
			end)
		end
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key(
			{ modkey }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then tag:view_only() end
			end,
			{ description = "view tag #" .. i, group = "tag" }
		),
		-- Toggle tag display.
		awful.key(
			{modkey, "Control"}, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then awful.tag.viewtoggle(tag) end
			end,
			{ description = "toggle tag #" .. i, group = "tag" }
		),
		-- Move client to tag.
		awful.key(
			{modkey, "Shift"}, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then client.focus:move_to_tag(tag) end
				end
			end,
			{ description = "move focused client to tag #" .. i, group = "tag" }
		),
		-- Toggle tag on focused client.
		awful.key(
			{modkey, "Control", "Shift"}, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then client.focus:toggle_tag(tag) end
				end
			end,
			{ description = "toggle focused client on tag #" .. i, group = "tag" }
		)
	)
end

clientbuttons = gears.table.join(
	awful.button(
		{}, 1,
		function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end
	),
	awful.button(
		{ modkey }, 1,
		function(c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			if c.maximized == true then c.maximized = false end
			awful.mouse.client.move(c)
		end),
	awful.button(
		{ modkey }, 3,
		function(c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end
	)
)

-- Set keys
root.keys(globalkeys)