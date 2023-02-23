-- Déclaration de la table d'animations
local Animations = {}

local myCollisions = require("Collisions")
local myMap = require("Map")

function addAnimations()
    -- Choix d'une tuile admissible
    repeat
        myCollisions.findEligibleTiles()
        local spawn = love.math.random(1, #myCollisions.eligible_tiles)
        Animations.x = myCollisions.eligible_tiles[spawn].x
        Animations.y = myCollisions.eligible_tiles[spawn].y
    until myCollisions.outOfScreenSpawn(Animations, myMap.screen_Width, myMap.screen_Height)
end

function Animations.load()
    -- Chargement de la texture
    local texture1 = love.graphics.newImage("Images/étoiles.png")
    local texture2 = love.graphics.newImage("Images/coeurs.png")

    -- Dimensions de la spritesheet et des tuiles
    Animations.starsSheetWidth, Animations.starsSheetHeight = texture1:getDimensions()
    Animations.heartSheetWidth, Animations.heartSheetHeight = texture2:getDimensions()
    Animations.width = 50
    Animations.height = 80
    -- Ajoute une animation
    addAnimations()
    -- Création des quads
    local rows = 1
    local cols = 8

    local frameDimensions = {
        {width = 46, height = 80},
        {width = 47, height = 80},
        {width = 54, height = 80},
        {width = 54, height = 80},
        {width = 57, height = 80},
        {width = 51, height = 80},
        {width = 45, height = 80},
        {width = 45, height = 80}
    }

    -- Création des quads
    local quads_stars = {}
    local x, y = 0, 0
    for i, dimensions in ipairs(frameDimensions) do
        quads_stars[i] =
            love.graphics.newQuad(
            x,
            y,
            dimensions.width,
            dimensions.height,
            Animations.starsSheetWidth,
            Animations.starsSheetHeight
        )
        x = x + dimensions.width
    end
    Animations.quads_stars = quads_stars

    -- rows = 1
    -- cols = 8

    --     Animations.quads_hearts = {}
    --     for row = 0, rows - 1 do
    --         for col = 0, cols - 1 do
    --             Animations.quads_hearts[#Animations.quads_hearts + 1] =
    --                 love.graphics.newQuad(
    --                 col * Animations.TILE_WIDTH,
    --                 row * Animations.TILE_HEIGHT,
    --                 Animations.TILE_WIDTH,
    --                 Animations.TILE_HEIGHT,
    --                 Animations.heartSheetWidth,
    --                 Animations.heartSheetHeight
    --             )
    --         end
    --    end

    -- Initialisation des variables d'animation
    Animations.frame = 1
    Animations.timer = 0
end

function Animations.update(dt)
    -- Mise à jour du timer
    Animations.timer = Animations.timer + 0.01

    -- Changement de frame
    if Animations.timer > 0.03 then
        Animations.frame = Animations.frame + 1
        if Animations.frame > #Animations.quads_stars then
            Animations.frame = 1
        end
        Animations.timer = 0
    end
end

function Animations.draw()
    -- Dessin de l'animation
    love.graphics.draw(
        love.graphics.newImage("Images/étoiles.png"),
        Animations.quads_stars[Animations.frame],
        Animations.x,
        Animations.y,
        0,
        1,
        1,
        Animations.width / 2,
        Animations.height / 2
    )

    -- love.graphics.draw(
    --     love.graphics.newImage("Images/coeurs.png"),
    --     Animations.quads_hearts[Animations.frame],
    --     Animations.x + Animations.TILE_WIDTH,
    --     Animations.y,
    --     0,
    --     1,
    --     1,
    --     Animations.TILE_WIDTH / 2,
    --     Animations.TILE_HEIGHT / 2
    -- )
end

return Animations
