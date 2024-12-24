-- Modules/FrameVisibility.lua
local addonName, addon = ...
addon.FrameVisibility = {}

-- Frame references
local frames = {
  PlayerFrame = PlayerFrame, -- Player frame
  PartyFrame = PartyFrame, -- Party frame when player is in a party
  CompactRaidFrameContainer = CompactRaidFrameContainer, -- Raid frame when player is in a raid
  TargetFrame = TargetFrame, -- Target frame when player has targeted something
  PetFrame = PetFrame -- Generic pet frame used by all pet classes
}

-- Table to store initial visibility states
local initialFrameStates = {}

-- Save initial visibility state of frames
local function SaveFrameStates()
  for frameType, frame in pairs(frames) do
    initialFrameStates[frameType] = frame:IsShown()
  end
end

-- Restore initial visibility state of frames
local function RestoreFrameStates()
  for frameType, frame in pairs(frames) do
    if initialFrameStates[frameType] then
      frame:Show()
    else
      frame:Hide()
    end
  end
end

-- Hide frames specifically for pet battles
function addon.FrameVisibility.HideFramesForPetBattle()
  SaveFrameStates()
  for _, frame in pairs(frames) do
    frame:Hide()
  end
  print("|cff00F300Pet Battle UI Plus: Frames hidden during pet battle.|r")
end

-- Show frames after pet battle ends
function addon.FrameVisibility.ShowFramesAfterPetBattle()
  RestoreFrameStates()
  print("|cff00F300Pet Battle UI Plus: Frames restored after pet battle.|r")
end