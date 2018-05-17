--=======================================
-- filename:    squareshape.lua
-- author:      Shane Krolikowski
-- created:     Sept. 25, 2017
-- description: Square shape.
--=======================================

local Cell = require 'cell'

local SquareShape = Class{
    __includes = require 'shapes.shape'
}

local color = {1, 0.38, 0.001, 0.75} -- orange

function SquareShape:init(grid, row, col)
    self.grid = grid
    self.row = row
    self.col = col
    self.position = 1
    self.isMobile = true

    self.cells = {
        Cell(grid, row - 1, col + 0, color, true),
        Cell(grid, row - 1, col + 1, color, true),
        Cell(grid, row + 0, col + 0, color, true),
        Cell(grid, row + 0, col + 1, color, true)
    }
end

--=======================================
-- Rotate this shape.
-- --------------------
-- @return void
--=======================================
function SquareShape:rotate()
    -- this shape doesn't rotate
end

return SquareShape
