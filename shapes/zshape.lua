--=======================================
-- filename:    sshape.lua
-- author:      Shane Krolikowski
-- created:     Sept. 26, 2017
-- description: Z shape.
--=======================================

local Cell = require 'cell'

local ZShape = Class{
    __includes = require 'shapes.shape'
}

local color = { 0.33, 0.1, 0.55, 0.75 } -- purple

function ZShape:init(grid, row, col)
    self.grid = grid
    self.row = row
    self.col = col
    self.position = 1
    self.isMobile = true

    self.cells = {
        Cell(grid, row - 1, col - 1, color, self.isMobile),
        Cell(grid, row - 1, col + 0, color, self.isMobile),
        Cell(grid, row + 0, col + 0, color, self.isMobile),
        Cell(grid, row + 0, col + 1, color, self.isMobile)
    }
end

--=======================================
-- Rotate this shape.
-- --------------------
-- @return void
--=======================================
function ZShape:rotate()
    local r1, c1, r2, c2, r3, c3, r4, c4

    if self.position == 1 then
        r1, c1 = self.cells[1].row - 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row + 0, self.cells[4].col - 2
    elseif self.position == 2 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col + 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row - 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row - 2, self.cells[4].col + 0
    elseif self.position == 3 then
        r1, c1 = self.cells[1].row + 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col + 1
        r4, c4 = self.cells[4].row + 0, self.cells[4].col + 2
    else
        r1, c1 = self.cells[1].row - 1, self.cells[1].col - 1
        r2, c2 = self.cells[2].row + 0, self.cells[2].col + 0
        r3, c3 = self.cells[3].row + 1, self.cells[3].col - 1
        r4, c4 = self.cells[4].row + 2, self.cells[4].col + 0
    end

    self:rotateShape(r1, c1, r2, c2, r3, c3, r4, c4)
end

return ZShape
