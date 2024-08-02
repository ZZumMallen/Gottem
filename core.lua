---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local addonName, core = ...;
local C = core.A;

------------------------------------------------------------------------------
-- Slash Commands
------------------------------------------------------------------------------
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_ZUI1 = "/zui"
SlashCmdList["ZUI"] = function() C:Toggle() end;


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
    return UI 
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
    return UI.title 
end

------------------------------------------------------------------------------
-- Button - second one is unused
------------------------------------------------------------------------------
function C:CreateButton1(xOffset, yOffset)
    UI.BTN_PartyInfo = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.BTN_PartyInfo:SetPoint("TOP", UI, "TOP", xOffset, yOffset);
    UI.BTN_PartyInfo:SetSize(140, 40);
    UI.BTN_PartyInfo:SetText("I do nothing");
    UI.BTN_PartyInfo:SetNormalFontObject("GameFontNormal");
    UI.BTN_PartyInfo:SetHighlightFontObject("GameFontHighlight");
    UI.BTN_PartyInfo:SetScript("OnMouseDown", function() print("Party function placeholder") end)
    return UI.BTN_PartyInfo --print("3-Button Constructor: Loaded")
end

-- function C:CreateButton2(xOffset, yOffset) -- Unused
--     UI.BTN_Test = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
--     UI.BTN_Test:SetPoint("TOP", UI.BTN_PartyInfo, "BOTTOM", xOffset, yOffset);
--     UI.BTN_Test:SetSize(140, 40);
--     UI.BTN_Test:SetText("Test");
--     UI.BTN_Test:SetNormalFontObject("GameFontNormal");
--     UI.BTN_Test:SetHighlightFontObject("GameFontHighlight");
--     UI.BTN_Test:SetScript("OnMouseDown", function() print("Test function placeholder") end)
--     return UI.BTN_Test --print("3-Button Constructor: Loaded")
-- end

------------------------------------------------------------------------------
-- NPC Checkbox
------------------------------------------------------------------------------
function C:CreateCheckBox1()
    UI.CBX_NPC = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.CBX_NPC:SetPoint("TOPLEFT", BTN1, "BOTTOMLEFT", -3, -10);
    ---@diagnostic disable-next-line:param-type-mismatch --
    UI.CBX_NPC:SetChecked(GDDM_DB_OPTIONS["NPC"]);
    UI.CBX_NPC:SetScript("OnClick", function(self)        
        GDDM_DB_OPTIONS.NPC = self:GetChecked();
        print("NPCs", GDDM_DB_OPTIONS.NPC)
    end);
    return UI.CBX_NPC 
end

function C:CreateCheckBox2() -- Animals
    UI.CBX_Animal = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.CBX_Animal:SetPoint("TOPLEFT", CBX_NPC, "BOTTOMLEFT", -0, -10);
    ---@diagnostic disable-next-line:param-type-mismatch
    UI.CBX_Animal:SetChecked(GDDM_DB_OPTIONS["Animals"]);
    UI.CBX_Animal:SetScript("OnClick", function(self)        
        GDDM_DB_OPTIONS.Animals = self:GetChecked();
        print("Animals", GDDM_DB_OPTIONS.Animals)
    end);
    return UI.CBX_Animal --print("4.5-CheckBox Constructor: Loaded");
end

function C:CreateCheckBox3() -- Debug
    UI.CBX_Debug = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.CBX_Debug:SetPoint("TOPLEFT", CBX_ANIMALS, "BOTTOMLEFT", -0, -10);
    ---@diagnostic disable-next-line:param-type-mismatch
    UI.CBX_Debug:SetChecked(GDDM_DB_OPTIONS["Debug"]);
    UI.CBX_Debug:SetScript("OnClick", function(self)
        GDDM_DB_OPTIONS.Debug = self:GetChecked();
        print("Debug", GDDM_DB_OPTIONS.Debug)
    end);
    return UI.CBX_Debug --print("4.5-CheckBox Constructor: Loaded");
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
GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {}

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        
        GDDM_DB_OPTIONS.INIT = GDDM_DB_OPTIONS.INIT or {}
        GDDM_DB_OPTIONS.INIT = GetTime()
      
        -- Creates the menu--
        UI = C:CreateMenu(200, 250, 0, 0)
        MenuTitle = C:CreateMenuTitle(UI, "Gottem - Settings")

        -- Create Buttons --
        BTN1 = C:CreateButton1(0,-35)

        
        -- checkbox--
        CBX_NPC = C:CreateCheckBox1()
        CBX_NPC_Label = C:CreateCheckBoxLabel(UI.CBX_NPC_Label, "NPCS", CBX_NPC)
        

        CBX_ANIMALS = C:CreateCheckBox2()
        CBX_ANIMALS_Label = C:CreateCheckBoxLabel(UI.CBX_Animal_Label, "Animals", CBX_ANIMALS)

        CBX_DEBUG = C:CreateCheckBox3()
        CBX_DEBUG_LABEL = C:CreateCheckBoxLabel(UI.CBX_Debug_Label, "Debug", CBX_DEBUG) -- attachesd to box on previous line

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





