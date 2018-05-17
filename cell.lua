--=======================================
-- filename:    cell.lua
-- author:      Shane Krolikowski
-- created:     Sept. 25, 2017
-- description: One cell of the game grid
--=======================================

local Cell = Class{}

local WIDTH = 25
local HEIGHT = 25

function Cell:init(grid, row, col, color, isMobile)
    self.grid = grid
    self.row = row
    self.col = col
    self.color = color
    self.isMobile = isMobile
end

function Cell:draw()
    local x = self.col * WIDTH
    local y = self.row * HEIGHT

    if self.color ~= nil then
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, WIDTH, HEIGHT)
    else
        love.graphics.setColor(1, 1, 1, 0.25)
        love.graphics.rectangle('line', x, y, WIDTH, HEIGHT)
    end
end

--=======================================
-- Determine if cell is currently occupied.
-- --------------------
-- @return boolean
--=======================================
function Cell:isOccupied()
    return self.color ~= nil
end

--=======================================
-- Check to see if cell is able to move
--  to it's new specified position.
-- --------------------
-- @param direction - left, right, or down
-- --------------------
-- @return boolean
--=======================================
function Cell:canMove(direction)
    if self.isMobile then
        if direction == 'left' then
            return self.col > 1 and not self.grid:isCellOccupied(self.row, (self.col - 1))
        elseif direction == 'right' then
            return self.col < self.grid:getCols() and not self.grid:isCellOccupied(self.row, (self.col + 1))
        elseif direction == 'down' then
            return self.row < self.grid:getRows() and not self.grid:isCellOccupied((self.row + 1), self.col)
        end
    end

    return false
end

--=======================================
-- Move cell one unit in specified
--  direction.
-- --------------------
-- @param direction - left, right, or down
-- --------------------
-- @return void
--=======================================
function Cell:move(direction)
    if self:canMove(direction) then
        if direction == 'left' then
            self.col = self.col - 1
        elseif direction == 'right' then
            self.col = self.col + 1
        elseif direction == 'down' then
            self.row = self.row + 1
        end
    end
end

--=======================================
-- Check to see if cell can move to new
--  specified position.
-- --------------------
-- @param row - new row position
-- @param col - new column position
-- --------------------
-- @return boolean
--=======================================
function Cell:canRotate(row, col)
    if row < 1
      or row > self.grid:getRows()
      or col < 1
      or col > self.grid:getCols()
      or self.grid:isCellOccupied(row, col)
    then
        return false
    end

    return true
end

--=======================================
-- Set new location for cell.
-- --------------------
-- @param row - new row position
-- @param col - new column position
-- --------------------
-- @return void
--=======================================
function Cell:rotate(row, col)
    if self:canRotate(row, col) then
        self.row = row
        self.col = col
    end
end

function Cell:getColor()
    return self.color
end

function Cell:setColor(color)
    self.color = color
end

function Cell:getRow()
    return self.row
end

function Cell:getCol()
    return self.col
end

return Cell
