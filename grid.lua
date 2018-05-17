--=======================================
-- filename:    grid.lua
-- author:      Shane Krolikowski
-- created:     Sept. 25, 2017
-- description: Game grid; holds every possible shape
--  and creates bounds of game.
--=======================================

local Grid = Class{}

local Cell = require 'cell'

function Grid:init(rows, cols)
    self.rows = rows
    self.cols = cols
end

function Grid:draw()
    for row, rowV in pairs(self.board) do
        for col, colV in pairs(self.board[row]) do
            self.board[row][col]:draw()
        end
    end
end

--=======================================
-- Create game board, which consists of
--  a grid of cells.
-- --------------------
-- @return void
--=======================================
function Grid:createBoard()
    self.board = {}

    for row = 1, self.rows do
        self.board[row] = {}

        for col = 1, self.cols do
            self.board[row][col] = Cell(self, row, col, nil, false)
        end
    end
end

--=======================================
-- Check if a cell is currently
--  occupied at the given coordinates.
-- --------------------
-- @param row
-- @param col
-- --------------------
-- @return boolean
--=======================================
function Grid:isCellOccupied(row, col)
    if self:isValidCell(row, col) then
        return self.board[row][col]:isOccupied()
    end

    return false
end

--=======================================
-- Change the color of a cell on the
--  grid at the given coordinates.
-- --------------------
-- @param row
-- @param col
-- @param color
-- --------------------
-- @return void
--=======================================
function Grid:setCell(row, col, color)
    if self:isValidCell(row, col) then
        self.board[row][col]:setColor(color)
    end
end

--=======================================
-- Check if the given coordinates fall
--  within the grid.
-- --------------------
-- @param row
-- @param col
-- --------------------
-- @return boolean
--=======================================
function Grid:isValidCell(row, col)
    return row > 0 and row <= self.rows and col > 0 and col <= self.cols
end

--=======================================
-- Check if any rows are completely
--  occupied and return count.
-- --------------------
-- @return integer - Number of fully occupied rows
--=======================================
function Grid:checkForCompleteRows()
    local completeRows = 0

    for row, rowV in pairs(self.board) do
        local occupiedCells = 0

        for col, colV in pairs(self.board[row]) do
            if self.board[row][col]:isOccupied() then
                occupiedCells = occupiedCells + 1
            end
        end

        if occupiedCells == self.cols then
            completeRows = completeRows + 1
            self:emptyRow(row)
        end
    end

    return completeRows
end

--=======================================
-- Emtpy row specified and shift all
--  rows above down one.
-- --------------------
-- @return void
--=======================================
function Grid:emptyRow(rowToEmpty)
    for row = rowToEmpty, 2, -1 do
        for col = 1, self.cols do
            self:setCell(row, col, self.board[row - 1][col]:getColor())
        end
    end

    -- Set top row to empty
    for col = 1, self.cols do
        self:setCell(1, col, nil)
    end
end

--=======================================
-- Clear grid to start fresh.
-- --------------------
-- @return void
--=======================================
function Grid:clear()
    self:createBoard()
end

function Grid:getRows()
    return self.rows
end

function Grid:getCols()
    return self.cols
end

return Grid
