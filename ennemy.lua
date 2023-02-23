local Ennemy = {}
local myMap = require("Map")
local myCollisions = require("Collisions")
local myUtils = require("Utils")

function Ennemy.spawn_Ennemy(Px, Py)
    local myEnnemy = {}
    myEnnemy.x = Px
    myEnnemy.y = Py
    myEnnemy.angle = 0
    myEnnemy.wantedAngle = 0
    myEnnemy.vx = 20
    myEnnemy.vy = 20
    myEnnemy.speedOrientation = 3
    myEnnemy.rotateTimer = 0
    myEnnemy.ray = 250
    myEnnemy.shotRange = 100
    myEnnemy.life = 5
    myEnnemy.damages = 1
    myEnnemy.img = love.graphics.newImage("Images/Hulls_Color_B/Hull_01.png")
    myEnnemy.width = myEnnemy.img:getWidth()
    myEnnemy.height = myEnnemy.img:getHeight()
    --Cannon
    myEnnemy.imgCanon = love.graphics.newImage("Images/Weapon_Color_B/Gun_03.png")
    myEnnemy.cannonAngle = 0
    myEnnemy.cannonWidth = myEnnemy.imgCanon:getWidth()
    myEnnemy.cannonHeight = myEnnemy.imgCanon:getHeight()
    myEnnemy.state = "IDLE"
    myEnnemy.isVisible = true
    myEnnemy.cannonLength = 34
    myEnnemy.cannonOriginX = 8.5
    myEnnemy.cannonOriginY = 34

    return myEnnemy
end

Ennemy.State = {}
Ennemy.State.IDLE = "IDLE"
Ennemy.State.ROTATE = "ROTATE"
Ennemy.State.PATROL = "PATROL"
Ennemy.State.ATTACK = "ATTACK"

function Ennemy.ChangeDirection()
    local direction = love.math.random()
    Ennemy.myEnnemy.wantedAngle = math.rad(direction * 360)
end

function Ennemy.addEnnemy()
    myCollisions.findEligibleTiles()
    local spawn = love.math.random(1, #myCollisions.eligible_tiles)
    local x = myCollisions.eligible_tiles[spawn].x
    local y = myCollisions.eligible_tiles[spawn].y
    Ennemy.myEnnemy = Ennemy.spawn_Ennemy(x, y)
end

function Ennemy.load()
    Ennemy.addEnnemy()
end

function Ennemy.update(dt)
end

function Ennemy.draw()
    if Ennemy.myEnnemy.isVisible == true then
        --Affichage du tank
        love.graphics.draw(
            Ennemy.myEnnemy.img,
            Ennemy.myEnnemy.x,
            Ennemy.myEnnemy.y,
            Ennemy.myEnnemy.angle + math.rad(90),
            1,
            1,
            Ennemy.myEnnemy.width / 2,
            Ennemy.myEnnemy.height / 2
        )
        -- Affichage du canon
        local cannonPos = myUtils.getCannonPosition(Ennemy.myEnnemy)
        love.graphics.draw(
            Ennemy.myEnnemy.imgCanon,
            cannonPos.x,
            cannonPos.y,
            Ennemy.myEnnemy.cannonAngle + math.rad(90),
            1,
            1,
            Ennemy.myEnnemy.cannonOriginX,
            Ennemy.myEnnemy.cannonOriginY
        )
        love.graphics.circle("line", Ennemy.myEnnemy.x, Ennemy.myEnnemy.y, Ennemy.myEnnemy.ray)
    end
end

return Ennemy
