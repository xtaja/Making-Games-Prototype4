local pd <const> = playdate
local sound <const> = pd and pd.sound

local swordSwingSFX = sound.fileplayer.new("sfx/sword_swing")
local swordSliceSFX = sound.fileplayer.new("sfx/sword_slice")

function PlaySwordSwingSFX()
    local sfx = swordSwingSFX or swordSliceSFX
    if not sfx then
        return
    end

    sfx:stop()
    sfx:play()
end

local correctHitSFX = sound.fileplayer.new("sfx/correct_hit")

function PlayCorrectHitSFX()
    if not correctHitSFX then
        return
    end

    correctHitSFX:stop()
    correctHitSFX:play()
end

local incorrectHitSFX = sound.fileplayer.new("sfx/incorrect_hit")

function PlayIncorrectHitSFX()
    if not incorrectHitSFX then
        return
    end

    incorrectHitSFX:stop()
    incorrectHitSFX:play()
end

local gameOverSFX = sound.fileplayer.new("sfx/game_over")

function PlayGameOverSFX()
    if not gameOverSFX then
        return
    end

    gameOverSFX:stop()
    gameOverSFX:play()
end
