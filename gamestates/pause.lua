--=======================================
-- filename:    game.lua
-- author:      Shane Krolikowski
-- created:     Sept. 24, 2017
-- description: Pause gamestate
--=======================================

local Pause = {}

function Pause:draw()
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.printf('PAUSE', 0, HEIGHT / 2, WIDTH, 'center')
end

--=======================================
-- Unpause the game
-- --------------------
-- @return Gamestate
--=======================================
function Pause:unpauseGame()
    return Gamestate.pop()
end

--=======================================
-- Input Handler
-- --------------------
-- @return function
--=======================================
function Pause:inputHandler(input)
    local bindings = {
        unpause  = function() self:unpauseGame() end
    }

    local action = bindings[input]

    if action then
        return action()
    end
end

--=======================================
-- Input receiver
-- --------------------
-- @return function
--=======================================
function Pause:keypressed(key)
    local keys = {
        p      = 'unpause',
        escape = 'unpause'
    }

    return self:inputHandler(keys[key])
end

return Pause
