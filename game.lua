local Game = {}
local myMenu = require("Menu")
local myWin = require("Win")
local myDefeat = require("Defeat")
local myMap = require("Map")
local myPlayer = require("Player")
local myEnnemy = require("Ennemy")
local myCollisions = require("Collisions")
local myShots = require("Shots")
local myUtils = require("Utils")
local myAnimations = require("Animations")

--- Scene en cours
Game.current_scene = "menu"
Game.score = 0

function Game.load()
    myPlayer.load()
    myEnnemy.load()
    myAnimations.load()
end

function Game.update(dt)
    -- Changement de l'angle des cannons
    myEnnemy.myEnnemy.cannonAngle = myEnnemy.myEnnemy.angle
    myPlayer.myPlayer.cannonAngle =
        math.angle(myPlayer.myPlayer.x, myPlayer.myPlayer.y, love.mouse.getX(), love.mouse.getY())

    myShots.update(dt)
    myAnimations.update(dt)
    -- UPDATE PLAYER
    -- Déplacements
    if love.keyboard.isDown("right") == true then
        myPlayer.myPlayer.angle = myPlayer.myPlayer.angle + myPlayer.myPlayer.speedOrientation * dt
    end
    if love.keyboard.isDown("left") == true then
        myPlayer.myPlayer.angle = myPlayer.myPlayer.angle - myPlayer.myPlayer.speedOrientation * dt
    end
    if love.keyboard.isDown("up") then
        myPlayer.myPlayer.x = myPlayer.myPlayer.x + math.cos(myPlayer.myPlayer.angle) * myPlayer.myPlayer.vx * dt
        myPlayer.myPlayer.y = myPlayer.myPlayer.y + math.sin(myPlayer.myPlayer.angle) * myPlayer.myPlayer.vy * dt
    end

    -- L'ennemi est-il touché ?
    for k = #myShots.granades, 1, -1 do
        local granade = myShots.granades[k]
        if
            granade.type == "player" and
                myUtils.checkCollision(
                    myUtils.getCollisionCenterBox(myEnnemy.myEnnemy),
                    myUtils.getCollisionCenterBox(granade)
                )
         then
            myEnnemy.myEnnemy.life = myEnnemy.myEnnemy.life - myPlayer.myPlayer.damages
            table.remove(myShots.granades, k)
            Game.score = Game.score + 10
            Game.current_scene = "win"
        end
    end

    -- UPDATE ENNEMI
    -- MACHINE A ETAT
    local distance = math.dist(myPlayer.myPlayer.x, myPlayer.myPlayer.y, myEnnemy.myEnnemy.x, myEnnemy.myEnnemy.y)
    if myEnnemy.myEnnemy.state == myEnnemy.State.IDLE then
        myEnnemy.ChangeDirection()
        myEnnemy.myEnnemy.state = myEnnemy.State.ROTATE
    elseif myEnnemy.myEnnemy.state == myEnnemy.State.ROTATE then
        -- change le sens de rotation en fonction de la différence entre les 2 angles
        local angleDiff = myEnnemy.myEnnemy.wantedAngle - myEnnemy.myEnnemy.angle
        local rotationSens = math.abs(angleDiff) / angleDiff -- 1 si angleDiff > 0, -1 si angleDiff < 0
        myEnnemy.myEnnemy.angle =
            myEnnemy.myEnnemy.angle +
            rotationSens * myEnnemy.myEnnemy.speedOrientation * dt * math.min(1, math.abs(angleDiff) / math.pi)
        if math.abs(angleDiff) <= 0.1 then
            myEnnemy.myEnnemy.state = myEnnemy.State.PATROL
        end
    elseif myEnnemy.myEnnemy.state == myEnnemy.State.PATROL then
        myEnnemy.myEnnemy.rotateTimer = myEnnemy.myEnnemy.rotateTimer + dt
        myEnnemy.myEnnemy.x = myEnnemy.myEnnemy.x + math.cos(myEnnemy.myEnnemy.angle) * myEnnemy.myEnnemy.vx * dt
        myEnnemy.myEnnemy.y = myEnnemy.myEnnemy.y + math.sin(myEnnemy.myEnnemy.angle) * myEnnemy.myEnnemy.vy * dt
        --- par la suite remplacer le rotateTimer par les collisions de tuiles solides
        if myEnnemy.myEnnemy.rotateTimer > 2 then
            myEnnemy.myEnnemy.state = myEnnemy.State.IDLE
            myEnnemy.myEnnemy.rotateTimer = 0
        end
        -- Si la distance entre le joueur et l'ennemi est inférieur au rayon alors il passe en mode attaque
        if distance < myEnnemy.myEnnemy.ray then
            myEnnemy.myEnnemy.state = myEnnemy.State.ATTACK
        end
    elseif myEnnemy.myEnnemy.state == myEnnemy.State.ATTACK then
        -- Calculer l'angle du cannon
        local cannonPos = myUtils.getCannonPosition(myEnnemy.myEnnemy)
        myEnnemy.myEnnemy.cannonAngle = math.angle(cannonPos.x, cannonPos.y, myPlayer.myPlayer.x, myPlayer.myPlayer.y)

        -- -- Calcule l'angle entre l'ennemi et le joueur
        local angleToPlayer =
            math.angle(
            myEnnemy.myEnnemy.cannonAngle,
            myEnnemy.myEnnemy.cannonAngle,
            myPlayer.myPlayer.x,
            myPlayer.myPlayer.y
        )

        -- Mettre à jour l'angle souhaité de l'ennemi
        myEnnemy.myEnnemy.wantedAngle = angleToPlayer

        -- Tourne l'ennemi vers le joueur
        local rotationSpeed = 3
        local angleDiff = angleToPlayer - myEnnemy.myEnnemy.angle
        local rotationSens = math.sign(angleDiff)

        if math.abs(angleDiff) > 5 then
            myEnnemy.myEnnemy.angle = angleToPlayer
        else
            myEnnemy.myEnnemy.angle = myEnnemy.myEnnemy.angle + rotationSpeed * rotationSens * dt
        end

        -- Ajout d'un tir à la fin du chrono
        myShots.chronometre_ennemy(dt)
        -- Le joueur est-il touché ?
        for n = #myShots.granades, 1, -1 do
            local granade = myShots.granades[n]
            if
                granade.type == "ennemy" and
                    myUtils.checkCollision(
                        myUtils.getCollisionCenterBox(myPlayer.myPlayer),
                        myUtils.getCollisionCenterBox(granade)
                    )
             then
                myPlayer.myPlayer.life = myPlayer.myPlayer.life - myEnnemy.myEnnemy.damages
                table.remove(myShots.granades, n)
                if myPlayer.myPlayer.life <= 0 then
                    Game.current_scene = "defeat"
                end
            elseif distance > myEnnemy.myEnnemy.ray then
                myEnnemy.myEnnemy.state = myEnnemy.State.IDLE
            end
        end
    end

    -- Empeche le joueur et l'ennemi de sortir de l'écran
    myCollisions.outOfScreen(myPlayer.myPlayer, myMap.screen_Width, myMap.screen_Height)
    myCollisions.outOfScreen(myEnnemy.myEnnemy, myMap.screen_Width, myMap.screen_Height)
    -- faire changer de direction si collisions bord écran, idem pour tuiles solides
end

function Game.draw()
    local r, g, b = 100, 0, 250

    myPlayer.draw()
    myEnnemy.draw()
    myShots.draw()
    myAnimations.draw()
    love.graphics.print("Vies joueur : " .. myPlayer.myPlayer.life, 100, myMap.screen_Height - 20)
    love.graphics.print("Vies ennemi : " .. myEnnemy.myEnnemy.life, myMap.screen_Width - 100, myMap.screen_Height - 20)
    -- love.graphics.print("Chrono : " .. myShots.timer, myMap.screen_Width / 2, myMap.screen_Height - 20)
    love.graphics.setColor(r, g, b)
    love.graphics.print("score : " .. Game.score, 0, myMap.screen_Height - 20)
    love.graphics.setColor(1, 1, 1)
end

function Game.mousepressed(x, y, button, dt)
    --Tir du joueur
    if button == 1 then
        myShots.chronometre_player()
    end
end
return Game
