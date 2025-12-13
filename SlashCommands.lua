-- SlashCommands.lua
local _, addon = ...
local U = addon.utils

SLASH_PBUI1 = "/pbui"
SlashCmdList["PBUI"] = function(msg)
  local command, arg = strsplit(" ", msg, 2)

  if command == "fontsize" and tonumber(arg) then
    local newSize = tonumber(arg)
    PetBattleUIPlusDB.fontSize = newSize
    if addon.NameResizer and addon.NameResizer.ResizePetNames then
      addon.NameResizer.ResizePetNames(newSize)
      U:Print("font size is set to: " .. "|cff00FF00" .. newSize .. "|r")
    else
      U:Print("use |cffFFFF00/pbui fontsize [number]|r")
    end
  elseif command == "hideframes" then
    if C_PetBattles.IsInBattle() and addon.FrameVisibility then
      addon.FrameVisibility.HideFramesForPetBattle()
      U:Print("frames are now: " .. "|cff00FF00hidden" .. "|r")
    else
      U:Print("command only works during a pet battle.")
    end
  elseif command == "showframes" then
    if C_PetBattles.IsInBattle() and addon.FrameVisibility then
      addon.FrameVisibility.ShowFramesAfterPetBattle()
      U:Print("frames are now: " .. "|cff00FF00visible" .. "|r")
    else
      U:Print("command only works during a pet battle.")
    end
  elseif command == "hidebags" then
    if arg == "on" then
      addon.UIElements.ToggleBags(true)
    elseif arg == "off" then
      addon.UIElements.ToggleBags(false)
    else
      U:Print("use |cffFFFF00/pbui hidebags [on|off]|r")
    end
  elseif command == "hidecooldowns" then
    if arg == "on" then
      PetBattleUIPlusDB.hideCooldowns = true
      if C_PetBattles.IsInBattle() then
        addon.CooldownViewer.HideForPetBattle()
        U:Print("cooldowns bars are now: " .. "|cff00FF00hidden" .. "|r")
      else
        U:Print("command only works during a pet battle.")
      end
    elseif arg == "off" then
      PetBattleUIPlusDB.hideCooldowns = false
      if C_PetBattles.IsInBattle() then
        addon.CooldownViewer.ShowAfterPetBattle()
        U:Print("cooldowns bars are now: " .. "|cff00FF00visible" .. "|r")
      else
       U:Print("command only works during a pet battle.")
      end
    else
      U:Print("use |cffFFFF00/pbui hidecooldowns [on|off]|r")
    end
  elseif command == "listframes" then
    U:Print("the managed frames are:")
    print("|cffFFFF00- PlayerFrame|r")
    print("|cffFFFF00- PartyFrame|r")
    print("|cffFFFF00- CompactRaidFrameContainer|r")
    print("|cffFFFF00- TargetFrame|r")
    print("|cffFFFF00- PetFrame (All classes with pets)|r")
    print("|cffFFFF00- Cooldown bars|r")
  else
    U:Print("options commands:")
    print("|cffFFFF00/pbui fontsize [number]|r - Set the font size for pet names.")
    print("|cffFFFF00/pbui hidebags [on|off]|r - Toggle bag visibility during pet battles.")
    print("|cffFFFF00/pbui hidecooldowns [on|off]|r - Toggle class cooldowns visibility during pet battles.")
    print("|cffFFFF00/pbui hideframes|r - Hide frames during the pet battle.")
    print("|cffFFFF00/pbui showframes|r - Show frames during the pet battle.")
    print("|cffFFFF00/pbui listframes|r - List all managed frames.")
  end
end
