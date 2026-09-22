import "CoreLibs/graphics"


local gfx <const> = playdate.graphics

function SetPlayerImage ()
    local PlayerImage = gfx.image.new(32, 32)
    gfx.pushContext(PlayerImage)
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
    return PlayerImage
end

function SetPlatformImage ()
    local PlatformImage =gfx.image.new(75,15)
    gfx.pushContext(PlatformImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(0,0,75,15,3)
    gfx.popContext()
    return PlatformImage
end

function SetObstacleImage(minWidth, minHeight, maxWidth, maxHeight, angle)
    local width = math.random(minWidth, maxWidth)
    local height = math.random(minHeight, maxHeight)
    local ObstacleImage = gfx.image.new(width, height)
    gfx.pushContext(ObstacleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(0,0,width,height,3)
    gfx.popContext()
    return ObstacleImage, width, height
end