local Player = {}
local myMap = require("Map")
local myCollisions = require("Collisions")

function Player.spawn_Player(Px, Py)
    local myPlayer = {}
    myPlayer.x = Px
    myPlayer.y = Py
    myPlayer.angle = 0
    myPlayer.speedOrientation = 3
    myPlayer.vx = 50
    myPlayer.vy = 50
    myPlayer.life = 5
    myPlayer.damages = 1
    myPlayer.img = love.graphics.newImage("Images/Hulls_Color_C/Hull_01.png")
    myPlayer.width = myPlayer.img:getWidth()
    myPlayer.height = myPlayer.img:getHeight()
    --Cannon
    myPlayer.imgCanon = love.graphics.newImage("Images/Weapon_Color_C/Gun_03.png")
    myPlayer.cannonAngle = 0
    myPlayer.isVisible = true
    myPlayer.cannonWidth = myPlayer.imgCanon:getWidth()
    myPlayer.cannonHeight = myPlayer.imgCanon:getHeight()
    -- Largeur img 17, centrage du tank : 8.5, placement du cannon : 17/2 : 8.5
    -- Hauteur img 44 : moitié origine 22 Placement du cannon : 34, 34-22 = 12 pour placement du cannon au bout du tank
    -- Longueur = distance entre le bout du cannon et l'origine
    myPlayer.cannonLength = 34
    myPlayer.cannonOriginX = 8.5
    myPlayer.cannonOriginY = 34

    return myPlayer
end

function Player.addPlayer()
    myCollisions.findEligibleTiles()
    local spawn = love.math.random(1, #myCollisions.eligible_tiles)
    local x = myCollisions.eligible_tiles[spawn].x
    local y = myCollisions.eligible_tiles[spawn].y
    Player.myPlayer = Player.spawn_Player(x, y)
end

function Player.load()
    Player.addPlayer()
end

function Player.update(dt)
end

function Player.drawGranade(granade)
    love.graphics.draw(imageGranade, granade.x, granade.y)
end

function Player.draw()
    if Player.myPlayer.isVisible == true then
        -- Affichage du tank
        love.graphics.draw(
            Player.myPlayer.img,
            Player.myPlayer.x,
            Player.myPlayer.y,
            Player.myPlayer.angle + math.rad(90),
            1,
            1,
            Player.myPlayer.width / 2,
            Player.myPlayer.height / 2
        )
        -- Affichage du canon
        -- Pour centrage du cannon, on soustrait le cos/sinus de l'angle du player à x et y x un coeff, plus le coeff est elevé plus le cannon sera sur l'exterieur du tank et inversement
        local cannonPos = myCollisions.getCannonPosition(Player.myPlayer)
        love.graphics.draw(
            Player.myPlayer.imgCanon,
            cannonPos.x,
            cannonPos.y,
            Player.myPlayer.cannonAngle + math.rad(90),
            1,
            1,
            Player.myPlayer.cannonOriginX,
            Player.myPlayer.cannonOriginY
        )
    end
end

function Player.mousepressed(x, y, button)
end
return Player
