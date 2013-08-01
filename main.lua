function love.load()
	loadFont()
	size=16
	mapheight = 10
	mapwidth = 15
	windowheight = 160
	windowwidth = 240
	mapLoaded = false
	cT = {} -- Current Terrain
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

end
---------------------------------------
function love.draw()
	if mapLoaded then
	local c = 0
		for a = saveData[2], saveData[2] + 9 do -- draw the ground
			local d = 0
			for b = saveData[3], saveData[3] + 14 do
				love.graphics.drawq(tileset, quads[cT[a][b]], (d)*size,(c)*size)
				if d < 14 then d = d + 1 else d = 0 end
			end
			if c < 9 then c = c + 1 else c = 0 end
		end
	end
end
---------------------------------------
function getKeyBoardInput()

end
---------------------------------------
function loadFont()
	font = love.graphics.newImageFont("Pokefont 10px.png",
	" ABCDEFGHIJKLMNOPQRSTUVWXYZ"..
	"abcdefghijklmnopqrstuvwxyz"..
	"0123456789!?-.~`*/&+@=;$\"^'_".. -- '~' = boy sign, '`' (grave) = girl sign
	"()%\\|<#" --'\' = c with the dangle, '|' (pipe) = PP, '<' = ID, '#' = No
					--'@' = Lv, '^' = end double quote, '_' = end single quote
	)
	love.graphics.setFont(font)
end

---------------------------------------
function getMapData() --relies on getSaveData()
	map = require(saveData[1])
	cT = terrain --terrain is a table in the map file
	mapLoaded = true

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
	tileset = love.graphics.newImage(image) --image is part of the data in the map file
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
