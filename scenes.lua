Scenes = {}

local myMenu = require("Menu")
local myGame = require("Game")
local WinScene = require("Win")
local DefeatScene = require("Defeat")
local myCollisions = require("Collisions")
local myMap = require("Map")
local myPlayer = require("Player")
local myEnnemy = require("Ennemy")
local myKeyboard = require("Keyboard")

function Scenes.load()
    -- Chargement des scènes
    if myGame.current_scene == "menu" then
        myMenu.load()
    elseif myGame.current_scene == "game" then
        myGame.load()
    elseif myGame.current_scene == "win" then
        WinScene.load()
    elseif myGame.current_scene == "defeat" then
        DefeatScene.load()
    end
end

function Scenes.update(dt)
    if myGame.current_scene == "menu" then
        myMenu.update(dt)
    elseif myGame.current_scene == "game" then
        myGame.update(dt)
    elseif myGame.current_scene == "win" then
        WinScene.update(dt)
    elseif myGame.current_scene == "defeat" then
        DefeatScene.update(dt)
    end
end

function Scenes.draw()
    if myGame.current_scene == "menu" then
        myMenu.draw()
    elseif myGame.current_scene == "game" then
        myMap.draw()
        myGame.draw()
        myPlayer.draw()
        myEnnemy.draw()
    elseif myGame.current_scene == "defeat" then
        DefeatScene.draw()
    elseif myGame.current_scene == "win" then
        WinScene.draw()
    end
end

function Scenes.mousepressed(x, y, button)
    local mouseX, mouseY = love.mouse.getPosition()
    if myGame.current_scene == "menu" then
        if button == 1 then
            if
                myCollisions.pointInBox(
                    mouseX,
                    mouseY,
                    myMenu.PlayButton.x,
                    myMenu.PlayButton.y,
                    myMenu.PlayButton.width,
                    myMenu.PlayButton.height
                )
             then
                myGame.current_scene = "game"
                myGame.load()
            end
            if
                myCollisions.pointInBox(
                    mouseX,
                    mouseY,
                    myMenu.QuitButton.x,
                    myMenu.QuitButton.y,
                    myMenu.QuitButton.width,
                    myMenu.QuitButton.height
                )
             then
                love.event.quit()
            end
        end
    end
    if myGame.current_scene == "game" then
        myGame.mousepressed(x, y, button)
    end
end

function Scenes.keypressed(key)
    myGame.keypressed(key)
end

function Scenes.keyreleased(key)
    myGame.keyreleased(key)
end

return Scenes
