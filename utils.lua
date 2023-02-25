local Utils = {}

-- Return distance between two points
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end
-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

-- Returns 1 if number is positive, -1 if it's negative, or 0 if it's 0.
function math.sign(n)
    return n > 0 and 1 or n < 0 and -1 or 0
end

return Utils
