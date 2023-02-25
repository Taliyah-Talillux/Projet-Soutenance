local Keyboard = {}

local mySounds = require("Sounds")
local myPlayer = require("Player")

local keysPressed = {}
local soundPlaying = false

function Keyboard.isDown(key)
    return keysPressed[key] or false
end

function Keyboard.keypressed(key)
    keysPressed[key] = true
    if key == "up" or key == "right" or key == "left" then
        if not soundPlaying then
            love.audio.play(mySounds.src2)
            soundPlaying = true
        end
    end
end

function Keyboard.keyreleased(key)
    keysPressed[key] = false
    if key == "up" or key == "right" or key == "left" then
        if Keyboard.isDown("up") or Keyboard.isDown("right") or Keyboard.isDown("left") then
            -- Si une touche est enfoncée, le son est jouée
            love.audio.stop(mySounds.src2)
            love.audio.play(mySounds.src2)
        else
            -- Si aucune touche n'est enfoncée, on arrête de jouer le son
            love.audio.stop(mySounds.src2)
            soundPlaying = false
        end
    end
end

function Keyboard.update(dt)
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
end

return Keyboard
