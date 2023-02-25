local BonusEffect = {}

local myAnimations = require("Animations")
local myPlayer = require("Player")
local myCollisions = require("Collisions")

function BonusEffect.update(dt)
    -- Vérification de la collision entre les deux objets
    if myCollisions.collideBetweenTwoObjects(myPlayer.myPlayer, myAnimations.stars) then
        --  print("Les deux objets se touchent !")
    else
        --    print("Les deux objets ne se touchent pas.")
    end
end

return BonusEffect
