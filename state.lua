
local State = class()

function State:__init()
	self.actors = {}
	self.bg_color = {255, 255, 255}
	self.offset_x, self.offset_y = 0, 0
end

function State:update(dt)
	-- update bg color
	local r, g, b, _ = love.graphics.getBackgroundColor()
	local transition_speed = 3.0
	r = r + (self.bg_color[1] - r) * dt * transition_speed
	g = g + (self.bg_color[2] - g) * dt * transition_speed
	b = b + (self.bg_color[3] - b) * dt * transition_speed
	love.graphics.setBackgroundColor(r, g, b)

	for i = #self.actors, 1, -1 do
		local v = self.actors[i]
		assert(v)
		assert(v.update)
		if not v.active then
			table.remove(self.actors, i)
		else
			v:update(dt)
		end
	end
end

function State:draw()
	assert(self.offset_x)
	assert(self.offset_y)
	table.sort(self.actors, function(a1, a2)
		if a1 == nil then
			return false
		end
		if a2 == nil then
			return true
		end
		if a2.ui_element ~= true and a1.ui_element == true then
			return false
		end
		return (a1.y < a2.y)
	end)
	for _, v in pairs(self.actors) do
		assert(v)
		assert(v.draw)
		v:draw(self.offset_x, self.offset_y)
	end
end

return State

