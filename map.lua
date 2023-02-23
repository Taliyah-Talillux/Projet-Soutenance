local Map = {}

-- Taille de la fenêtre de jeu
Map.screen_Width = love.graphics:getWidth()
Map.screen_Height = love.graphics:getHeight()
--- Taille map et tuiles
Map.MAP_WIDTH = 25
Map.MAP_HEIGHT = 18
Map.TILE_WIDTH = 64
Map.TILE_HEIGHT = 64

Map.TileSheet = nil
Map.TileTextures = {}

Map.Grill = {
    {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14},
    {12, 13, 13, 13, 11, 15, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 11, 15, 12, 13, 13, 13, 13, 11},
    {10, 8, 8, 8, 9, 15, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 15, 10, 8, 8, 8, 8, 9},
    {3, 3, 3, 3, 3, 15, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 15, 3, 3, 3, 3, 3, 3},
    {1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 1},
    {14, 14, 14, 14, 14, 15, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 14, 14, 14, 14, 14, 14},
    {12, 13, 13, 13, 11, 15, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 11, 15, 12, 13, 13, 13, 13, 11},
    {10, 8, 8, 8, 9, 15, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 15, 10, 8, 8, 8, 8, 9},
    {14, 14, 14, 14, 14, 5, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 5, 14, 14, 14, 14, 14, 14},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

function Map.load()
    Map.TileSheet = love.graphics.newImage("Images/TileSheet.png")

    local NbColumns = Map.TileSheet:getWidth() / Map.TILE_WIDTH
    local NbLines = Map.TileSheet:getHeight() / Map.TILE_HEIGHT
    local id = 1
    for l = 1, NbLines do
        for c = 1, NbColumns do
            Map.TileTextures[id] =
                love.graphics.newQuad(
                (c - 1) * Map.TILE_WIDTH,
                (l - 1) * Map.TILE_HEIGHT,
                Map.TILE_WIDTH,
                Map.TILE_HEIGHT,
                Map.TileSheet:getWidth(),
                Map.TileSheet:getHeight()
            )
            id = id + 1
        end
    end
end

function Map.update(dt)
end

function Map.draw()
    ---Affichage tilemap
    for l = 1, Map.MAP_HEIGHT do
        for c = 1, Map.MAP_WIDTH do
            local id = Map.Grill[l][c]
            local texQuad = Map.TileTextures[id]
            if texQuad ~= nil then
                love.graphics.draw(Map.TileSheet, texQuad, (c - 1) * Map.TILE_WIDTH, (l - 1) * Map.TILE_HEIGHT)
            end
        end
    end
    -- Récupération de l'id sous la souris
    local mX, mY = love.mouse.getX(), love.mouse.getY()
    local col = math.floor(mX / Map.TILE_WIDTH) + 1
    local lin = math.floor(mY / Map.TILE_HEIGHT) + 1
    if col > 0 and col <= Map.MAP_WIDTH and lin > 0 and lin < Map.MAP_HEIGHT then
        local id = Map.Grill[lin][col]
        love.graphics.print("ID : " .. tostring(id))
    end
end

return Map
