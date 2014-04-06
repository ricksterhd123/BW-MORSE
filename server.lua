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

addCommandHandler("morsechat",
	function(source)
		if getElementData(source, "bw-morse.trans") == false then
			addEventHandler("onPlayerChat", source, translateChatToMorse)
			setElementData(source, "bw-morse.trans", true)
		else 
			removeEventHandler("onPlayerChat", source, translateChatToMorse)
			setElementData(source, "bw-morse.trans", false)
		end
	end)

--[[
	Translate string into international morsecode.
	Unknown characters are given even spacing.
--]]
function server:translate(message)
	message = message:upper() -- easier than duplicating list twice for upper and lower case. 
	local ns = ""	-- newstring
	if #message ~= 0 then	-- redundancy 
		for i = 1, #message do
			local c = message:sub(i,i)
			if morsecode[c] == nil then
				-- Give it even spacing like morsecode table.
				c = " "..c.." "	
				ns = ns..c
			else 
				ns = ns..morsecode[c][1]
			end
		end
		return ns
	else
		outputDebugString("(len ns) => "..tostring(#ns))
		return false
	end
end

addEvent("server:translate", true)
addEventHandler("server:translate", getRootElement(), 
	function(message)
		if #message ~= 0 or nil then
			local morse = server:translate(message)
			if morse ~= false then
				triggerClientEvent(source,"gui:retrieveMorse", getRootElement(), morse)
			end
		else
			outputDebugString("(eq message) => "..tostring(message))
		end
	end)

--[[
	Function is called on player chat. 
	message => String with chat
	type => 0 - global chat. (Only chat at the moment.)
--]]
function translateChatToMorse(message, type, morse)
	local r,g,b = getPlayerNametagColor(source)
	if type == 0 and morse == false then
		outputChatBox(getPlayerName(source)..": #ffffff"..server:translate(message),root, r,g,b, true)
	elseif type == 0 then
		outputChatBox(getPlayerName(source)..": #ffffff"..message,root, r,g,b, true)
	end
end

addEvent("server:output", true)
addEventHandler("server:output", getRootElement(), 
	function(message)
		if #message ~= 0 or nil then
			local type, morse = 0, true
			translateChatToMorse(message, type, morse)
		end
	end)