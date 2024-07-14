---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local _, ZUI = ...;
local C = ZUI.A

-- make the slash command
SLASH_ZUI1 = "/zui"
-- SLASH_ZUI2 = "/zz"

SLASH_RELOADUI1 = "/rl" -- quicker reloads
SlashCmdList.RELOADUI = ReloadUI

--Create The Main Form (UI)
local core = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
core:Hide()
core:EnableMouse(true)
core:SetSize(200, 250);
core:SetPoint("CENTER", UIParent, "CENTER", 750, 0)
core:SetMovable(true)
core:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
core:RegisterForDrag("LeftButton") 
core:SetScript("OnDragStart", function(self) self:StartMoving() end) 





-- this defines what you do with the slash command in reference to the acore
-- if you change "ZUI" to "zui" it will fail because the addon i ZUI
SlashCmdList["ZUI"] = function()
    if core:IsShown() then
        core:Hide()
    else
        core:Show()
    end
end

-- adds this frame to the table of imprtant fucntions that can close with the esc key
table.insert(UISpecialFrames, "core")

-- Function that makes buttons
function CreateButton(point, relativeFrame, relativePoint, yOffset, text)
    local btn = CreateFrame("Button", nil, core, "UIPanelButtonTemplate");
    btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
    btn:SetSize(140, 40);
    btn:SetText(text);
    btn:SetNormalFontObject("GameFontNormal")
    btn:SetHighlightFontObject("GameFontHighlight")
    return btn;
end

-- New Title Creator
function CreateTitle(NewTitle)
    local title = core:CreateFontString(nil, "OVERLAY");
    title:SetFontObject("GameFontNormal");
    title:SetPoint("LEFT", core.TitleBg, "LEFT", 5, 0);
    title:SetText(NewTitle);
    return title
end

-- point, relativeFrame, relativePoint, xOffset, yOffset

-- Title
local AppTitle = CreateTitle("ZUI M+ Thing")

-- Buttons
local startInfoBtn = CreateButton("CENTER", core, "TOP", -60, "Start Group Info")
startInfoBtn:SetScript("OnMouseDown", function(self, event) C.GroupInfo() end)

local stopInfoBtn = CreateButton("TOP", startInfoBtn, "BOTTOM", -10, "End Group Info")
stopInfoBtn:SetScript("OnMouseDown", function(self, event) C.GroupInfo() end)

-- Check Box and Text -----------------------------------------------------------
core.button = CreateFrame("CheckButton", nil, core, "UICheckButtonTemplate");
core.button:SetPoint("LEFT", stopInfoBtn, "LEFT", -3, -40);
core.button:SetText("Enable");

core.buttonText = core:CreateFontString(nil, "OVERLAY");
core.buttonText:SetFontObject("GameFontNormal");
core.buttonText:SetPoint("LEFT", core.button, "RIGHT", 5, 0);
core.buttonText:SetText("Enable Spotter");

---------------------------------------------------------------------------------














