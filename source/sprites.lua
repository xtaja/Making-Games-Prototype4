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

function SetSwordImage ()
    local size = 64
    local bladeLength = SwordLength*2/3
    local bladeWidth = SwordHalfWidth

    local handleLength = SwordLength-bladeLength
    local gripLength = handleLength*0.8

    local guardWidth = 8
    local guardLength = handleLength-gripLength
    local tipLength = 5
    local gripWidth = 2
    local cX = size/2
    local SwordImage = gfx.image.new(size, size)
    local FlipSign = 1
    
    if(Flipped) then
        FlipSign = -1
    end

    gfx.pushContext(SwordImage)
        gfx.drawLine(cX, handleLength, cX, bladeLength+handleLength)
        --blade
        gfx.drawLine(
            cX-bladeWidth, handleLength,
            cX-bladeWidth, bladeLength-tipLength+handleLength
        )
        gfx.drawLine(
            cX+bladeWidth,handleLength,
            cX+bladeWidth, bladeLength-tipLength+handleLength
        )
        --tip
        gfx.drawLine(
            cX-bladeWidth, bladeLength-tipLength+handleLength, 
            cX, bladeLength+handleLength
        )
        gfx.drawLine(
            cX+bladeWidth, bladeLength-tipLength+handleLength, 
            cX, bladeLength+handleLength
        )
        --handle
        gfx.drawRect(cX+guardWidth, handleLength,-guardWidth*2,-guardLength)
        gfx.drawRect(cX+gripWidth, 0,-gripWidth*2,gripLength)

        --colorin
        gfx.fillPolygon(
            cX, bladeLength+handleLength,
            cX+(bladeWidth*FlipSign), bladeLength-tipLength+handleLength,
            cX+(bladeWidth*FlipSign),handleLength,
            cX, handleLength
        )

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