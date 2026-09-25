import "sprites"
import "sword"
import "utility"
import "sound"

local screenWidth <const> = 400
local screenHeight <const> = 240
local obstacles = {}
local minRadius = 15
local maxRadius = 20
local minSpeed = 1.7
MaxSpeed = 2
local maxSideSpeedMultiplier = 1.5
local distance = CalcDist(screenWidth, screenHeight) / 2 + 25
local groundZeroOffSet = OffsetLength + SwordLength / 2 -- 75

MaxObstacleCountInLayer = 0
local currentMaxObstacleCountInLayer = MaxObstacleCountInLayer

function SpawnObstacleLayer3()
	local option = math.random(0, 4)
	local angle = math.random() * 2 * math.pi

	if option == 0 then
	elseif option == 1 then
		CreateObstacle()
	elseif option == 2 then
		CreateObstacle(angle, 1)
		CreateObstacle(angle + DegToRad(90 + 45), -1)
	elseif option == 3 then
		local type = RandomType()
		CreateObstacle(angle, type)
		CreateObstacle(angle + DegToRad(90 - 22.5), type)
	end
end

function SpawnObstacleLayer2()
	local obstacleCount = math.random(0, 2)
	local angle = math.random() * 2 * math.pi
	if (obstacleCount == 0) then return end
	local type1 = RandomType()
	CreateObstacle(angle, type1)
	if (obstacleCount == 1) then return end
	local deltaAngle = DegToRad(90)
	if (type1 == -1) then
		deltaAngle = DegToRad(360 - 90)
	end 
	CreateObstacle(angle + deltaAngle, -type1)
end

function SpawnObstacleLayer()
	local minAngle = 0
	local maxAngle = 2 * math.pi
	local angleMargin = DegToRad(22.5)
	local obstacleCount = math.random(0, currentMaxObstacleCountInLayer)
	--currentMaxObstacleCountInLayer -= 1
	currentMaxObstacleCountInLayer -= obstacleCount;
	local type = RandomType()
	local otherType = -type--RandomType()
	local delayFrames = 0
	for i = 0, obstacleCount - 1 do
		local angle = minAngle + math.random() * (maxAngle - minAngle)
		--print(i, "from:", minAngle, angle, maxAngle)
		if (angle - minAngle < maxAngle - angle) then
			minAngle = angle + angleMargin
		else
			maxAngle = angle - angleMargin
		end

		--local angle = i * 2 * math.pi / obstacleCount
		CreateObstacle(angle, type, delayFrames)
		type = otherType
		delayFrames = 20
		--currentMaxObstacleCountInLayer -= 1
		--print(i, "to:", minAngle, maxAngle)
		if (maxAngle < minAngle + 2 * angleMargin) then
			--currentMaxObstacleCountInLayer = math.min(currentMaxObstacleCountInLayer + 1, MaxObstacleCountInLayer)
			currentMaxObstacleCountInLayer += 1
			print(i + 1, currentMaxObstacleCountInLayer, MaxObstacleCountInLayer)
			return
		end
	end
	--currentMaxObstacleCountInLayer = math.min(currentMaxObstacleCountInLayer + 1, MaxObstacleCountInLayer)
	currentMaxObstacleCountInLayer += 1
	print(obstacleCount, currentMaxObstacleCountInLayer, MaxObstacleCountInLayer)
end

function CreateObstacle(angle, type, delay)--(minAngle, maxAngle)
	angle = angle or math.random() * 2 * math.pi
	type = type or RandomType()
	delay = delay or 0

	local angleDeg = RadToDeg(angle)
	local maxSideSpeed = MaxSpeed * maxSideSpeedMultiplier

	local radius = math.random(minRadius, maxRadius)
	local image0, radius = SetObstacleImage(type, radius, 1)
	local image1, radius = SetObstacleImage(type, radius, -1)
	local speed = minSpeed --+ math.random() * (maxSpeed - minSpeed)
	if ((0 <= angleDeg and angleDeg <= 30) or (150 <= angleDeg and angleDeg <= 210) or (330 <= angleDeg and angleDeg <= 390)) then
		speed = minSpeed + math.random() * (maxSideSpeed - minSpeed)
	end
	local delayOffset = delay * speed
	local spawnDistance = (distance - groundZeroOffSet) * speed / minSpeed + groundZeroOffSet + delayOffset
	--local spawnDistance = distance
	local obstacle = {
		image0 = image0,
		image1 = image1,
		angle = angle,
		type = type,
		x = screenWidth/2 + math.cos(angle) * spawnDistance,
		y = screenHeight/2 + math.sin(angle) * spawnDistance,
		radius = radius,
		rotation = RadToDeg(angle)+90,
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

		if distance <= 5 then
			--table.remove(obstacles, i)
			PlayGameOverSFX()
			return true --collided with player
		end
		if(swipeDir ~= 0 and SwipeAllowed) then
			if SwordCollision(obstacle, swordRotation, swordLength, swordHalfWidth, swipeDir) then
				if(obstacle.type == -1 and swipeDir * flipSign == -1) or (obstacle.type == 1 and swipeDir * flipSign == 1) then
					-- correct swipe direction, destroy obstacle
					table.remove(obstacles, i)
					OnObstacleKill()
					PlayCorrectHitSFX()
				else
					-- incorrect swipe direction, game over
					PlayIncorrectHitSFX()
					return true
				end
			end
		end

	end

	return false
end

function DrawObstacles(animationFrame)
	for _, obstacle in ipairs(obstacles) do
		if animationFrame ==1 then
			obstacle.image0:drawRotated(obstacle.x - obstacle.radius, obstacle.y - obstacle.radius,obstacle.rotation)
		else
			obstacle.image1:drawRotated(obstacle.x - obstacle.radius, obstacle.y - obstacle.radius,obstacle.rotation)
		end
	end
end

function ClearObstacles()
	obstacles = {}
end

