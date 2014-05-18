
function love.conf(t)
	t.version = "0.9.1"
	t.console = false

	t.window.title = "robinhood"
	t.window.width = 1024
	t.window.height = 576
	t.window.resizable = true
	--[[

	-- uncomment for fullscreen

		t.window.fullscreentype = "desktop"
		t.window.fullscreen = true
	]]

	t.modules.physics = false
	t.modules.joystick = false
end

