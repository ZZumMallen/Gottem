---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local addonName, core = ...;
local C = core.C;


GTTM_DB = GTTM_DB or {}
ZDB = GTTM_DB

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
    return UI --print("1-Menu Consturcor: Loaded")
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
    return UI.title --print("2-Menu Title Constructor: Loaded")
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
    return UI.BTN_PartyInfo --print("3-Button Constructor: Loaded")
end

function C:CreateButton2(xOffset, yOffset)
    UI.BTN_Test = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.BTN_Test:SetPoint("TOP", UI.BTN_PartyInfo, "BOTTOM", xOffset, yOffset);
    UI.BTN_Test:SetSize(140, 40);
    UI.BTN_Test:SetText("Test");
    UI.BTN_Test:SetNormalFontObject("GameFontNormal");
    UI.BTN_Test:SetHighlightFontObject("GameFontHighlight");
    UI.BTN_Test:SetScript("OnMouseDown", function() print("Test function placeholder") end)
    return UI.BTN_Test --print("3-Button Constructor: Loaded")
end

------------------------------------------------------------------------------
-- Check Box
------------------------------------------------------------------------------

function C:CreateCheckBox1() -- in_combat
    UI.CBX_Enable = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");    
    UI.CBX_Enable:SetPoint("TOPLEFT", BTN2, "BOTTOMLEFT", -3, -10);
    ---@diagnostic disable-next-line:param-type-mismatch
    UI.CBX_Enable:SetChecked(GTTM_DB["in_combat"]);    
    UI.CBX_Enable:SetScript("OnClick", function(self)
        GTTM_DB.in_combat = GTTM_DB.in_combat or {}
        GTTM_DB.in_combat = self:GetChecked();
        print("Check Box1 Registered:")end);   
    return UI.CBX_Enable --print("4-CheckBox Constructor: Loaded");
end

function C:CreateCheckBox2() -- popup_state
    UI.CBX_popup_state = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.CBX_popup_state:SetPoint("TOPLEFT", CBX_Enable, "BOTTOMLEFT", -0, -10);
    ---@diagnostic disable-next-line:param-type-mismatch
    UI.CBX_popup_state:SetChecked(GTTM_DB["popup_state"]);
    UI.CBX_popup_state:SetScript("OnClick", function(self)
        GTTM_DB.popup_state = GTTM_DB.popup_state or {}
        GTTM_DB.popup_state = self:GetChecked();
        print("Check Box2 Registered:")        end);
    return UI.CBX_popup_state --print("4.5-CheckBox Constructor: Loaded");
end

------------------------------------------------------------------------------
-- Check Box Label
------------------------------------------------------------------------------

function C:CreateCheckBoxLabel(CBX_label, boxLabel, parentBox)
    CBX_label = UI:CreateFontString(nil, "OVERLAY")
    CBX_label:SetPoint("LEFT", parentBox, "RIGHT", 10, 0);
    CBX_label:SetFontObject("GameFontNormal")
    CBX_label:SetText(boxLabel);
    return CBX_label --print("5-Checkbox Label Constructor: Loaded")
end

------------------------------------------------------------------------------
-- Create Main Menu Item Functions
------------------------------------------------------------------------------

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then

        if GTTM_DB["popup_state"] == true then print(arg1 .. ": " .. "Core Loaded") end

        -- Creates the menu--
        UI = C:CreateMenu(200, 250, 0, 0)
        MenuTitle = C:CreateMenuTitle(UI, "Gottem - Settings")

        -- Create Buttons --
        BTN1 = C:CreateButton1(0,-35)
        BTN2 = C:CreateButton2(0, -10)
        
        -- checkbox--
        CBX_Enable = C:CreateCheckBox1()
        CBX_Enable_Label = C:CreateCheckBoxLabel(UI.CBX_Enable_Label, "Enable", CBX_Enable)
        

        CBX_popup_state = C:CreateCheckBox2()
        CBX_popup_state_Label = C:CreateCheckBoxLabel(UI.CBX_popup_state_Label, "popup_state Mode", CBX_popup_state)
    end
end)


local previousWindow

function C:MakeMessageWindow()
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end

    MW = CreateFrame("frame", "windr---!", UIParent, "BasicFrameTemplateWithInset")
    MW:Hide()
    MW:SetSize(600, 60)
    MW:ClearAllPoints()
    MW:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "TOPLEFT", 0, 10)
    MW:EnableMouse(true);
    MW:SetMovable(true);
    MW:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
    MW:RegisterForDrag("LeftButton");
    MW:SetScript("OnDragStart", function(self) self:StartMoving() end);
    MW:Show()

    previousWindow = MW

    return MW
end


local previousText

function C:MakeText(text)
    if previousText then
        previousText:SetText("")
        previousText:Hide()
        PreviousText = nil
    end

    Cont = MW:CreateFontString(nil, "OVERLAY")      
    Cont:SetPoint("LEFT", MW, "LEFT", 15, -10);
    Cont:SetFontObject("GameFontGreenLarge")
    Cont:SetText(text)

    previousText = Cont

    return Cont
end

function C:HideMessage()
    local hyd = C:MakeMessageWindow()
    hyd:Hide()
    return hyd
end









------------------------------------------------------------------------------
-- Script Functions
------------------------------------------------------------------------------

-- toggles the main menu between show and hide
function C:Toggle()
    local menu = UI or C:CreateMenu();
    menu:SetShown(not menu:IsShown());
end

function C:MSG_hide()
    MW:Hide()
end




-- adds us to the special boy club so we can use escape
table.insert(UISpecialFrames, "core")





