local _, ZUI = ...;
local f = ZUI.A


---@diagnostic disable: undefined-field

SLASH_RELOADUI1 = "/rl" -- quicker reloads
SlashCmdList.RELOADUI = ReloadUI


--Create The Form (UI)
f = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
f:Hide()
f:SetSize(200, 250);
f:SetPoint("CENTER", UIParent, "CENTER", 750, 0)
f:SetMovable(true)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:RegisterForDrag("LeftButton") 
f:SetScript("OnDragStart", function(self) self:StartMoving() end) 

-- make the slash command
SLASH_ZUI1 = "/zui"
SlashCmdList["ZUI"] = function()
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end


table.insert(UISpecialFrames, "f")

-- Function that makes buttons
function CreateButton(point, relativeFrame, relativePoint, yOffset, text)
    local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate");
    btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
    btn:SetSize(140, 40);
    btn:SetText(text);
    btn:SetNormalFontObject("GameFontNormal")
    btn:SetHighlightFontObject("GameFontHighlight")
    return btn;
end

-- New Title Creator
function CreateTitle(NewTitle)
    local t = f:CreateFontString(nil, "OVERLAY");
    t:SetFontObject("GameFontNormal");
    t:SetPoint("LEFT", f.TitleBg, "LEFT", 5, 0);
    t:SetText(NewTitle);
    return t
end

-- Title
local AppTitle = CreateTitle("ZUI")

-- Buttons
local sBtn = CreateButton("CENTER", f, "TOP", -70, "Group Info")
sBtn:SetScript("OnMouseDown", function() GroupInfo() end)


-- local rBtn = CreateButton("TOP", sBtn, "BOTTOM", -10, "I see Jake")

-- local gBtn = CreateButton("TOP", rBtn, "BOTTOM", -10, "Group Ino")

















