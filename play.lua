
local State = require "state"
local Archer = require "archer"

local Play = State:extends()
local play = Play()
table.insert(play.actors, Archer())

return play

