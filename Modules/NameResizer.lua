local addonName, addon = ...
addon.NameResizer = {}

function addon.NameResizer.ResizePetNames(fontSize)
  fontSize = fontSize or 10 -- Fallback to default if no size is provided

  -- Adjust Player Pet Name
  local playerNameFrame = PetBattleFrame.ActiveAlly.Name
  if playerNameFrame then
    local font, _, flags = playerNameFrame:GetFont()
    playerNameFrame:SetFont(font, fontSize, flags)
  end

  -- Adjust Enemy Pet Name
  local enemyNameFrame = PetBattleFrame.ActiveEnemy.Name
  if enemyNameFrame then
    local font, _, flags = enemyNameFrame:GetFont()
    enemyNameFrame:SetFont(font, fontSize, flags)
  end
end