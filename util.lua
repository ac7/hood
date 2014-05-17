
util = {}

function util.dist(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function util.touching(obj1, obj2)
	assert(obj1.x and obj1.y and obj2.x and obj2.y)
	assert(obj1.width and obj1.height and obj2.width and obj2.height)
	return util.dist(obj1.x, obj1.y, obj2.x, obj2.y) < (obj1.width + obj2.width + obj1.height + obj2.height) / 4
end

return util

