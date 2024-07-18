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

---@param UI frame
function C:CreateMenuTitle(UI, titleName)
    UI.title = UI:CreateFontString(nil, "OVERLAY");
    UI.title:SetFontObject("GameFontNormal");
    UI.title:SetPoint("LEFT", UI.TitleBg, "LEFT", 5, 0);
    UI.title:SetText(titleName);
    return UI.title, print("menu title loaded")
end

---@param UI frame
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

---@param UI frame
function C:CreateCheckBox(UI, ownPoint, parent, relPoint, xOffset, yOffset)
    UI.cbx = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.cbx:SetPoint(ownPoint, parent, relPoint, xOffset, yOffset);
    return UI.cbx
end

---@param UI frame
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

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        ZUI_MYTHIC_DB = ZUI_MYTHIC_DB or {}
        ZDB = ZUI_MYTHIC_DB
        
        ---@diagnostic disable: param-type-mismatch

        -- Creates the menu
        UI = C:CreateMenu(200, 250, 0, 0)
        MenuTitle = C:CreateMenuTitle(UI, "ZUI Menu")

        -- Party Info Button
        BTN1 = C:CreateButton(UI, "Party Info", "TOP", UI, "TOP", 0, -35)
        UI.startBtn:SetScript("OnMouseDown", function() print(C.GroupInfo()) end)

        -- Test Button to check the checkbutton state
        BTN2 = C:CreateButton(UI, "Test", "TOP", BTN1, "BOTTOM", 0, -10)

        -- checkbox
        LoadInCombat = C:CreateCheckBox(UI, "TOPLEFT", BTN2, "BOTTOMLEFT", -3, -10)
        UI.cbx:SetChecked(ZDB["STATE"])
        UI.cbx:SetScript("OnClick", function(self)
            ZDB.STATE = ZDB.STATE or {}
            ZDB.STATE = self:GetChecked();
            end)
        --label for the checkbutton
        CheckLabel = C:CreateCheckBoxLable(UI, "enable", UI.cbx)
    end
end)

------------------------------------------------------------------------------
-- Script Functions
------------------------------------------------------------------------------



-- toggles the main menu between show and hide
function C:Toggle()
    local menu = UI or C:CreateMenu();
    menu:SetShown(not menu:IsShown());
end

-- adds us to the special boy club so we can use escape
table.insert(UISpecialFrames, "core")

local j = CreateFrame("FRAME")
j:RegisterEvent("PLAYER_LOGOUT")
j:SetScript("OnEvent", function(self, event,...)
    if event == "PLAYER_LOGOUT" then
        ZDB.DUNGEON = ZDB.DUNGEON or {};
        ZDB.DUNGEON = "Tractor Pull"
    end
end)




