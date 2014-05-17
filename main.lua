
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
	math.randomseed(os.time())

	width, height = love.window.getDimensions()

	for _,v in pairs({"keypressed", "mousepressed", "mousereleased"}) do
		love[v] = function(...)
			if state and state[v] then
				state[v](state, ...)
			end
		end
	end
end

function love.update(dt)
	assert(state)
	assert(state.update)
	state:update(dt)
end

function love.draw()
	assert(state)
	assert(state.draw)
	state:draw()
end

function love.keyreleased(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	elseif state and state.keyreleased then
		state:keyreleased(key, unicode)
	end
end

function love.resize(new_width, new_height)
	assert(type(new_width) == "number")
	assert(type(new_height) == "number")
	width = new_width
	height = new_height
end

