local Sounds = {}
Sounds.src1 = love.audio.newSource("Sons/Explosion.wav", "static")
Sounds.src2 = love.audio.newSource("Sons/Enmarche.mp3", "static")

Sounds.src1:setVolume(0.2)
Sounds.src2:setVolume(0.2)

Sounds.src1:setLooping(false)

return Sounds
