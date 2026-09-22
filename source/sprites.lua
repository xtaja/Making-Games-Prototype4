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

function SetObstacleImage(type,minSize, maxSize, angle)
    local size = math.random(minSize, maxSize)
    
    local ObstacleImage = gfx.image.new(size, size)
    
    gfx.pushContext(ObstacleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillCircleAtPoint(size/2, size/2, size/2)
        if type == 1 then
            gfx.setColor(gfx.kColorWhite )
            gfx.fillCircleAtPoint(size/2, size/2, size/2-2)
        end
    gfx.popContext()
    return ObstacleImage, size
end