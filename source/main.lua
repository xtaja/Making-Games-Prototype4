-- Below is a small example program where you can move a circle
-- around with the crank. You can delete everything in this file,
-- but make sure to add back in a playdate.update function since
-- one is required for every Playdate game!
-- =============================================================

-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "functions"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

local gravity = 0.5

-- Defining player variables
local playerSize = 10
local playerVelocityY = 3
local playerX, playerY = 200, 30

-- Platform
local platformY = 120
local platformSizeY = 10
local platformMin = 30
local platformMax = 210

-- Drawing player image
local playerImage = gfx.image.new(32, 32)
gfx.pushContext(playerImage)
    -- Draw outline
    gfx.drawRoundRect(4, 3, 24, 26, 1)
    -- Draw screen
    gfx.drawRect(7, 6, 18, 12)
    -- Draw eyes
    gfx.drawLine(10, 12, 12, 10)
    gfx.drawLine(12, 10, 14, 12)
    gfx.drawLine(17, 12, 19, 10)
    gfx.drawLine(19, 10, 21, 12)
    -- Draw crank
    gfx.drawRect(27, 15, 3, 9)
    -- Draw A/B buttons
    gfx.drawCircleInRect(16, 20, 4, 4)
    gfx.drawCircleInRect(21, 20, 4, 4)
    -- Draw D-Pad
    gfx.drawRect(8, 22, 6, 2)
    gfx.drawRect(10, 20, 2, 6)
gfx.popContext()

local platformImage =gfx.image.new(150,15)
gfx.pushContext(platformImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRoundRect(0,0,150,15,3)
gfx.popContext()

-- playdate.update function is required in every project!
function playdate.update()
    -- Clear screen
    gfx.clear()
    -- Draw crank indicator if crank is docked
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:draw()
    else
        -- Calculate velocity from crank angle 
        local crankPosition = pd.getCrankPosition()

        platformY = platformMin + CrankYVal(crankPosition)

        playerVelocityY += gravity

        playerY += playerVelocityY
        local newPlayerY = Clamp(playerY, 0, platformY-platformSizeY-playerSize)
        if (newPlayerY ~= playerY) then
            playerVelocityY = 0
        end
        playerY = newPlayerY

        --local xVelocity = math.cos(math.rad(crankPosition)) * playerVelocity
        --local yVelocity = math.sin(math.rad(crankPosition)) * playerVelocity
        -- Move player
        --playerX += xVelocity
        --playerY += yVelocity
        -- Loop player position
        --playerX = ring(playerX, -playerSize, 400 + playerSize)
        --playerY = ring(playerY, -playerSize, 240 + playerSize)
    end
    -- Draw text
    gfx.drawTextAligned("Template configured!", 200, 30, kTextAlignment.center)
    -- Draw player
    playerImage:drawAnchored(playerX, playerY, 0.5, 0.5)
    platformImage:drawAnchored(200, platformY, 0.5, 0.5)
end
