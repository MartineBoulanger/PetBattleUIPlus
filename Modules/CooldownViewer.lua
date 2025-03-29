-- Modules/CooldownViewer.lua
local addonName, addon = ...
addon.CooldownViewer = {}

-- Frame references
local CooldownFrames = {
    Essential = EssentialCooldownViewer,
    Utility = UtilityCooldownViewer,
    TrackedBuff = TrackedBuffCooldownViewer,
    TrackedBar = TrackedBarCooldownViewer
}

-- Table to store initial visibility states
local initialStates = {}

--- SAVE FRAME STATES ---
local function SaveCooldownFrameStates()
    initialStates = {}
    for name, frame in pairs(CooldownFrames) do
        if frame and frame.IsShown then
            initialStates[name] = frame:IsShown()
        end
    end
end

--- RESTORE FRAME STATES ---
local function RestoreCooldownFrameStates()
    for name, frame in pairs(CooldownFrames) do
        if frame and initialStates[name] ~= nil then
            if initialStates[name] then
                frame:Show()
            else
                frame:Hide()
            end
        end
    end
end

--- HIDE COOLDOWN FRAMES FOR PET BATTLE ---
function addon.CooldownViewer.HideForPetBattle()
    SaveCooldownFrameStates()
    if PetBattleUIPlusDB.hideCooldowns then
        for _, frame in pairs(CooldownFrames) do
            if frame and frame.Hide then
                frame:Hide()
            end
        end
        print("|cff00F300Pet Battle UI Plus: Class Cooldowns frames hidden during pet battle.|r")
    end
end

--- SHOW COOLDOWN FRAMES AFTER PET BATTLE ---
function addon.CooldownViewer.ShowAfterPetBattle()
    RestoreCooldownFrameStates()
    print("|cff00F300Pet Battle UI Plus: Class Cooldowns frames restored after pet battle.|r")
end