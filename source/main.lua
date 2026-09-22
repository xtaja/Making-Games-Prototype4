import "CoreLibs/graphics"
import "CoreLibs/ui"
import "utility"
import "sprites"
import "obstacles"
import "sword"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

local gravity = 0.5

-- Defining player variables
local playerSize = 10
local playerWidth = 27
local playerHeight = 27
local playerX, playerY = 200, 120
local playerImage = SetPlayerImage()

local obstacleTimer = 25
local obstacleInterval = 50
local gameOver = false


local swordRotation = 0

local function RestartGame()
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
        swordRotation = UpdateSword()
        gameOver = UpdateObstacles(swordRotation, OffsetLength/3 + SwordLength, SwordHalfWidth,SwipeDir)

        obstacleTimer += 1
        if obstacleTimer >= obstacleInterval then
            obstacleTimer = 0
            CreateObstacle()
        end

    end
    playerImage:drawAnchored(playerX, playerY, 0.5, 0.5)
    DrawSword(swordRotation)
    DrawObstacles()

    if gameOver then
        gfx.drawTextAligned("Press A to restart", 200, 30, kTextAlignment.center)
    end
end
