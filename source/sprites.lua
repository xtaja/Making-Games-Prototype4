import "CoreLibs/graphics"


local gfx <const> = playdate.graphics

function SetSwordImage (deg)
    local size = 64
    local bladeLength = 28
    local SwordImage = gfx.image.new(size, size)
    local cx, cy = size / 2, size / 2

    local angle = math.rad(deg - 90)
    local tipX = cx + math.cos(angle) * bladeLength
    local tipY = cy + math.sin(angle) * bladeLength

    gfx.pushContext(SwordImage)
        gfx.drawLine(cx, cy, tipX, tipY)
    gfx.popContext()
    return SwordImage
end

function SetPlatformImage ()
    local PlatformImage =gfx.image.new(75,15)
    gfx.pushContext(PlatformImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(0,0,75,15,3)
    gfx.popContext()
    return PlatformImage
end

function SetObstacleImage(minWidth, minHeight, maxWidth, maxHeight)
    local width = math.random(minWidth, maxWidth)
    local height = math.random(minHeight, maxHeight)
    local ObstacleImage = gfx.image.new(width, height)
    gfx.pushContext(ObstacleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(0,0,width,height,3)
    gfx.popContext()
    return ObstacleImage, width, height
end