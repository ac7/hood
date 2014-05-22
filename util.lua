
util = {}

function util.dist(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function util.touching(obj1, obj2)
	assert(obj1.x and obj1.y and obj2.x and obj2.y)
	assert(obj1.width and obj1.height and obj2.width and obj2.height)
	return util.dist(obj1.x, obj1.y, obj2.x, obj2.y) < (obj1.width + obj2.width + obj1.height + obj2.height) / 4
end

function util.closest_touching(self, actorlist, validate)
	assert(self)
	assert(self.x and self.y)
	assert(type(actorlist) == "table")
	assert(not validate or type(validate) == "function")
	local closest, closest_dist = nil, nil
	for _, v in pairs(actorlist) do
		if (not validate or validate(v)) and util.touching(self, v) then
			local dist = util.dist(self.x, self.y, v.x, v.y)
			if not closest_dist or dist < closest_dist then
				closest_dist = dist
				closest = v
			end
		end
	end
	return closest
end

function util.direction_from_angle(angle)
	assert(type(angle) == "number")
	if angle < 0 then
		angle = (math.pi * 2) + angle
	end
	local direction = (angle / math.pi * 4) + 1.5 -- convert from radians to our 8-directional system
	direction = math.floor(math.min(8, math.max(1, direction)))
	return direction
end

return util

