-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then findme = cmd:sub(0, firstspace - 1) end
    awful.spawn.with_shell(string.format(
                               'pgrep -u $USER -x %s > /dev/null || (%s)',
                               findme, cmd), false)
end

-- Set keyboard layout
awful.util.spawn('bash -c "setxkbmap cz"')

-- Autostart
do
	local stuff = {
		"xset -b", -- turn off beeping
		"picom -b --experimental-backends" -- turn off compositor
		--"discord",
		--"light-locker"
	}
	for _,i in pairs(stuff) do
		run_once(i)
	end
end

return autostart

-- EOF ------------------------------------------------------------------------
