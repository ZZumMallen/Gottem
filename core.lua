---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local addonName, core = ...;
local C = core.C;


ZUI_MYTHIC_DB = ZUI_MYTHIC_DB or {}
ZDB = ZUI_MYTHIC_DB

ZUI_MYTHIC_DB.STATE = ZUI_MYTHIC_DB.STATE or {}
ZUI_MYTHIC_DB.DEBUG = ZUI_MYTHIC_DB.DEBUG or {}

------------------------------------------------------------------------------
-- Slash Commands
------------------------------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_ZUI1 = "/zui"
SlashCmdList[addonName] = function() C:Toggle() end;

------------------------------------------------------------------------------
-- Window
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
    return UI, print("1-Menu Consturcor: Loaded")
end

------------------------------------------------------------------------------
-- Window Title
------------------------------------------------------------------------------
---@param UI table
function C:CreateMenuTitle(UI, titleName)
    UI.title = UI:CreateFontString(nil, "OVERLAY");
    UI.title:SetFontObject("GameFontNormal");
    UI.title:SetPoint("LEFT", UI.TitleBg, "LEFT", 5, 0);
    UI.title:SetText(titleName);
    return UI.title, print("2-Menu Title Constructor: Loaded")
end

------------------------------------------------------------------------------
-- Button
------------------------------------------------------------------------------

function C:CreateButton1(xOffset, yOffset)
    UI.BTN_PartyInfo = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.BTN_PartyInfo:SetPoint("TOP", UI, "TOP", xOffset, yOffset);
    UI.BTN_PartyInfo:SetSize(140, 40);
    UI.BTN_PartyInfo:SetText("Party Info");
    UI.BTN_PartyInfo:SetNormalFontObject("GameFontNormal");
    UI.BTN_PartyInfo:SetHighlightFontObject("GameFontHighlight");
    UI.BTN_PartyInfo:SetScript("OnMouseDown", function() print("Party function placeholder") end)
    return UI.BTN_PartyInfo, print("3-Button Constructor: Loaded")
end

function C:CreateButton2(xOffset, yOffset)
    UI.BTN_Test = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.BTN_Test:SetPoint("TOP", UI.BTN_PartyInfo, "BOTTOM", xOffset, yOffset);
    UI.BTN_Test:SetSize(140, 40);
    UI.BTN_Test:SetText("Test");
    UI.BTN_Test:SetNormalFontObject("GameFontNormal");
    UI.BTN_Test:SetHighlightFontObject("GameFontHighlight");
    UI.BTN_Test:SetScript("OnMouseDown", function() print("Test function placeholder") end)
    return UI.BTN_Test, print("3-Button Constructor: Loaded")
end

------------------------------------------------------------------------------
-- Check Box
------------------------------------------------------------------------------

function C:CreateCheckBox1() -- State
    UI.CBX_Enable = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");    
    UI.CBX_Enable:SetPoint("TOPLEFT", BTN2, "BOTTOMLEFT", -3, -10);
    UI.CBX_Enable:SetChecked(ZUI_MYTHIC_DB["STATE"]);    
    UI.CBX_Enable:SetScript("OnClick", function(self)
        ZUI_MYTHIC_DB.STATE = self:GetChecked();
        print("Check Box1 Registered:")end);   
    return UI.CBX_Enable, print("4-CheckBox Constructor: Loaded");
end

function C:CreateCheckBox2() -- Debug
    UI.CBX_Debug = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.CBX_Debug:SetPoint("TOPLEFT", CBX_Enable, "BOTTOMLEFT", -0, -10);
    UI.CBX_Debug:SetChecked(ZUI_MYTHIC_DB["DEBUG"]);
    UI.CBX_Debug:SetScript("OnClick", function(self)
        ZUI_MYTHIC_DB.DEBUG = ZUI_MYTHIC_DB.DEBUG or {}
        ZUI_MYTHIC_DB.DEBUG = self:GetChecked();
        print("Check Box2 Registered:")        end);
    return UI.CBX_Debug, print("4.5-CheckBox Constructor: Loaded");
end

------------------------------------------------------------------------------
-- Check Box Label
------------------------------------------------------------------------------

function C:CreateCheckBoxLabel(CBX_label, boxLabel, parentBox)
    CBX_label = UI:CreateFontString(nil, "OVERLAY")
    CBX_label:SetPoint("LEFT", parentBox, "RIGHT", 10, 0);
    CBX_label:SetFontObject("GameFontNormal")
    CBX_label:SetText(boxLabel);
    return CBX_label, print("5-Checkbox Label Constructor: Loaded")
end

------------------------------------------------------------------------------
-- Create Main Menu Item Functions
------------------------------------------------------------------------------

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then

        print("Addons Loaded".." - "..arg1)

        -- Creates the menu--
        UI = C:CreateMenu(200, 250, 0, 0)
        MenuTitle = C:CreateMenuTitle(UI, "ZUI Menu")

        -- Create Buttons --
        BTN1 = C:CreateButton1(0,-35)
        BTN2 = C:CreateButton2(0, -10)
        
        -- checkbox--
        CBX_Enable = C:CreateCheckBox1()
        CBX_Enable_Label = C:CreateCheckBoxLabel(UI.CBX_Enable_Label, "Enable", CBX_Enable)
        

        CBX_Debug = C:CreateCheckBox2()
        CBX_DEBUG_Label = C:CreateCheckBoxLabel(UI.CBX_Debug_Label, "Debug Mode", CBX_Debug)
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





