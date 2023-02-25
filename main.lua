-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Debugger
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- On appel le nom du module
local myScenes = require("Scenes")
local myMap = require("Map")
local myPlayer = require("Player")
local myEnnemy = require("Ennemy")

function love.load()
    myScenes.load()
    myMap.load()
end

function love.update(dt)
    myScenes.update(dt)
end

function love.draw()
    myScenes.draw()
end

function love.mousepressed(x, y, button)
    myScenes.mousepressed(x, y, button)
end

function love.keypressed(key)
    myScenes.keypressed(key)
end

function love.keyreleased(key)
    myScenes.keyreleased(key)
end
