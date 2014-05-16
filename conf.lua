
function love.conf(t)
	t.version = "0.9.1"
	t.console = false

	t.window.title = "robinhood"
	t.window.width = 960
	t.window.height = 540
	t.window.resizable = true

	t.modules.physics = false
	t.modules.joystick = false
end

