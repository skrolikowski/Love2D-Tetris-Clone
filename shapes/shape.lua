--=======================================
-- filename:    shape.lua
-- author:      Shane Krolikowski
-- created:     Sept. 25, 2017
-- description: Game shape.
--=======================================

local Shape = Class{}

function Shape:draw()
    for index, cell in pairs(self.cells) do
        cell:draw()
    end
end

--=======================================
-- Rotate shape by moving each cell.
-- --------------------
-- @param direction - left, right, or down
-- --------------------
-- @return void
--=======================================
function Shape:move(direction)
    local canMove = self:canMove(direction)

    if canMove then
        for index, cell in pairs(self.cells) do
            cell:move(direction)
        end
    else
        if direction == 'down' then
            self:freeze()
        end
    end
end

--=======================================
-- Check to see if every cell in this
--  shape is able to move to it's new
--  position.
-- --------------------
-- @param direction - left, right, or down
-- --------------------
-- @return boolean
--=======================================
function Shape:canMove(direction)
    if self.isMobile then
        return self.cells[1]:canMove(direction)
          and self.cells[2]:canMove(direction)
          and self.cells[3]:canMove(direction)
          and self.cells[4]:canMove(direction)
    end

    return false
end

--=======================================
-- Rotate shape by moving each cell.
-- --------------------
-- @param r1 - row displacement for cell 1
-- @param c1 - column displacement for cell 1
-- @param r2 - row displacement for cell 2
-- @param c2 - column displacement for cell 2
-- @param r3 - row displacement for cell 3
-- @param c3 - column displacement for cell 3
-- @param r4 - row displacement for cell 4
-- @param c4 - column displacement for cell 4
-- --------------------
-- @return void
--=======================================
function Shape:rotateShape(r1, c1, r2, c2, r3, c3, r4, c4)
    if self:canRotate(r1, c1, r2, c2, r3, c3, r4, c4) then
        self.cells[1]:rotate(r1, c1)
        self.cells[2]:rotate(r2, c2)
        self.cells[3]:rotate(r3, c3)
        self.cells[4]:rotate(r4, c4)

        if self.position == 4 then
            self.position = 1
        else
            self.position = self.position + 1
        end
    end
end

--=======================================
-- Check to see if every cell in this
--  shape is able to move to it's new
--  position.
-- --------------------
-- @param r1 - row displacement for cell 1
-- @param c1 - column displacement for cell 1
-- @param r2 - row displacement for cell 2
-- @param c2 - column displacement for cell 2
-- @param r3 - row displacement for cell 3
-- @param c3 - column displacement for cell 3
-- @param r4 - row displacement for cell 4
-- @param c4 - column displacement for cell 4
-- --------------------
-- @return boolean
--=======================================
function Shape:canRotate(r1, c1, r2, c2, r3, c3, r4, c4)
    return self.cells[1]:canRotate(r1, c1)
      and self.cells[2]:canRotate(r2, c2)
      and self.cells[3]:canRotate(r3, c3)
      and self.cells[4]:canRotate(r4, c4)
end

--=======================================
-- Check to see if any cells are currently
--  overlapping.
-- --------------------
-- @return boolean
--=======================================
function Shape:isOverlapping()
    return self.grid:isCellOccupied(self.cells[1]:getRow(), self.cells[1]:getCol())
      or self.grid:isCellOccupied(self.cells[2]:getRow(), self.cells[2]:getCol())
      or self.grid:isCellOccupied(self.cells[3]:getRow(), self.cells[3]:getCol())
      or self.grid:isCellOccupied(self.cells[4]:getRow(), self.cells[4]:getCol())
end

function Shape:freeze()
    self.isMobile = false

    for index, cell in pairs(self.cells) do
        self.grid:setCell(cell.row, cell.col, cell.color)
    end
end

function Shape:getPosition()
    return self.position
end

function Shape:setPosition(position)
    self.position = position
end

return Shape
