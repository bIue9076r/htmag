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
			if not(map[i][j].checked) then
				str = str.." x,"
			else
				if (map[i][j].value < 0) then
					str = str..map[i][j].value..","
				else
					str = str.." "..map[i][j].value..","
				end
			end
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

--//-------New-CHANGE------------//--
function revealtile(tile)
	tile.checked = true
end
--//----------------------------//--

function mapClear()
	ret = false
	
	-- for each row and column
	for i = 1,y do
		for j = 1,x do
			if not(checkTile(map[i][j])) then
				if not(map[i][j].checked) then
					ret = true
				end
			end
		end
	end
	
	return ret
end

--//-------New-CHANGE------------//--
function placemines()
	-- for each row and column
	for i = 1,y do
		for j = 1,x do
			if((math.random(1,10) % 2) == 1) then
				-- set bombs randomly
				map[i][j].value = -1
			end
		end
	end
end

function showAll()
	-- for each row and column
	for i = 1,y do
		for j = 1,x do
			map[i][j].checked = true
		end
	end
end
--//----------------------------//--
--// removed: print("x:"..x..", y:"..y)
--// removed: drawBoard()

--//-------New-CHANGE------------//--
local sx,sy
placemines(map)	-- place mines
repeat
	print("\n")
	drawBoard()	-- draw the map
	
	-- get player input
	print("enter tile x:")				-- input text for x
	sx = io.read(); sx = tonumber(sx)	-- read x from stdin
	print("enter tile y:")				-- input text for y
	sy = io.read(); sy = tonumber(sy)	-- read y from stdin
	
	if(checkTile(map[sy][sx])) then
		-- if tile is a bomb
		print("\nTHAT'S A BOMB");
		print("GAME OVER\n");	-- loser XD
		break;
	end
	
	revealtile(map[sy][sx])	-- show the tile
until not(mapClear())	-- repeat until map is not clear
if (mapClear()) then
	print("\nYOU WIN\n")	-- winner :D
end
showAll()		-- show the map
drawBoard()		-- draw the map
--//----------------------------//--
return 0; -- Zero Errors
