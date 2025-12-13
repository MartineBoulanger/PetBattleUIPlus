local _, addon = ...
local U = addon.utils
addon.UIElements = {}

-- Frame references
local UIFrames = {
    QueueButton = QueueStatusMinimapButton,    -- Instance Queue Button
    Bags = {
        Backpack = MainMenuBarBackpackButton,  -- Backpack Button
        ReagentBag = CharacterReagentBag0Slot, -- Reagent Bag Button
        Bag1 = CharacterBag0Slot,              -- First Bag Slot
        Bag2 = CharacterBag1Slot,              -- Second Bag Slot
        Bag3 = CharacterBag2Slot,              -- Third Bag Slot
        Bag4 = CharacterBag3Slot,              -- Fourth Bag Slot
        ExpandToggle = BagBarExpandToggle      -- The arrow button
    }
}

-- Table to store initial visibility states
local initialStates = {}

--- SAVE FRAME STATES ---
local function SaveUIFrameStates()
    -- Save Queue Button State
    if UIFrames.QueueButton then
        initialStates.QueueButton = UIFrames.QueueButton:IsShown()
    end

    -- Save Bag States
    initialStates.Bags = {}
    for name, bag in pairs(UIFrames.Bags) do
        if bag and bag:IsShown() ~= nil then
            initialStates.Bags[name] = bag:IsShown()
        end
    end
end

--- RESTORE FRAME STATES ---
local function RestoreUIFrameStates()
    -- Restore Queue Button
    if UIFrames.QueueButton and initialStates.QueueButton ~= nil then
        if initialStates.QueueButton then
            UIFrames.QueueButton:Show()
        else
            UIFrames.QueueButton:Hide()
        end
    end

    -- Restore Bag States
    for name, bag in pairs(UIFrames.Bags) do
        if bag and initialStates.Bags[name] ~= nil then
            if initialStates.Bags[name] then
                bag:Show()
            else
                bag:Hide()
            end
        end
    end
end

--- HIDE QUEUE BUTTON AUTOMATICALLY ---
function addon.UIElements.HideQueueButton()
    if UIFrames.QueueButton then
        UIFrames.QueueButton:Hide()
    end
end

--- RESTORE QUEUE BUTTON AUTOMATICALLY ---
function addon.UIElements.ShowQueueButton()
    if UIFrames.QueueButton then
        UIFrames.QueueButton:Show()
    end
end

--- SAFE HIDE FOR BAG FRAMES ---
local function SafeHideBagFrame(frame)
    if frame and frame:IsVisible() then
        frame:SetAlpha(0) -- Make it invisible instead of hiding directly
        C_Timer.After(0.1, function()
            if frame:IsVisible() then
                frame:Hide()
            end
        end)
    end
end

--- HIDE BAG FRAME ---
function addon.UIElements.HideBags()
    -- Check if we're in combat or pet battle
    if InCombatLockdown() then
        return
    end

    for _, bag in pairs(UIFrames.Bags) do
        SafeHideBagFrame(bag)
    end

    -- Bypass UpdateNewItemList errors
    if ContainerFrameCombinedBags and ContainerFrameCombinedBags:IsVisible() then
        ContainerFrameCombinedBags:SetScript("OnHide", nil)
    end
end

--- SHOW BAG FRAME ---
function addon.UIElements.ShowBags()
    if InCombatLockdown() then
        return
    end

    for _, bag in pairs(UIFrames.Bags) do
        if bag then
            bag:SetAlpha(1)
            bag:Show()
        end
    end

    -- Restore the default OnHide script
    if ContainerFrameCombinedBags then
        ContainerFrameCombinedBags:SetScript("OnHide", ContainerFrame_OnHide)
    end
end

--- SAFELY TOGGLE BAG VISIBILITY ---
function addon.UIElements.ToggleBags(shouldHide)
    if InCombatLockdown() then
        U:Print("cannot toggle bags during combat.")
        return
    end

    -- Defer execution slightly to avoid frame access conflicts
    C_Timer.After(0.1, function()
        if C_PetBattles.IsInBattle() then
            if shouldHide == nil then
                shouldHide = not PetBattleUIPlusDB.hideBags -- Toggle if no specific state given
            end

            PetBattleUIPlusDB.hideBags = shouldHide

            if shouldHide then
                addon.UIElements.HideBags()
            else
                addon.UIElements.ShowBags()
            end

            U:Print("bags are now: " .. "|cff00FF00" .. (shouldHide and "hidden" or "visible") .. "|r")
        else
            U:Print("command only works during a pet battle.")
        end
    end)
end

--- HIDE ELEMENTS FOR PET BATTLE ---
function addon.UIElements.HideElementsForPetBattle()
    SaveUIFrameStates()
    addon.UIElements.HideQueueButton()

    if PetBattleUIPlusDB.hideBags then
        addon.UIElements.HideBags()
    end
end

--- RESTORE ELEMENTS AFTER PET BATTLE ---
function addon.UIElements.ShowElementsAfterPetBattle()
    RestoreUIFrameStates()
end
