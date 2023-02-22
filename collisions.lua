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
Collisions.eligible_tiles = {}
function Collisions.findEligibleTiles()
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

function Collisions.load()
end

function Collisions.update(dt)
end

function Collisions.draw()
end

return Collisions
