local Collisions = {}
local myMap = require("Map")

-- Tableau des tuiles solides
Collisions.Solides_tiles = {
    0,
    1,
    2,
    3,
    4,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13
}

-- Verfier si la tuille est solide
function Collisions.isSolid(tile)
    for i, id in ipairs(Collisions.Solides_tiles) do
        if tile == id then
            return true
        end
    end
    return false
end

-- Verfiier si les tuiles sont éligibles
function Collisions.findEligibleTiles()
    Collisions.eligible_tiles = {}
    for j, line in ipairs(myMap.Grill) do
        for i, tile in ipairs(line) do
            if not Collisions.isSolid(tile) then
                table.insert(
                    Collisions.eligible_tiles,
                    {x = (i - 1 / 2) * myMap.TILE_WIDTH, y = (j - 1 / 2) * myMap.TILE_HEIGHT}
                )
            end
        end
    end
end

function Collisions.outOfScreen(obj, screen_Width, screen_Height)
    local halfWidth = obj.width / 2
    local halfHeight = obj.height / 2

    if obj.x - halfWidth < 0 then
        obj.x = halfWidth
    end
    if obj.x + halfWidth > screen_Width then
        obj.x = screen_Width - halfWidth
    end
    if obj.y - halfHeight < 0 then
        obj.y = halfHeight
    end
    if obj.y + halfHeight > screen_Height - 20 then
        obj.y = (screen_Height - 20) - halfHeight
    end
end

function Collisions.outOfScreenSpawn(objet, screen_Width, screen_Height)
    local halfWidth = objet.width / 2
    local halfHeight = objet.height / 2
    if
        objet.x - halfWidth < 0 or objet.x + halfWidth > screen_Width or objet.y - halfHeight < 0 or
            objet.y + halfHeight > screen_Height - 20
     then
        -- L'objet est en dehors des limites de l'écran, on doit le repositionner sur une tuile éligible
        Collisions.findEligibleTiles()
        local spawn = love.math.random(1, #Collisions.eligible_tiles)
        objet.x = Collisions.eligible_tiles[spawn].x
        objet.y = Collisions.eligible_tiles[spawn].y
    end

    return objet.x >= halfWidth and objet.x <= screen_Width - halfWidth and objet.y >= halfHeight and
        objet.y <= screen_Height - halfHeight - 20
end

function Collisions.load()
end

function Collisions.update(dt)
end

function Collisions.draw()
end

return Collisions
