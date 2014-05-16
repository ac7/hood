
local Actor = require "actor"

local Tree = Actor:extends()
local TreeImages = {
	"tree01.png",
	"tree02.png",
	"tree03.png",
	"tree04.png",
}

function Tree:__init()
	Tree.super.__init(self, TreeImages[math.random(#TreeImages)])
end

function Tree:take_damage()
	return nil
end

return Tree

