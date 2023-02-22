local Utils = {}

-- Return distance between two points
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end
-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end
--- Collision box object
function Utils.getCollisionCenterBox(obj)
    return {
        x = obj.x - obj.width / 2,
        y = obj.y - obj.height / 2,
        width = obj.width,
        height = obj.height
    }
end

--Check collision between two points
function Utils.checkCollision(obj1, obj2)
    local x1, y1 = obj1.x, obj1.y
    local w1, h1 = obj1.width, obj1.height
    local x2, y2 = obj2.x, obj2.y
    local w2, h2 = obj2.width, obj2.height
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
-- Check collision bewteen a point and a rectangle
function Utils.pointInBox(pX, pY, x, y, rW, rH)
    if math.abs(pX - x) > rW then
        return false
    end
    if math.abs(pY - y) > rH then
        return false
    end
    return true
end

-- Returns 1 if number is positive, -1 if it's negative, or 0 if it's 0.
function math.sign(n)
    return n > 0 and 1 or n < 0 and -1 or 0
end

function Utils.getCannonPosition(objet)
    return {
        x = objet.x - math.cos(objet.angle) * 3,
        y = objet.y - math.sin(objet.angle) * 3
    }
end

return Utils
