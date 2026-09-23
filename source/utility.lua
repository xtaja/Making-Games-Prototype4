-- (0,1 - 179,180,181 - 359,0,1) -> (0,1 - 179,180,179 - 1,0,1)
function CrankYVal(crankVal)
    if (crankVal <= 180) then
        return crankVal
    end
    return 360 - crankVal
end

-- Defining helper function
function Ring(value, min, max)
	if (min > max) then
		min, max = max, min
	end
	return min + (value - min) % (max - min)
end

function Clamp(value, min, max)
    if (value < min) then
        return min
    end
    if (max < value) then
        return max
    end
    return value
end

function Sign(value)
    if (value == 0) then
        return 0
    end
    if (value < 0) then
        return -1
    end
    return 1
end

function DegToRad(deg)
    return deg * math.pi / 180
end

function RadToDeg(rad)
    return rad * 180 / math.pi
end

function CalcDist(distX, distY)
    return math.sqrt(distX * distX + distY * distY)
end

function RandomType()
    local type = math.random(0,1)
    if (type == 0) then
        return -1
    end
    return 1
end
