import "sprites"

local screenWidth <const> = 400
local screenHeight <const> = 240
local obstacles = {}
local minWidth = 20
local minHeight = 20
local maxWidth = 50
local maxHeight = 50
local minSpeed = 1.5
local maxSpeed = 3.0

function CreateObstacle()
	local image, width, height = SetObstacleImage(minWidth, minHeight, maxWidth, maxHeight)
	local obstacle = {
		image = image,
		x = screenWidth + width / 2,
		y = math.random(0, screenHeight - height),
		width = width,
		height = height,
		speed = minSpeed + math.random() * (maxSpeed - minSpeed)
	}

	table.insert(obstacles, obstacle)
end

local function CollisionCheck(a, b)
	return a.x < b.x + b.width
		and b.x < a.x + a.width
		and a.y < b.y + b.height
		and b.y < a.y + a.height
end

function UpdateObstacles(playerLeft, playerTop, playerWidth, playerHeight)
	local player = {
		x = playerLeft,
		y = playerTop,
		width = playerWidth,
		height = playerHeight
	}
	local collided = false

	for index = #obstacles, 1, -1 do
		local obstacle = obstacles[index]
		obstacle.x -= obstacle.speed

		if CollisionCheck(obstacle, player) then
			collided = true
		end

		if obstacle.x + obstacle.width < 0 then
			table.remove(obstacles, index)
		end
	end

	return collided
end

function DrawObstacles()
	for _, obstacle in ipairs(obstacles) do
		obstacle.image:draw(obstacle.x, obstacle.y)
	end
end

function ClearObstacles()
	obstacles = {}
end

