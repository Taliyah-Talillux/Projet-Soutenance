local BonusEffect = {}

local myAnimations = require("Animations")
local myPlayer = require("Player")
local myCollisions = require("Collisions")

function BonusEffect.update(dt)
    -- Vérification de la collision entre les deux objets
    if myCollisions.checkCollision(myPlayer.myPlayer, myAnimations.stars) then
    else
        --   print("Les deux objets ne se touchent pas.")
    end
end

return BonusEffect
