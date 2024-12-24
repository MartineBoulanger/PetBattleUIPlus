-- SlashCommands.lua
local addonName, addon = ...

SLASH_PBUI1 = "/pbui"
SlashCmdList["PBUI"] = function(msg)
  local command, arg = strsplit(" ", msg, 2)

  if command == "fontSize" and tonumber(arg) then
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

  elseif command == "listframes" then
    print("|cff3FC7EBFrames managed by Pet Battle UI Plus:|r")
    print("- PlayerFrame")
    print("- PartyFrame")
    print("- CompactRaidFrameContainer")
    print("- TargetFrame")
    print("- PetFrame (All classes with pets)")

  else
    print("|cff3FC7EBPet Battle UI Plus Commands:|r")
    print("|cffFFFF00/pbui fontsize [number]|r - Set the font size for pet names.")
    print("|cffFFFF00/pbui hideframes|r - Hide frames during a pet battle.")
    print("|cffFFFF00/pbui showframes|r - Show frames during a pet battle.")
    print("|cffFFFF00/pbui listframes|r - List all managed frames.")
  end
end