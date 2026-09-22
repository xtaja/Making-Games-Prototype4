import "sprites"

local screenWidth <const> = 400
local screenHeight <const> = 240
local obstacles = {}
local minWidth = 20
local minHeight = 20
local maxWidth = 35
local maxHeight = 35
local minSpeed = 1.0
local maxSpeed = 2.5
local angle = 0
local direction ={
	x = 0,
	y = 0
}
local distance = screenWidth


function CreateObstacle()
	local angle = math.random() * 2 * math.pi
	local image, width, height = SetObstacleImage(minWidth, minHeight, maxWidth, maxHeight,angle)
	local obstacle = {
		image = image,
		angle = angle,
		x = screenWidth/2 + math.cos(angle) * distance - width, -- i think we should make them be the same height and width
		y = screenHeight/2 + math.sin(angle) * distance - height,
		width = width,
		height = height,
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

