function love.load()
	loadFont()
	split = require "stringsplit"
	size=16
	mapheight = 10
	mapwidth = 15
	windowheight = 160
	windowwidth = 240
	love.graphics.setMode(windowwidth,windowheight,false,false,0)
	--[[
		load save
		look at save
		start from save
		load tileset
		render world
		render NPCs
	--]]
end

function love.update()

end

function love.draw()
	for a = 1, #cT do -- draw the ground
		for b = 1, #cT[a] do
			love.graphics.drawq(tileset, quads[cT[a][b]], (b-1)*w,(a-1)*h)
		end
	end
end

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
function getMapData(file)
	rawMapFileData = {}
	for lines in love.filesystem.lines(file) do
		table.insert(rawMapFileData, lines)
	end
	for i = 1, #rawMapFileData do
		cT[i] = {}
		cT[i] = split(rawMapFileData[i], ",")
	end
end
---------------------------------------
function getSaveData()
	saveData = {}
	for lines in love.filesystem.lines(save.save) do
		table.insert(saveData, lines)
	end
end
---------------------------------------
function loadTileSetImage()
	tileset = love.graphics.newImage(saveData[1] .. " tileset.png")
end

---------------------------------------
function loadQuads()
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
