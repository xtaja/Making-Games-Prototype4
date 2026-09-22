import "sprites"
import "utility"

local pd <const> = playdate

-- ...
local playerPosX = 200
local playerPosY = 120

-- Settings
local minSwordSwipeDegSpeed = 40
local maxSwordDegSpeed = 50
OffsetLength = 50
SwordLength = 50
SwordHalfWidth = 4
Flipped = false


-- Variables
local swordDeg = 0
local swordPosX = 0
local swordPosY = 0
SwipeDir = 0

-- Sprite
local swordImage = SetSwordImage()
local playerImage = SetPlayerImage()

local function updateSwipeDir(degDelta)
    if (minSwordSwipeDegSpeed < math.abs(degDelta)) then
        SwipeDir = Sign(degDelta)
        return
    end
    SwipeDir = 0
end

local function moveTowardsCursor(cursorDeg)
    local degDelta = cursorDeg - swordDeg

    if (180 < math.abs(degDelta)) then
        degDelta = (360 - math.abs(degDelta)) * Sign(degDelta) * -1
    end

    updateSwipeDir(degDelta)

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
    swordPosX = playerPosX + math.cos(swordRad) * OffsetLength
    swordPosY = playerPosY + math.sin(swordRad) * OffsetLength
    return swordDeg
end 

function UpdateSword()
    local cursorDeg = pd.getCrankPosition()
    moveTowardsCursor(cursorDeg)
    return updateSwordPos()
end

function DrawSword(rotation)
    local angle = rotation or swordDeg
    swordImage = SetSwordImage()
    swordImage:drawRotated(swordPosX, swordPosY, angle+180)
    if (SwipeDir ~= 0) then
        -- Draw Sword Swipe
        playerImage:drawAnchored(swordPosX, swordPosY, 0.5,0.5)
    end
end
