-- SlashCommands.lua
local addonName, addon = ...

SLASH_PBUI1 = "/pbui"
SlashCmdList["PBUI"] = function(msg)
  local command, arg = strsplit(" ", msg, 2)

  if command == "fontsize" and tonumber(arg) then
    local newSize = tonumber(arg)
    PetBattleUIPlusDB.fontSize = newSize
    if addon.NameResizer and addon.NameResizer.ResizePetNames then
      addon.NameResizer.ResizePetNames(newSize)
    end
    print("|cff00F300Pet Battle UI Plus: Font size is set to " .. newSize .. "|r")

  elseif command == "hideframes" then
    if C_PetBattles.IsInBattle() and addon.FrameVisibility then
      addon.FrameVisibility.HideFramesForPetBattle()
    else
      print("|cffC41E3AThis command only works during a pet battle!|r")
    end

  elseif command == "showframes" then
    if C_PetBattles.IsInBattle() and addon.FrameVisibility then
      addon.FrameVisibility.ShowFramesAfterPetBattle()
    else
      print("|cffC41E3AThis command only works during a pet battle!|r")
    end

  elseif command == "hidebags" then
    if arg == "on" then
        addon.UIElements.ToggleBags(true)
    elseif arg == "off" then
        addon.UIElements.ToggleBags(false)
    else
        print("|cffFFFF00Usage: /pbui hidebags [on|off]|r")
    end

  elseif command == "hidecooldowns" then
    if arg == "on" then
        PetBattleUIPlusDB.hideCooldowns = true
        if C_PetBattles.IsInBattle() then
            addon.CooldownViewer.HideForPetBattle()
        end
    elseif arg == "off" then
        PetBattleUIPlusDB.hideCooldowns = false
        if C_PetBattles.IsInBattle() then
            addon.CooldownViewer.ShowAfterPetBattle()
        end
    else
        print("|cffFFFF00Usage: /pbui hidecooldowns [on|off]|r")
    end

  elseif command == "listframes" then
    print("|cff3FC7EBFrames managed by Pet Battle UI Plus:|r")
    print("- PlayerFrame")
    print("- PartyFrame")
    print("- CompactRaidFrameContainer")
    print("- TargetFrame")
    print("- PetFrame (All classes with pets)")
    print("- Class cooldown bars")

  else
    print("|cff3FC7EBPet Battle UI Plus Commands:|r")
    print("|cffFFFF00/pbui fontsize [number]|r - Set the font size for pet names.")
    print("|cffFFFF00/pbui hidebags [on|off]|r - Toggle bag visibility during pet battles.")
    print("|cffFFFF00/pbui hidecooldowns [on|off]|r - Toggle class cooldown visibility during pet battles.")
    print("|cffFFFF00/pbui hideframes|r - Hide frames during the pet battle.")
    print("|cffFFFF00/pbui showframes|r - Show frames during the pet battle.")
    print("|cffFFFF00/pbui listframes|r - List all managed frames.")
  end
end