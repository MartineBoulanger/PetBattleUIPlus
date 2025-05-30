-- Main.lua
local addonName, addon = ...
_G[addonName] = addon

-- Saved Variable Initialization
local function InitializeSavedVariables()
  if not PetBattleUIPlusDB then
    PetBattleUIPlusDB = {
      fontSize = 10, -- Default font size for pet names
      hideBags = true, -- Default: Bags are hidden during pet battles
      hideCooldowns = true, -- Default: Class cooldowns are hidden during pet battles
    }
  end
end

-- Event Handler
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PET_BATTLE_OPENING_START")
frame:RegisterEvent("PET_BATTLE_CLOSE")

frame:SetScript("OnEvent", function(self, event, loadedAddon)
  if event == "ADDON_LOADED" and loadedAddon == addonName then
    InitializeSavedVariables()
    print("|cff3FC7EB" .. addonName .. "|r loaded. Type |cffFFFF00/pbui|r for options.")

  elseif event == "PET_BATTLE_OPENING_START" then
    if addon.FrameVisibility then
      addon.FrameVisibility.HideFramesForPetBattle()
    end
    if addon.UIElements then
      addon.UIElements.HideElementsForPetBattle()
    end
    if addon.NameResizer and addon.NameResizer.ResizePetNames then
      addon.NameResizer.ResizePetNames(PetBattleUIPlusDB.fontSize)
    end
    if addon.CooldownViewer then
      addon.CooldownViewer.HideForPetBattle()
    end

  elseif event == "PET_BATTLE_CLOSE" then
    if addon.FrameVisibility then
      addon.FrameVisibility.ShowFramesAfterPetBattle()
    end
    if addon.UIElements then
      addon.UIElements.ShowElementsAfterPetBattle()
    end
    if addon.CooldownViewer then
      addon.CooldownViewer.ShowAfterPetBattle()
    end

  end
end)