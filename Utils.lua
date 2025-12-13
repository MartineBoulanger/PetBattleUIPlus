local _, addon = ...

addon.utils = addon.utils or {}
local Utils = addon.utils

Utils.printPrefix = "|cff3FC7EB[PBUI]|r:"

function Utils:Print(...)
  print(self.printPrefix, ...)
end

function Utils:InitializeSavedVariables()
  if not PetBattleUIPlusDB then
    PetBattleUIPlusDB = {
      fontSize = 10,        -- Default font size for pet names
      hideBags = true,      -- Default: Bags are hidden during pet battles
      hideCooldowns = true, -- Default: Class cooldowns are hidden during pet battles
    }
  end
end
