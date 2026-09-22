import "sprites"

local screenWidth <const> = 400
local screenHeight <const> = 240
local obstacles = {}
local type = 0
local minSize = 20
local maxSize = 35
local minSpeed = 1.2
local maxSpeed = 2.0
local angle = 0
local distance = screenWidth


function CreateObstacle()
	local angle = math.random() * 2 * math.pi
	local type = math.random(0,1)
	local image, size = SetObstacleImage(type, minSize, maxSize, angle)
	local obstacle = {
		image = image,
		angle = angle,
		type = type,
		x = screenWidth/2 + math.cos(angle) * distance - size,
		y = screenHeight/2 + math.sin(angle) * distance - size,
		width = size,
		height = size,
		direction = {
			x = -math.cos(angle),
			y = -math.sin(angle)
		},
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

	for i = #obstacles, 1, -1 do
		local obstacle = obstacles[i]
		obstacle.x += obstacle.speed * obstacle.direction.x
		obstacle.y += obstacle.speed * obstacle.direction.y

		if CollisionCheck(obstacle, player) then
			collided = true
			table.remove(obstacles, i)
		end

	end

	return false --collided
end

function DrawObstacles()
	for _, obstacle in ipairs(obstacles) do
		obstacle.image:draw(obstacle.x, obstacle.y)
	end
end

function ClearObstacles()
	obstacles = {}
end

