import "CoreLibs/graphics"
import "CoreLibs/ui"
import "utility"
import "sprites"
import "obstacles"
import "sword"
import "trailEffect"

Score = 0
HighScore = 0

import "debugValueSetter"

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
local obstacleInterval = 60
local animationFrame = 1
local gameOver = false

-- FromTo
local fromScore = 5
local toScore = 30
local fromObstacleInterval = 60
local toObstacleInterval = 40
local fromMaxSpeed = 2
local toMaxSpeed = 3 -- 2.7
local fromMaxSideSpeedMultiplier = 1.1
local toMaxSideSpeedMultiplier = 1.5

local swordRotation = 0

local enableDebug = true;

local function updateFromTo()
    local current = (Clamp(Score, fromScore, toScore) - fromScore) / (toScore - fromScore)
    MaxSpeed = fromMaxSpeed + current * (toMaxSpeed - fromMaxSpeed)
    obstacleInterval = fromObstacleInterval + current * (toObstacleInterval - fromObstacleInterval)
    MaxSideSpeedMultiplier = fromMaxSideSpeedMultiplier + current * (toMaxSideSpeedMultiplier - fromMaxSideSpeedMultiplier)
    print(MaxSpeed, obstacleInterval, MaxSideSpeedMultiplier)
end

function OnObstacleKill()
    Score += 1
    updateFromTo()
end

local function RestartGame()
    obstacleTimer = 0
    animationFrame = 1
    gameOver = false
    ClearObstacles()
    ClearTrail()
    HighScore = math.max(Score, HighScore)
    Score = 0
    updateFromTo()
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
        if(SwipeDir ~= 0 and SwipeAllowed) then
            CreateTrail(SwipeDir,swordRotation)
        end
        UpdateTrail()
        gameOver = UpdateObstacles(swordRotation, OffsetLength/3 + SwordLength, SwordHalfWidth,SwipeDir)
        --gameOver = false

        obstacleTimer += 1
        if obstacleTimer%5 ==0 then
            animationFrame = -animationFrame
        end
        if obstacleTimer >= obstacleInterval then
            obstacleTimer = 0
            --CreateObstacle()
            --SpawnObstacleLayer()
            SpawnObstacleLayer3()
        end

    end
    playerImage:drawAnchored(playerX, playerY, 0.5, 0.5)
    DrawSword(swordRotation)
    DrawTrail()
    DrawObstacles(animationFrame)

    gfx.drawTextAligned("Bugs slashed: " .. Score, 30, 30, kTextAlignment.left)
    if (HighScore ~= 0) then
        gfx.drawTextAligned("High Score: " .. HighScore, 400 - 30, 30, kTextAlignment.right)
    end

    if gameOver then
        gfx.clear()
        gfx.drawTextAligned("A Bug has entered the game", 200, 80, kTextAlignment.center)
        gfx.drawTextAligned("Bugs slashed: " .. Score, 200, 120, kTextAlignment.center)
        gfx.drawTextAligned("Press A to restart", 200, 240 - 40, kTextAlignment.center)
    end

    -- if (enableDebug and gameOver) then
    --     
    -- end
    
    if (enableDebug) then
        UpdateDebugValueSetter()
        local swSwSfx = ":-)"
        if (not EnableSwordSwingSFX) then
            swSwSfx = ":-("
        end
        local debugText = "Debug info: (" .. MinSwipeEnterSpeed .. ", " .. MinSwipeSpeed .. ") sfx: " .. swSwSfx
        gfx.drawTextAligned(debugText, 400 - 20, 240 - 20, kTextAlignment.right)
    
        if (pd.buttonJustPressed(pd.kButtonB)) then
            PlaySwordSwingSFX()
        end
    end
end
