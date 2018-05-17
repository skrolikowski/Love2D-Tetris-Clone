--=======================================
-- name:        Tetris
-- filename:    main.lua
-- author:      Shane Krolikowski
-- created:     Sept. 24, 2017
-- description: bootstraper
--=======================================

-- Load libraries
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

-- Load gamestates
Game = require 'gamestates.game'
Pause = require 'gamestates.pause'

-- Constants
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Game)
end
