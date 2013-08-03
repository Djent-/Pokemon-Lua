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
function gameLoad()
	initializeMainTable(750, 550)
end
---------------------------------------
function gameUpdate()

end
---------------------------------------
function gameDraw() --for cutscenes, etc

end
--[[
	I really want to make a game class with Update and Draw as methods
	OOP is my weakness
--]]
