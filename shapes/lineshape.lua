--=======================================
-- filename:    lineshape.lua
-- author:      Shane Krolikowski
-- created:     Sept. 25, 2017
-- description: Line shape.
--=======================================

local Cell = require 'cell'

local LineShape = Class{
    __includes = require 'shapes.shape'
}

local color = {1, 0.73, 0.06, 0.75} -- yellow

function LineShape:init(grid, row, col)
    self.grid = grid
    self.row = row
    self.col = col
    self.position = 1
    self.isMobile = true

    self.cells = {
        Cell(grid, row - 1, col + 0, color, true),
        Cell(grid, row + 0, col + 0, color, true),
        Cell(grid, row + 1, col + 0, color, true),
        Cell(grid, row + 2, col + 0, color, true)
    }
end

--=======================================
-- Rotate this shape.
-- --------------------
-- @return void
--=======================================
function LineShape:rotate()
    local r1, c1, r2, c2, r3, c3, r4, c4

    if self.position == 1 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row - 2, self.cells[4].col - 2
    elseif self.position == 2 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row - 2, self.cells[4].col + 2
    elseif self.position == 3 then
        r1, c1 = self.cells[1].row - 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row + 2, self.cells[4].col + 2
    else
        r1, c1 = self.cells[1].row - 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row + 2, self.cells[4].col - 2
    end

    self:rotateShape(r1, c1, r2, c2, r3, c3, r4, c4)
end

return LineShape
