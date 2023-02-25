-- Déclaration de la table d'animations
local Animations = {}

local myCollisions = require("Collisions")
local myMap = require("Map")

Animations.stars = {}
Animations.hearts = {}

local texture1, texture2

function Animations.addAnimations()
    -- Choix d'une tuile admissible
    repeat
        myCollisions.findEligibleTiles()
        local spawnStars = love.math.random(1, #myCollisions.eligible_tiles)
        local spawnHearts = love.math.random(1, #myCollisions.eligible_tiles)
        Animations.stars.x = myCollisions.eligible_tiles[spawnStars].x
        Animations.stars.y = myCollisions.eligible_tiles[spawnStars].y
        Animations.hearts.x = myCollisions.eligible_tiles[spawnHearts].x
        Animations.hearts.y = myCollisions.eligible_tiles[spawnHearts].y
    until myCollisions.outOfScreenSpawn(Animations.stars, myMap.screen_Width, myMap.screen_Height)
    repeat
    until myCollisions.outOfScreenSpawn(Animations.hearts, myMap.screen_Width, myMap.screen_Height)
end

function bonusAppears(timer)
    timer = timer + dt
    if timer >= 3 then
        myAnimations.addAnimationsStars()
    elseif timer >= 4 then
        myAnimations.addAnimationsHearts()
    end
end
function Animations.load()
    -- Chargement de la texture
    texture1 = love.graphics.newImage("Images/Bonus/étoiles.png")
    texture2 = love.graphics.newImage("Images/Bonus/coeurs.png")

    -- Dimensions des spritesheet et des tuiles
    Animations.starsSheetWidth, Animations.starsSheetHeight = texture1:getDimensions()
    Animations.heartsSheetWidth, Animations.heartsSheetHeight = texture2:getDimensions()
    Animations.stars.width = 50
    Animations.stars.height = 80
    local cols_heart = 18
    local rows_heart = 1
    Animations.hearts.width = Animations.heartsSheetWidth / cols_heart
    Animations.hearts.height = Animations.heartsSheetHeight / rows_heart

    -- Ajoute une animation
    Animations.addAnimations()

    local frameDimensionsStars = {
        {width = 46, height = 80},
        {width = 47, height = 80},
        {width = 54, height = 80},
        {width = 54, height = 80},
        {width = 57, height = 80},
        {width = 51, height = 80},
        {width = 45, height = 80},
        {width = 45, height = 80}
    }

    local frameDimensionsHearts = {
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100},
        {width = 80, height = 100}
    }

    -- Création des quads
    local quads_stars = {}
    local stars_x, stars_y = 0, 0
    for i, dimensions in ipairs(frameDimensionsStars) do
        quads_stars[i] =
            love.graphics.newQuad(
            stars_x,
            stars_y,
            dimensions.width,
            dimensions.height,
            Animations.starsSheetWidth,
            Animations.starsSheetHeight
        )
        stars_x = stars_x + dimensions.width
    end
    Animations.quads_stars = quads_stars

    -- Création des quads
    local quads_hearts = {}
    local x, y = 0, 0
    for i = 1, rows_heart do
        for j = 1, cols_heart do
            quads_hearts[#quads_hearts + 1] =
                love.graphics.newQuad(
                x,
                y,
                Animations.hearts.width,
                Animations.hearts.height,
                Animations.heartsSheetWidth,
                Animations.heartsSheetHeight
            )
            x = x + Animations.hearts.width
        end
        Animations.quads_hearts = quads_hearts
    end

    -- Initialisation des variables d'animation
    Animations.frame_stars = 1
    Animations.timer_stars = 0
    Animations.duration_stars = 0.1
    Animations.frame_hearts = 1
    Animations.timer_hearts = 0
    Animations.duration_hearts = 0.03

    print(frameDimensionsStars[Animations.frame_stars].width)
end

function Animations.update(dt)
    -- Changement de frame
    Animations.timer_stars = Animations.timer_stars + dt
    Animations.timer_hearts = Animations.timer_hearts + dt

    if Animations.timer_stars > Animations.duration_stars then
        Animations.frame_stars = Animations.frame_stars + 1
        if Animations.frame_stars > #Animations.quads_stars then
            Animations.frame_stars = 1
        end
        Animations.timer_stars = 0
    end

    if Animations.timer_hearts > Animations.duration_hearts then
        Animations.frame_hearts = Animations.frame_hearts + 1
        if Animations.frame_hearts > #Animations.quads_hearts then
            Animations.frame_hearts = 1
        end
        Animations.timer_hearts = 0
    end
end

function Animations.draw()
    -- Dessin des quads
    love.graphics.draw(
        texture1,
        Animations.quads_stars[Animations.frame_stars],
        Animations.stars.x,
        Animations.stars.y,
        0,
        1,
        1,
        Animations.stars.width / 2,
        Animations.stars.height / 2
    )

    love.graphics.draw(
        texture2,
        Animations.quads_hearts[Animations.frame_hearts],
        Animations.hearts.x,
        Animations.hearts.y,
        0,
        1,
        1,
        Animations.hearts.width / 2,
        Animations.hearts.height / 2
    )
end

return Animations
