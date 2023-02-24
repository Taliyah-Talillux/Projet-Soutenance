local mySounds = require("Sounds")

local Keyboard = {}

local keysPressed = {}

function Keyboard.isDown(key)
    return keysPressed[key] or false
end

function Keyboard.keypressed(key)
    keysPressed[key] = true
    if key == "up" or key == "right" or key == "left" then
        love.audio.play(mySounds.src2)
    end
end

function Keyboard.keyreleased(key)
    keysPressed[key] = false
    if key == "up" or key == "right" or key == "left" then
        love.audio.stop(mySounds.src2)
    end
end

function Keyboard.update(dt)
    if Keyboard.isDown("right") then
        myPlayer.myPlayer.angle = myPlayer.myPlayer.angle + myPlayer.myPlayer.speedOrientation * dt
    elseif Keyboard.isDown("left") then
        myPlayer.myPlayer.angle = myPlayer.myPlayer.angle - myPlayer.myPlayer.speedOrientation * dt
    elseif Keyboard.isDown("up") then
        myPlayer.myPlayer.x = myPlayer.myPlayer.x + math.cos(myPlayer.myPlayer.angle) * myPlayer.myPlayer.vx * dt
        myPlayer.myPlayer.y = myPlayer.myPlayer.y + math.sin(myPlayer.myPlayer.angle) * myPlayer.myPlayer.vy * dt
    end
end

-- importer les fonction dans le game et le main et tout autre module necessaire
function love.keypressed(key)
    Keyboard.keypressed(key)
end

function love.keyreleased(key)
    Keyboard.keyreleased(key)
end

return Keyboard
