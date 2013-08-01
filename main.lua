function love.load()
	require "gamedata" --for the sake of abstraction
	loadFont()
	timer = 0
	size=16
	mapheight = 10
	mapwidth = 15
	windowheight = 160
	windowwidth = 240
	drawOverride = true
	cT = {} -- Current Terrain
	cD = {} -- Current Data (solid, nonsolid blocks)
	nT = {} -- Next Terrain (from load tiles)
	nD = {} -- Next Data
	love.graphics.setMode(windowwidth,windowheight,false,false,0)
	--[[
		load save
		look at save
		start from save
		load tileset
		render world
		render NPCs
	--]]
	getSaveData()
	getMapData()
	loadTileSetImage()
	loadQuads()
end
---------------------------------------
function love.update()
	getKeyBoardInput()
end
---------------------------------------
function love.draw()
	if not drawOverride then
		local c = 0
		for a = saveData[2], saveData[2] + 9 do -- draw the ground
			local d = 0
			for b = saveData[3], saveData[3] + 14 do
				love.graphics.drawq(tileset, quads[cT[a][b]], (d)*size,(c)*size)
				if d < 14 then d = d + 1 else d = 0 end
			end
			if c < 9 then c = c + 1 else c = 0 end
		end
		--[[
		get quads of character animations
		draw character
			draw at (screenheight/2, screenwidth/2) offset (-spriteheight/2, -spritewidth/2)
		if an animation occurs, display the frames (quads) in sequence
		--]]
	end
end
---------------------------------------
function getKeyBoardInput()
	if love.keyboard.isDown("w") then
		if love.timer.getTime() - timer > .25 then
			saveData[2] = saveData[2] - 1
			timer = love.timer.getTime()
		end
	end
	if love.keyboard.isDown("a") then
		if love.timer.getTime() - timer > .25 then
			saveData[3] = saveData[3] - 1
			timer = love.timer.getTime()
		end
	end
	if love.keyboard.isDown("s") then
		if love.timer.getTime() - timer > .25 then
			saveData[2] = saveData[2] + 1
			timer = love.timer.getTime()
		end
	end
	if love.keyboard.isDown("d") then
		if love.timer.getTime() - timer > .25 then
			saveData[3] = saveData[3] + 1
			timer = love.timer.getTime()
		end
	end
end
---------------------------------------
function getMapData() --relies on getSaveData()
	map = require(saveData[1])
	cT = terrain --terrain is a table in the map file
	drawOverride = false

end
---------------------------------------
function getSaveData() --called first
	saveData = {}
	for lines in love.filesystem.lines("save.save") do
		table.insert(saveData, lines)
	end
end
---------------------------------------
function loadTileSetImage() --relies on getMapData()
	tileset = love.graphics.newImage(image) --image is variable in the data in the map file
end

---------------------------------------
function loadQuads() --relies on loadTileSetImage()
	quads = {}
	local datah = tileset:getHeight()
	local dataw = tileset:getWidth()
	local tilesx = dataw / 16
	local tilesy = datah / 16
	local count = 0
	local quada = {}
	for _ = 1, tilesy do
		quads[_] = {}
		for a = 1, tilesx do
			count = count + 1
			local x = (a - 1) * 16
			local y = (_ - 1) * 16
			quada[count] = {count, x ,y}
		end
	end
	for _ = 1, #quada do
		quads[_] = love.graphics.newQuad(quada[_][2],quada[_][3],size,size,dataw,datah)
	end
end
