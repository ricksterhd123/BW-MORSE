--[[
server.lua
BW-MORSE - Badwolf's own script to convert chat into international morsecode. 

    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 

 Copyright (C) 2014	Pilot <ricky@friendsconnect.nl>

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO.

--]]

server = {}
server.index = server



--[[
	Output morsecode.
--]]
function server:output(message)
	if #message ~= 0 and isElement(source) then
		local r,g,b = getPlayerNametagColor(source)
		if #message < 121 then
			outputChatBox(getPlayerName(source)..": #ffffff"..message,root, r,g,b, true)
		else
			outputChatBox("To many characters!", source, 255,0,0, false)
		end
	end
end

addEvent("server:output", true)
addEventHandler("server:output", getRootElement(), 
	function(message)
		if #message ~= 0 or nil then
			server:output(message)
		end
	end)