--[[
client.lua
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

gui = {
	toggled = false,
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    memo = {}
}
gui.index = gui

gui.window[1] = guiCreateWindow(0.31, 0.19, 0.39, 0.62, "Text to morsecode", true)
guiWindowSetMovable(gui.window[1], false)
guiWindowSetSizable(gui.window[1], false)

gui.staticimage[1] = guiCreateStaticImage(0.02, 0.05, 0.96, 0.13, "n2gHv98.png", true, gui.window[1])
gui.edit[1] = guiCreateEdit(0.02, 0.34, 0.68, 0.05, "", true, gui.window[1])
gui.label[1] = guiCreateLabel(0.20, 0.29, 0.32, 0.03, "TEXT", true, gui.window[1])
guiSetFont(gui.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(gui.label[1], "center", false)
guiLabelSetVerticalAlign(gui.label[1], "center")
gui.label[2] = guiCreateLabel(0.77, 0.35, 0.19, 0.04, "Multi-line", true, gui.window[1])
guiSetFont(gui.label[2], "default-bold-small")
guiLabelSetColor(gui.label[2], 235, 90, 33)
guiLabelSetHorizontalAlign(gui.label[2], "center", false)
guiLabelSetVerticalAlign(gui.label[2], "center")
gui.memo[1] = guiCreateMemo(0.02, 0.34, 0.73, 0.28, "", true, gui.window[1])
gui.memo[2] = guiCreateMemo(0.02, 0.70, 0.73, 0.28, "", true, gui.window[1])
gui.label[3] = guiCreateLabel(0.20, 0.65, 0.32, 0.03, "Morsecode", true, gui.window[1])
guiSetFont(gui.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(gui.label[3], "center", false)
guiLabelSetVerticalAlign(gui.label[3], "center")
gui.button[1] = guiCreateButton(410, 433, 110, 32, "Close", false, gui.window[1])
gui.button[2] = guiCreateButton(409, 391, 110, 32, "output", false, gui.window[1])
gui.button[3] = guiCreateButton(409, 349, 110, 32, "Translate", false, gui.window[1])

guiSetVisible(gui.memo[1], false)
guiSetFont(gui.memo[2], "default-bold-small")
guiSetVisible(gui.window[1], false)
guiMemoSetReadOnly(gui.memo[2],true)
guiSetInputMode("no_binds_when_editing") 


-- returns boolean depending on visibility of window[1]
function gui:isOpen()
	return guiGetVisible(self.window[1])
end

-- Toggles window open or closed.
function gui:toggle()
	local open = gui:isOpen()
	guiSetVisible(self.window[1], not open)
	showCursor(not open)
end

addEventHandler("onClientGUIClick", gui.button[1],
	function()
		gui:toggle()	-- Assuming that the gui is open when button is pressed, toggle the windows closed.
	end, false)

-- Retrieve translated morse code.
function gui:retrieveMorse(morse)
	if #morse ~= 0 or nil then
		guiSetText(self.memo[2], morse)
	end
end

-- Get the text box 1
function gui:getText()
	if gui.toggled == false or nil then
		return guiGetText(self.edit[1])
	else
		return guiGetText(self.memo[1])
	end
end

--[[
	When mouse hovers over label[2] then it changes color
--]]
addEventHandler("onClientMouseEnter", gui.label[2], 
	function()
		guiLabelSetColor(gui.label[2], 255, 255, 255)
	end,false)

addEventHandler("onClientMouseLeave", gui.label[2],
	function()
		guiLabelSetColor(gui.label[2], 235, 90, 33)
	end,false)

--[[
	Handles the textbox choice: Multiline or singleline
--]]
addEventHandler("onClientGUIClick", gui.label[2], 
	-- gui.toggled = false -> gui.edit[1] is visible
	function ()
		if gui.toggled == false or nil then
			guiSetText(gui.memo[1], guiGetText(gui.edit[1]))
			gui.toggled = true
			guiSetVisible(gui.edit[1], false)
			guiSetVisible(gui.memo[1], true)
			guiSetText(gui.label[2], "Single-Line")
		else
			guiSetText(gui.edit[1], guiGetText(gui.memo[1]))
			gui.toggled = false
			guiSetVisible(gui.edit[1], true)
			guiSetVisible(gui.memo[1], false)
			guiSetText(gui.label[2], "Multi-line")
		end
	end, false)

addEventHandler("onClientGUIClick", gui.button[3],
	function()
		gui:retrieveMorse(shared:translate(gui:getText()))
	end,false)

addEventHandler("onClientCharacter", getRootElement(), 
	function ()
		setTimer(
			function()
				local txt = gui:getText()
				if gui:isOpen() and #txt ~= 0 then 
					gui:retrieveMorse(shared:translate(gui:getText()))
				end
			end, 500, 2)

	end)

-- Use command instead and leave useful scripts binded.
addCommandHandler("morse", 
	function()
		gui:toggle()
	end)

addEventHandler("onClientGUIClick", gui.button[2], 
	function()
		gui:retrieveMorse(shared:translate(gui:getText()))
		setTimer(
			function()
				local morse = guiGetText(gui.memo[2])
				triggerServerEvent("server:output", localPlayer,morse)
			end,500,1)
	end,false)