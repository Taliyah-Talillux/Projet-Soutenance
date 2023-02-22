Shots = {}
local myMap = require("Map")
local myPlayer = require("Player")
local myEnnemy = require("Ennemy")
local myUtils = require("Utils")

Shots.granades = {}
Shots.Timer = 0

function Shots.addShot(shooter, target, type)
    local granade = {}
    local halfWidth = shooter.width / 2
    local halfHeight = shooter.height / 2
    granade.x = shooter.cannon.x + shooter.cannonWidth / 2 - halfWidth
    granade.y = shooter.cannon.y + shooter.cannonHeight / 2 - halfHeight
    granade.type = type
    granade.vx = 100
    granade.vy = 100
    granade.orientation = shooter.cannonAngle
    granade.angle = math.angle(shooter.x, shooter.y, target.x, target.y)
    granade.img = love.graphics.newImage("Images/Effects/Heavy_Shell.png")
    granade.width = granade.img:getWidth()
    granade.height = granade.img:getHeight()
    table.insert(Shots.granades, granade)
    return granade
end

function Shots.chronometre_ennemy(dt)
    while Shots.Timer >= 2 do
        Shots.Timer = Shots.Timer + dt
        Shots.addShot(myEnnemy.myEnnemy, myPlayer.myPlayer, "ennemy")
        Shots.Timer = 0
    end
end

function Shots.chronometre_player()
    while Shots.Timer >= 1 do
        Shots.Timer = Shots.Timer + os.clock()
        Shots.addShot(myPlayer.myPlayer, {x = love.mouse.getX(), y = love.mouse.getY()}, "player")
        Shots.Timer = 0
    end
end

function Shots.update(dt)
    -- Mise à jout du timer de tir
    Shots.Timer = Shots.Timer + dt
    for n = #Shots.granades, 1, -1 do
        local granade = Shots.granades[n]
        granade.x = granade.x + math.cos(granade.angle) * 50 * dt
        granade.y = granade.y + math.sin(granade.angle) * 50 * dt
        if not myUtils.checkCollision(myUtils.getCollisionCenterBox(myMap), myUtils.getCollisionCenterBox(granade)) then
            table.remove(Shots.granades, n)
        end
    end
end

function Shots.draw()
    for _, granade in ipairs(Shots.granades) do
        love.graphics.draw(
            granade.img,
            granade.x,
            granade.y,
            granade.orientation,
            1,
            1,
            granade.width / 2,
            granade.height / 2
        )
    end
end

return Shots
