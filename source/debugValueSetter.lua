local pd <const> = playdate

function UpdateDebugValueSetter()
    if (pd.buttonJustPressed(pd.kButtonUp)) then
        MinSwipeEnterSpeed += 1
    end
    if (pd.buttonJustPressed(pd.kButtonDown)) then
        MinSwipeEnterSpeed -= 1
    end

    if (pd.buttonJustPressed(pd.kButtonRight)) then
        MinSwipeSpeed += 1
    end
    if (pd.buttonJustPressed(pd.kButtonLeft)) then
        MinSwipeSpeed -= 1
    end
end
