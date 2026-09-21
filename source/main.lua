import "CoreLibs/graphics"
import "CoreLibs/ui"
import "utility"
import "sprites"
import "obstacles"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

local gravity = 0.5

-- Defining player variables
local playerSize = 10
local playerWidth = 27
local playerHeight = 27
local playerVelocity = 3
local playerX, playerY = 200, 30
local playerImage = SetPlayerImage()

local obstacleTimer = 0
local obstacleInterval = 90
local gameOver = false

-- Platform
local platformY = 120
local prevPlatformY = 120
local platformSizeY = 10
local platformMin = 30
local platformMax = 210
local platformImage = SetPlatformImage()

local function RestartGame()
    playerY = 30
    playerVelocity = 3
    platformY = 120
    obstacleTimer = 0
    gameOver = false
    ClearObstacles()
end

-- playdate.update function is required in every project!
function playdate.update()
    -- Clear screen
    gfx.clear()

    if gameOver and pd.buttonJustPressed(pd.kButtonA) then
        RestartGame()
    end

    -- Draw crank indicator if crank is docked
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:draw()
    elseif not gameOver then
        -- Calculate velocity from crank angle 
        local crankPosition = pd.getCrankPosition()

        platformY = platformMin + CrankYVal(crankPosition)
        playerVelocity += gravity
        playerY += playerVelocity

        local platformTop = platformY - platformSizeY / 2
        local newPlayerY = Clamp(playerY, 0, platformTop - playerHeight)
        if (newPlayerY ~= playerY) then
            playerVelocity = 0
        end
        playerY = newPlayerY

        obstacleTimer += 1
        if obstacleTimer >= obstacleInterval then
            obstacleTimer = 0
            CreateObstacle()
        end

        if UpdateObstacles(playerX - playerWidth / 2, playerY, playerWidth, playerHeight) then
            gameOver = true
        end

    end
    -- Draw text
    --gfx.drawTextAligned("Template configured!", 200, 30, kTextAlignment.center)
    -- Draw player
    playerImage:drawAnchored(playerX, playerY + playerHeight / 2, 0.5, 0.5)
    platformImage:drawAnchored(200, platformY, 0.5, 0.5)
    DrawObstacles()

    if gameOver then
        gfx.drawTextAligned("Press A to restart", 200, 30, kTextAlignment.center)
    end
end
