--[[

BW-MORSE - Badwolf's own stupid script to stupidly convert chat into international morsecode. 
Why? Why not?

    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                    Version 2, December 2004 

 Copyright (C) 2014	Pilot <ricky@friendsconnect.nl>

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO.

--]]


morsecode = {
	["A"] = {" . - "      },
	["B"] = {" - . . . "  },
	["C"] = {" - . - . "   },
	["D"] = {" - . . "    },
	["E"] = {" . "        },
	["F"] = {" . . - . "  },
	["G"] = {" - - . "    },
	["H"] = {" . . . . "  },
	["I"] = {" . . "      },
	["J"] = {" . - - - "  },
	["K"] = {" - . - "    },
	["L"] = {" . - . . "  },
	["M"] = {" - - "      },
	["N"] = {" - . "      },
	["O"] = {" - - - "    },
	["P"] = {" . - - . "  },
	["Q"] = {" - - . - "  },
	["R"] = {" . - . "    },
	["S"] = {" . . . "    },
	["T"] = {" - "        },
	["U"] = {" . . - "    },
	["V"] = {" . . . - "  },
	["W"] = {" . - - "    },
	["X"] = {" - . . - "  },
	["Y"] = {" - . - - "  },
	["Z"] = {" - - . . "  },
	["1"] = {" . - - - - "},
	["2"] = {" . . - - - "},
	["3"] = {" . . . - - "},
	["4"] = {" . . . . - "},
	["5"] = {" . . . . . "},
	["6"] = {" - . . . . "},
	["7"] = {" - - . . . "},
	["8"] = {" - - - . . "},
	["9"] = {" - - - - . "},
	["0"] = {" - - - - - "},
	[" "] = {""},
}

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

function translateChatToMorse(message, messageType)
	cancelEvent()
	message = message:upper() -- easier than duplicating list twice for upper and lower case. 
	local ns = ""	-- newstring
	if messageType == 0 and isElement(source) then	-- Only do normal (global) chat at this moment and check if source is indeed an element.
		if #message ~= 0 then
			for i = 1, #message do
				local c = message:sub(i,i)
				if morsecode[c] == nil then
					c = " "..c.." "
					ns = ns..c
				else 
					ns = ns..morsecode[c][1]
				end
			end
			local r,g,b = getPlayerNametagColor(source)
			outputChatBox(getPlayerName(source)..": #ffffff"..ns,root, r,g,b, true)
		else
			outputDebugString("(len ns) => "..tonumber(#ns))
		end
	end
end