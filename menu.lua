Menu = {}
local myMap = require("Map")

Menu.PlayButton = {}
Menu.PlayButton.x = myMap.screen_Width / 2
Menu.PlayButton.y = myMap.screen_Height / 2 - 100
Menu.PlayButton.img = love.graphics.newImage("Images/Boutons/PlayButton.png")
Menu.PlayButton.width = Menu.PlayButton.img:getWidth()
Menu.PlayButton.height = Menu.PlayButton.img:getHeight()

Menu.QuitButton = {}
Menu.QuitButton.x = myMap.screen_Width / 2
Menu.QuitButton.y = myMap.screen_Height / 2 + 100
Menu.QuitButton.img = love.graphics.newImage("Images/Boutons/QuitButton.png")
Menu.QuitButton.width = Menu.QuitButton.img:getWidth()
Menu.QuitButton.height = Menu.QuitButton.img:getHeight()

function Menu.load()
end

function Menu.update(dt)
end

function Menu.draw()
    -- Afficher image Menu à la place des rectangles
    love.graphics.draw(
        Menu.PlayButton.img,
        Menu.PlayButton.x,
        Menu.PlayButton.y,
        0,
        1,
        1,
        Menu.PlayButton.width / 2,
        Menu.PlayButton.height / 2
    )
    love.graphics.draw(
        Menu.QuitButton.img,
        Menu.QuitButton.x,
        Menu.QuitButton.y,
        0,
        1,
        1,
        Menu.QuitButton.width / 2,
        Menu.QuitButton.height / 2
    )
    local mX, mY = love.mouse.getX(), love.mouse.getY()
end

return Menu
