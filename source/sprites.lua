import "CoreLibs/graphics"


local gfx <const> = playdate.graphics

function SetSwordImage ()
    local size = 64
    local bladeLength = 28
    local bladeWidth = 4
    local tipLength = 5
    local cX = size/2
    local SwordImage = gfx.image.new(size, size)

    gfx.pushContext(SwordImage)
        gfx.drawLine(cX, 0, cX, bladeLength)
        gfx.drawLine(cX-bladeWidth,0,cX-bladeWidth, bladeLength-tipLength)
        gfx.drawLine(cX+bladeWidth,0,cX+bladeWidth, bladeLength-tipLength)
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