import "sprites"
import "sword"
import "utility"

local screenWidth <const> = 400
local screenHeight <const> = 240
local obstacles = {}
local minRadius = 20
local maxRadius = 25
local minSpeed = 1.5
local maxSpeed = 3.0
local distance = CalcDist(screenWidth, screenHeight) / 2 + 25
local groundZeroOffSet = OffsetLength + SwordLength / 2 -- 75

function CreateObstacle()
	local angle = math.random() * 2 * math.pi -- DegToRad(30.96)
	local radius = math.random(minRadius, maxRadius)
	local type = math.random(0,1)
	local image, radius = SetObstacleImage(type, radius)
	local speed = minSpeed + math.random() * (maxSpeed - minSpeed)
	-- the enemy will always reach the groundZeroOffSet at the correct time...
	--local spawnDistance = (distance - groundZeroOffSet) * speed / minSpeed + groundZeroOffSet
	local spawnDistance = distance
	local obstacle = {
		image = image,
		angle = angle,
		type = type,
		x = screenWidth/2 + math.cos(angle) * spawnDistance,
		y = screenHeight/2 + math.sin(angle) * spawnDistance,
		radius = radius,
		direction = {
			x = -math.cos(angle),
			y = -math.sin(angle)
		},
		speed = speed
	}

	table.insert(obstacles, obstacle)
end

local function SwordCollision(obstacle, swordRotation, swordLength, swordHalfWidth, swipeDir)

	local dx = obstacle.x - screenWidth / 2
	local dy = obstacle.y - screenHeight / 2

	local swordRad = (swordRotation - 90) * math.pi / 180
	local swordDX = math.cos(swordRad)
	local swordDY = math.sin(swordRad)

	local projection = dx * swordDX + dy * swordDY

	if projection < 0 then
		return false
	end

	if projection > swordLength + obstacle.radius then
		return false
	end

	local perpendicularDistance = math.abs(dx * swordDY - dy * swordDX)

	return perpendicularDistance <= swordHalfWidth + obstacle.radius
end

function UpdateObstacles(swordRotation, swordLength, swordHalfWidth, swipeDir)
	local flipSign = 1
	if (Flipped) then
		flipSign = -1
	end
	for i = #obstacles, 1, -1 do
		local obstacle = obstacles[i]
		obstacle.x += obstacle.speed * obstacle.direction.x
		obstacle.y += obstacle.speed * obstacle.direction.y

		local dx = obstacle.x - screenWidth / 2
		local dy = obstacle.y - screenHeight / 2
		local distance = math.sqrt(dx * dx + dy * dy)

		if distance <= obstacle.radius then
			--table.remove(obstacles, i)
			return true --collided with player
		end
		if(swipeDir ~= 0) then
			if SwordCollision(obstacle, swordRotation, swordLength, swordHalfWidth, swipeDir) then
				if(obstacle.type == 0 and swipeDir * flipSign == -1) or (obstacle.type == 1 and swipeDir * flipSign == 1) then
					-- correct swipe direction, destroy obstacle
					table.remove(obstacles, i)
					Score += 1
				else
					-- incorrect swipe direction, game over
					return true
				end
			end
		end

	end

	return false
end

function DrawObstacles()
	for _, obstacle in ipairs(obstacles) do
		obstacle.image:draw(obstacle.x - obstacle.radius, obstacle.y - obstacle.radius)
	end
end

function ClearObstacles()
	obstacles = {}
end

