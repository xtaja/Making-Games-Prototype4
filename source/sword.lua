import "sprites"
import "utility"

local pd <const> = playdate

-- ...
local playerPosX = 200
local playerPosY = 120

-- Settings
local offsetLength = 40
local maxSwordDegSpeed = 50

-- Variables
local swordDeg = 0
local swordPosX = 0
local swordPosY = 0

-- Sprite
local swordImage = SetSwordImage(0)

local function moveTowardsCursor(cursorDeg)
    local degDelta = cursorDeg - swordDeg

    if (180 < math.abs(degDelta)) then
        degDelta = (360 - math.abs(degDelta)) * Sign(degDelta) * -1
    end

    if (math.abs(degDelta) <= maxSwordDegSpeed) then
        swordDeg = cursorDeg
        return
    end

    -- TODO: make else-if
    if (degDelta < 0) then
        swordDeg -= maxSwordDegSpeed
    end
    if (0 < degDelta) then
        swordDeg += maxSwordDegSpeed
    end

    swordDeg = Ring(swordDeg, 0, 360)
end

local function updateSwordPos()
    local swordRad = (swordDeg - 90) * math.pi / 180
    swordPosX = playerPosX + math.cos(swordRad) * offsetLength
    swordPosY = playerPosY + math.sin(swordRad) * offsetLength
    return cursorDeg
end 

function UpdateSword()
    local cursorDeg = pd.getCrankPosition()
    moveTowardsCursor(cursorDeg)
    updateSwordPos()
end

function DrawSword(rotation)
    swordImage = SetSwordImage(rotation)
    swordImage:drawAnchored(swordPosX, swordPosY, 0.5, 0.5)
end
