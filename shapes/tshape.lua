--=======================================
-- filename:    tshape.lua
-- author:      Shane Krolikowski
-- created:     Sept. 26, 2017
-- description: T shape.
--=======================================

local Cell = require 'cell'

local TShape = Class{
    __includes = require 'shapes.shape'
}

local color = { 1, 1, 1, 0.75 } -- white

function TShape:init(grid, row, col)
    self.grid = grid
    self.row = row
    self.col = col
    self.position = 1
    self.isMobile = true

    self.cells = {
        Cell(grid, row - 1, col + 0, color, self.isMobile),
        Cell(grid, row + 0, col + 0, color, self.isMobile),
        Cell(grid, row + 0, col - 1, color, self.isMobile),
        Cell(grid, row + 0, col + 1, color, self.isMobile)
    }
end

--=======================================
-- Rotate this shape.
-- --------------------
-- @return void
--=======================================
function TShape:rotate()
    local r1, c1, r2, c2, r3, c3, r4, c4

    if self.position == 1 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row + 1, self.cells[4].col - 1
    elseif self.position == 2 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row - 1, self.cells[4].col - 1
    elseif self.position == 3 then
        r1, c1 = self.cells[1].row - 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row - 1, self.cells[4].col + 1
    else
        r1, c1 = self.cells[1].row - 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row + 1, self.cells[4].col + 1
    end

    self:rotateShape(r1, c1, r2, c2, r3, c3, r4, c4)
end

return TShape
