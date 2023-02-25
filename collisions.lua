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
                local x = (i - 1) * myMap.TILE_WIDTH
                local y = (j - 1) * myMap.TILE_HEIGHT
                table.insert(
                    Collisions.eligible_tiles,
                    {
                        x = x + (myMap.TILE_WIDTH / 2),
                        y = y + (myMap.TILE_HEIGHT / 2)
                    }
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

function Collisions.getCannonPosition(objet)
    return {
        x = objet.x - math.cos(objet.angle) * 3,
        y = objet.y - math.sin(objet.angle) * 3
    }
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

-- Check collision bewteen a point and a rectangle
function Collisions.pointInBox(pX, pY, x, y, rW, rH)
    if math.abs(pX - x) > rW then
        return false
    end
    if math.abs(pY - y) > rH then
        return false
    end
    return true
end

--Check collision between two points
function Collisions.checkCollision(obj1, obj2)
    local x1, y1 = obj1.x, obj1.y
    local w1, h1 = obj1.width, obj1.height
    local x2, y2 = obj2.x, obj2.y
    local w2, h2 = obj2.width, obj2.height
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

--- Collision box object
function Collisions.getCollisionCenterBox(obj)
    return {
        x = obj.x - obj.width / 2,
        y = obj.y - obj.height / 2,
        width = obj.width,
        height = obj.height
    }
end

function Collisions.load()
end

function Collisions.update(dt)
end

function Collisions.draw()
end

return Collisions
