--=======================================
-- filename:    game.lua
-- author:      Shane Krolikowski
-- created:     Sept. 24, 2017
-- description: Game gamestate
--=======================================

local Grid = require 'grid'
local Display = require 'display'
local LShape = require 'shapes.lshape'
local BLShape = require 'shapes.blshape'
local TShape = require 'shapes.tshape'
local SShape = require 'shapes.sshape'
local ZShape = require 'shapes.zshape'
local LineShape = require 'shapes.lineshape'
local SquareShape = require 'shapes.squareshape'

local Game = {}
local gameOver

local grid = Grid(22, 10)
local display

local currentShape
local nextShape
local shapeMoveTimer = 0
local shapeMoveTimerMax = 30

--=======================================
-- Constructor (only called once)
-- --------------------
-- @return void
--=======================================
function Game:init()
    love.graphics.setBackgroundColor(0, 0, 0, 1)
end

--=======================================
-- Entering game state.
-- --------------------
-- @param from - Previous game state
-- --------------------
-- @return void
--=======================================
function Game:enter(from)
    grid:createBoard()
    display = Display()
    gameOver = false
end

--=======================================
-- Update the game state.
-- --------------------
-- @param dt
-- --------------------
-- @return void
--=======================================
function Game:update(dt)
    if not gameOver then
        if self:needNewShape() then
            currentShape = self:randomShape()

            if self:checkForGameOver() then
                gameOver = true
                return
            end
        end

        if shapeMoveTimer > shapeMoveTimerMax then
            currentShape:move('down')
            self:checkForCompleteRows()
            shapeMoveTimer = 0
        else
            shapeMoveTimer = shapeMoveTimer + 1
        end
    end
end

--=======================================
-- Draw the game state.
-- --------------------
-- @return void
--=======================================
function Game:draw()
    grid:draw()
    display:draw()

    if currentShape ~= nil then
        currentShape:draw()
    end

    if gameOver then
        love.graphics.setColor(1, 1, 1, 0.25)
        love.graphics.printf('GAME OVER', 0, HEIGHT / 2, WIDTH, 'center')
    end
end

--=======================================
-- Check for game over status by
--  determining if current shape is
--  overlapping another.
-- --------------------
-- @return boolean
--=======================================
function Game:checkForGameOver()
    if gameOver or currentShape == nil then
        return true
    end

    return currentShape:isOverlapping()
end

--=======================================
-- Check each row on the grid for a
--  complete row.
-- --------------------
-- @return void
--=======================================
function Game:checkForCompleteRows()
    local completeRowCount = grid:checkForCompleteRows()
    local gameScore = display:getGameScore()

    if completeRowCount == 4 then
        gameScore = gameScore + completeRowCount * 2
    else
        gameScore = gameScore + completeRowCount
    end

    display:setGameScore(gameScore)
end

--=======================================
-- Determine if we need a new shape:
--  - No shape exists.
--  - Current shape is not mobile.
-- --------------------
-- @return boolean
--=======================================
function Game:needNewShape()
    return currentShape == nil or not currentShape.isMobile
end

--=======================================
-- Generate new random shape.
-- --------------------
-- @return Shape
--=======================================
function Game:randomShape()
    local shapes = { LShape, BLShape, TShape, SShape, ZShape, LineShape, SquareShape }
    local shape = shapes[love.math.random(#shapes)]

    return shape(grid, 2, grid:getCols() / 2)
end

--=======================================
-- Signal to quit game.
-- --------------------
-- @return void
--=======================================
function Game:quitGame()
    love.event.quit()
end

--=======================================
-- Signal to move current shape.
-- --------------------
-- @return void
--=======================================
function Game:movePiece(direction)
    currentShape:move(direction)
end

--=======================================
-- Signal to rotate current shape.
-- --------------------
-- @return void
--=======================================
function Game:rotatePiece()
    currentShape:rotate()
end

function Game:pauseGame()
    return Gamestate.push(Pause)
end

--=======================================
-- Input Handler
-- --------------------
-- @return function
--=======================================
function Game:inputHandler(input)
    local bindings = {
        quit   = function() self:quitGame() end,
        left   = function() self:movePiece('left') end,
        right  = function() self:movePiece('right') end,
        down   = function() self:movePiece('down') end,
        rotate = function() self:rotatePiece() end,
        pause  = function() self:pauseGame() end
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
function Game:keypressed(key)
    local keys = {
        w      = 'rotate',
        a      = 'left',
        s      = 'down',
        d      = 'right',
        up     = 'rotate',
        left   = 'left',
        right  = 'right',
        down   = 'down',
        p      = 'pause',
        escape = 'quit'
    }

    return self:inputHandler(keys[key])
end

return Game
