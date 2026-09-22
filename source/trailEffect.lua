import "sprites"

local screenWidth <const> = 400 --make them global?
local screenHeight <const> = 240
local trail = {}
local minRadius = 17
local maxRadius = 22
local distance = 50
local offset = 10
local lifeTime = 30

function CreateTrailPatricle(type, swordRotation, offset)
    local radius = math.random(minRadius, maxRadius)
    local image = SetTrailParticleImage(type,radius)
    local shrinkFactor = math.random(65,85)*0.01
    local trailParticle = {
        x = screenWidth/2 + math.cos(math.rad(swordRotation - 90)) * distance + offset,
        y = screenHeight/2 + math.sin(math.rad(swordRotation - 90)) * distance + offset,
        radius = radius,
        image = image,
        type = type,
        shrinkFactor = shrinkFactor,
        lifeTime = lifeTime
    }
    table.insert(trail, trailParticle)
end

function CreateTrail(type, swordRotation)
    CreateTrailPatricle(type, swordRotation, 5 + offset * math.random())
    CreateTrailPatricle(type, swordRotation, 5 + offset * math.random())
    CreateTrailPatricle(type, swordRotation, 5 + offset * math.random())
end

function UpdateTrail()
    for i = #trail, 1, -1 do
        local trailParticle = trail[i]
        trailParticle.lifeTime -= 1
        trailParticle.radius = trailParticle.radius * trailParticle.shrinkFactor
        if trailParticle.lifeTime <= 0 or trailParticle.radius <= 1 then
            table.remove(trail, i)
        end
        trailParticle.image = SetTrailParticleImage(trailParticle.type, trailParticle.radius)
    end
end

function DrawTrail()
    for _, trailParticle in ipairs(trail) do
        trailParticle.image:draw(trailParticle.x - trailParticle.radius, trailParticle.y - trailParticle.radius)
    end
end

function ClearTrail()
    trail = {}
end