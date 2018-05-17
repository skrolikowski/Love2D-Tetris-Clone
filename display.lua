--=======================================
-- filename:    display.lua
-- author:      Shane Krolikowski
-- created:     Sept. 26, 2017
-- description: Holds game display information.
--=======================================

local Display = Class{}

function Display:init()
    self.score = 0
end

function Display:draw()
    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.print('Shape Stacker Game', 350, 50)
    love.graphics.print('Score: ' .. self.score, 350, 80)
    love.graphics.print('Press P to pause game.', 350, 150)
    love.graphics.print('Press ESC to exit game.', 350, 180)
end

function Display:setGameScore(score)
    self.score = score
end

function Display:getGameScore()
    return self.score
end

return Display
