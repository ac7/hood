
class = require "30log"

function set_state(new_state)
	assert(new_state)
	if state and state.stop then
		state:stop()
	end
	state = new_state
	if state.start then
		state:start()
	end
end

function love.load()
	states = {}
	states.play = require "play"
	set_state(states.play)
end

function love.update(dt)
	assert(state)
	state:update(dt)
end

function love.draw()
	assert(state)
	state:draw()
end

function love.keyreleased(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
end

