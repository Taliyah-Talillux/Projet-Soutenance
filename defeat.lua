Defeat = {}
local myMap = require("Map")

function Defeat.load()
    -- Chargement image scene
end

function Defeat.update(dt)
end

function Defeat.draw()
    love.graphics.print("Game Over", myMap.screen_Width / 2 - 50, myMap.screen_Height / 2 - 100)
end

return Defeat
