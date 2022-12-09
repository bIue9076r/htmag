local x -- Columns
local y -- Rows

local map = {} -- create maps
x = 7
y = 7

-- init map by setting it blank
for i = 1,y do
	map[i] = map[i] or {}
	for j = 1,x do
		map[i][j] = { -- tile object
			value = 0;			-- default tile value
			checked = false;	-- default tile checked
			flaged = false;		-- default tile flaged
		}
	end
end

function drawBoard() -- draw the map
	str = "" -- blank string
	
	-- for each row and column
	for i = 1,y do
		for j = 1,x do
			-- append the value of the tile
			str = str..map[i][j].value..","
		end
		
		-- newline
		str = str.."\n"
	end
	
	-- print to screen
	print(str)
end

function getPlayerInput(input)end

function checkTile(tile) -- check if tile is a bomb
	-- is tile less than 0
	if(tile.value < 0) then
		return true
	end
	return false
end

function mapClear()
	-- place holder function
	return true
end

print("x:"..x..", y:"..y)
drawBoard()

return 0; -- Zero Errors
