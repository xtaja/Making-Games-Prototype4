-- Below is a small example program where you can move a circle
-- around with the crank. You can delete everything in this file,
-- but make sure to add back in a playdate.update function since
-- one is required for every Playdate game!
-- =============================================================

-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "utility"
import "sprites"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

local gravity = 0.5

-- Defining player variables
local playerSize = 10
local playerVelocityY = 3
local playerX, playerY = 200, 30
local maxPlayerVelocityY = 20

-- Platform
local platformY = 120
local prevPlatformY = 120
local platformSizeY = 10
local platformMin = 30
local platformMax = 210

local playerImage = SetPlayerImage()

local platformImage = SetPlatformImage()

local function playerUpdate()
    -- Calculate velocity from crank angle 
    local crankPosition = pd.getCrankPosition()

    platformY = platformMin + CrankYVal(crankPosition)
    --local platformVelocityY = platformY - prevPlatformY
    
    playerVelocityY += gravity
    
    playerY += playerVelocityY
    
    local maxPlayerPos = platformY-platformSizeY-playerSize
    
    if (maxPlayerPos < playerY) then
        local newVelocity = maxPlayerPos - playerY
        playerY = maxPlayerPos
        --print(newVelocity)
        --playerVelocityY = newVelocity
        playerVelocityY = Clamp(newVelocity, -maxPlayerVelocityY, 0)
    end

    --playerVelocityY = Clamp(playerVelocityY, )

    prevPlatformY = platformY
end

-- playdate.update function is required in every project!
function playdate.update()
    -- Clear screen
    gfx.clear()
    -- Draw crank indicator if crank is docked
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:draw()
    else
        playerUpdate()
    end
    -- Draw text
    gfx.drawTextAligned("Template configured!", 200, 30, kTextAlignment.center)
    -- Draw player
    playerImage:drawAnchored(playerX, playerY, 0.5, 0.5)
    platformImage:drawAnchored(200, platformY, 0.5, 0.5)
end
