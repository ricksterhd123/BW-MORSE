--[[
shared.lua
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

morsecode = {
	["A"] = {" . - "      },
	["B"] = {" - . . . "  },
	["C"] = {" - . - . "  },
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
	[" "] = {" / "},
	["."] = {""},
}

shared = {}
shared.index = shared 
--[[
	Translate string into international morsecode.
	Unknown characters are given even spacing.
--]]
function shared:translate(message)
	message = message:upper() -- easier than duplicating list twice for upper and lower case. 
	local ns = ""	-- newstring
	if #message ~= 0 then	-- redundancy 
		for i = 1, #message do
			-- Iterate through string. 
			local c = message:sub(i,i):gsub("'" , "")
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