local pd <const> = playdate
local sound <const> = pd and pd.sound

local swordSwingSFX = sound.fileplayer.new("sfx/sword_swing")
local swordSliceSFX = sound.fileplayer.new("sfx/sword_slice")

EnableSwordSwingSFX = false

local swordSwingSFXs = {
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),

    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
    sound.fileplayer.new("sfx/sword_swing"),
}

function PlaySwordSwingSFX()
    if (not EnableSwordSwingSFX) then return end
    for i = #swordSwingSFXs, 1, -1 do
        local sfx = swordSwingSFXs[i]
        if (not sfx:isPlaying()) then
            sfx:setVolume(0.7, 0.7)
            sfx:play()
            print(i)
            return
        end
    end
end

local correctHitSFX = sound.fileplayer.new("sfx/correct_hit")

function PlayCorrectHitSFX()
    if not correctHitSFX then
        return
    end

    correctHitSFX:setVolume(0.5, 0.5)

    correctHitSFX:stop()
    correctHitSFX:play()
end

local incorrectHitSFX = sound.fileplayer.new("sfx/incorrect_hit")

function PlayIncorrectHitSFX()
    if not incorrectHitSFX then
        return
    end

    incorrectHitSFX:setVolume(0.5, 0.5)

    incorrectHitSFX:stop()
    incorrectHitSFX:play()
end

local gameOverSFX = sound.fileplayer.new("sfx/game_over")

function PlayGameOverSFX()
    if not gameOverSFX then
        return
    end

    gameOverSFX:setVolume(0.5, 0.5)

    gameOverSFX:stop()
    gameOverSFX:play()
end
