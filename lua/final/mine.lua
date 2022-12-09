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

color = {
	[-1] = "\27[48;2;255;160;122m",		--// _REDBTC	-1
	[0] = "\27[48;2;162;211;242m",		--// _CYNBTC	0
	[1] = "\27[48;2;20;20;20m",			--// _BLKBTC	1
	[2] = "\27[48;2;112;151;176m",		--// _BLUBTC	2
	[3] = "\27[48;2;133;132;205m",		--// _LBLUBTC	3
	[4] = "\27[48;2;250;165;255m",		--// _MAGBTC	4
	[5] = "\27[48;2;241;255;103m",		--// _YELBTC	5
	[6] = "\27[48;2;204;204;204m",		--// _GRYBTC	6
	[7] = "\27[48;2;162;211;242m",		--// _CYNBTC	7
	[8] = "\27[48;2;255;255;255m",		--// _WHTHBTC	8
	['d'] = "\27[48;2;255;255;255m",	--// _WHTHBTC	d
	['r'] = "\27[0m",					--// _reset	r
}
reset = color['r']

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

function drawRow() -- draw the map
	str = "" -- blank string
	
	-- for each row and column
	for i = 1,y do
		for j = 1,x do
			-- append the value of the tile
			if not(map[i][j].checked) then
				str = str..color[0].."  x  "..reset
			else
				if (map[i][j].value < 0) then
					str = str..color[map[i][j].value].." "..map[i][j].value.."  "..reset
				else
					str = str..color[map[i][j].value].."  "..map[i][j].value.."  "..reset
				end
			end
		end
		
		-- newline
		str = str.."\n"
	end
	
	-- print to screen
	print(str)
end

function checkTile(tile) -- check if tile is a bomb
	-- is tile less than 0
	if(tile.value < 0) then
		return true
	end
	return false
end

function revealtile(tile)
	tile.checked = true
end

function checkneighbors(ix,iy)
	if(map[iy][ix].value < 0) then return -1; end
	local ret = 0
	
	if(ix + 1 < x + 1)then
		if(checkTile(map[iy][ix + 1]))then
			ret = ret + 1
		end
		if(iy + 1 < y + 1)then
			if(checkTile(map[iy + 1][ix + 1]))then
				ret = ret + 1
			end
		end
		if(iy - 1 > 0)then
			if(checkTile(map[iy - 1][ix + 1]))then
				ret = ret + 1
			end
		end
	end
	if(ix - 1 > 0)then
		if(checkTile(map[iy][ix - 1]))then
			ret = ret + 1
		end
		if(iy + 1 < y + 1)then
			if(checkTile(map[iy + 1][ix - 1]))then
				ret = ret + 1
			end
		end
		if(iy - 1 > 0)then
			if(checkTile(map[iy - 1][ix - 1]))then
				ret = ret + 1
			end
		end
	end
	
	if(iy + 1 < y + 1)then
		if(checkTile(map[iy + 1][ix]))then
			ret = ret + 1
		end
	end
	if(iy - 1 > 0)then
		if(checkTile(map[iy - 1][ix]))then
			ret = ret + 1
		end
	end
	
	return ret
end

function updateTiles()
	-- for every row and column in the Map
	for i = 1,y do
		for j = 1,x do
			-- show the tile
			map[i][j].value = checkneighbors(j,i)
		end
	end
end

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

local sx,sy
placemines(map)	-- place mines
updateTiles()
repeat
	print("\n")
	drawRow()	-- draw the map
	
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
if not (mapClear()) then
	print("\nYOU WIN\n")	-- winner :D
end
showAll()		-- show the map
drawRow()	-- draw the map
return 0; -- Zero Errors
