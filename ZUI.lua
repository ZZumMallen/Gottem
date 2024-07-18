---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local addonName, core = ...;
local C = core.C;


------------------------------------------------------------------------------
-- Slash Commands
------------------------------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_ZUI1 = "/zui"
SlashCmdList[addonName] = function() C:Toggle() end;

------------------------------------------------------------------------------
-- Builder Functions
------------------------------------------------------------------------------

function C:CreateMenu(menuWidth,menuHeight, menuPosX, meniPoxY)
    UI = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");    
    UI:EnableMouse(true);
    UI:SetSize(menuWidth, menuHeight);
    UI:SetPoint("CENTER", UIParent, "CENTER", menuPosX, meniPoxY);
    UI:SetMovable(true);
    UI:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
    UI:RegisterForDrag("LeftButton");
    UI:SetScript("OnDragStart", function(self) self:StartMoving() end);
    UI:Hide();
    return UI, print("CreateMenu loaded")
end

function C:CreateMenuTitle(UI, titleName)
    UI.title = UI:CreateFontString(nil, "OVERLAY");
    UI.title:SetFontObject("GameFontNormal");
    UI.title:SetPoint("LEFT", UI.TitleBg, "LEFT", 5, 0);
    UI.title:SetText(titleName);
    return UI.title, print("menu title loaded")
end

function C:CreateButton(UI, btnLabel, ownPoint, parent, relPoint, xOffset, yOffset)
    UI.startBtn = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.startBtn:SetPoint(ownPoint, parent, relPoint, xOffset, yOffset);
    UI.startBtn:SetSize(140, 40);
    UI.startBtn:SetText(btnLabel);
    UI.startBtn:SetNormalFontObject("GameFontNormal");
    UI.startBtn:SetHighlightFontObject("GameFontHighlight");
    UI.startBtn:SetScript("OnMouseDown", function() print(C.GroupInfo()) end)
    return UI.startBtn
end

function C:CreateCheckBox(UI, ownPoint, parent, relPoint, xOffset, yOffset)
    UI.cbx = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.cbx:SetPoint(ownPoint, parent, relPoint, xOffset, yOffset);
    UI.cbx:GetChecked();
    return UI.cbx
end

function C:CreateCheckBoxLable(UI, boxLabel, parentBox)
    UI.checkBoxLabel = UI:CreateFontString(nil,"OVERLAY")
    UI.checkBoxLabel:SetPoint("LEFT", parentBox, "RIGHT", 10, 0);
    UI.checkBoxLabel:SetFontObject("GameFontNormal")
    UI.checkBoxLabel:SetText(boxLabel);
    return UI.checkBoxLabel
end

------------------------------------------------------------------------------
-- Create Main Menu Item Functions
------------------------------------------------------------------------------

-- Creates the menu
UI = C:CreateMenu(200, 250, 0, 0)
MenuTitle = C:CreateMenuTitle(UI, "ZUI Menu")

-- Party Info Button
BTN1 = C:CreateButton(UI, "Party Info", "TOP", UI, "TOP", 0, -35)
UI.startBtn:SetScript("OnMouseDown", function() print(C.GroupInfo()) end)

-- Test Button to check the checkbutton state
BTN2 = C:CreateButton(UI, "Test","TOP", BTN1, "BOTTOM", 0, -10)

-- check button
LoadInCombat = C:CreateCheckBox(UI, "TOPLEFT", BTN2, "BOTTOMLEFT", -3, -10)
UI.startBtn:SetScript("OnMouseDown", function() C:IsChecked(UI) end)

--label for the checkbutton
CheckLabel = C:CreateCheckBoxLable(UI,"enable", UI.cbx)

------------------------------------------------------------------------------
-- Script Functions
------------------------------------------------------------------------------

-- returns true if checked, false of not checked
function C:IsChecked(UI)
    local state = UI.cbx:GetChecked()
    return print(state)
end

-- toggles the main menu between show and hide
function C:Toggle()
    local menu = UI or C:CreateMenu();
    menu:SetShown(not menu:IsShown());
end

-- adds us to the special boy club so we can use escape
table.insert(UISpecialFrames, "core")

-- local f = CreateFrame("FRAME")
-- f:RegisterEvent("PLAYER_LOGOUT")
-- f:SetScript("OnEvent", function(self, event,...)
--     if event == "PLAYER_LOGOUT" then
--         table.insert(ZUISavedData, IsChecked());
--         table.insert(ZUISavedData, 2);
--     end
-- end)




