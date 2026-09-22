import "sprites"

local pd <const> = playdate

-- ...
local playerPosX = 200
local playerPosY = 120

-- Settings
local offsetLength = 40

-- Variables
local swordDeg = 0
local swordPosX = 0
local swordPosY = 0

-- Sprite
local swordImage = SetPlayerImage()

function UpdateSword()
    local cursorDeg = pd.getCrankPosition()
    -- TODO: swordVal follow cursorVal
    swordDeg = cursorDeg
    local swordRad = (swordDeg - 90) * math.pi / 180
    swordPosX = playerPosX + math.cos(swordRad) * offsetLength
    swordPosY = playerPosY + math.sin(swordRad) * offsetLength
end

function DrawSword()
    swordImage:drawAnchored(swordPosX, swordPosY, 0.5, 0.5)
end
