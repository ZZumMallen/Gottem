---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field

local _, core = ...;
local C = core.A;
local UI;

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_ZUI1 = "/zui"
SlashCmdList["ZUI"] = function() C:Toggle() end;

function C:CreateMenu()
    UI = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
    UI:Hide();
    UI:EnableMouse(true);
    UI:SetSize(200, 250);
    UI:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
    UI:SetMovable(true);
    UI:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
    UI:RegisterForDrag("LeftButton");
    UI:SetScript("OnDragStart", function(self) self:StartMoving() end);

    UI.title = UI:CreateFontString(nil, "OVERLAY");
    UI.title:SetFontObject("GameFontNormal");
    UI.title:SetPoint("LEFT", UI.TitleBg, "LEFT", 5, 0);
    UI.title:SetText("ZUI Options");

    UI.startBtn = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate");
    UI.startBtn:SetPoint("TOP", UI, "TOP", 0, -35);
    UI.startBtn:SetSize(140, 40);
    UI.startBtn:SetText("Get Party Info");
    UI.startBtn:SetNormalFontObject("GameFontNormal");
    UI.startBtn:SetHighlightFontObject("GameFontHighlight");
    UI.startBtn:SetScript("OnMouseDown", function() print(C.GroupInfo()) end)

    UI.cbx = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate");
    UI.cbx:SetPoint("TOPLEFT", UI.startBtn, "BOTTOMLEFT", -3, -10);

    UI.cbxText = UI:CreateFontString(nil,"OVERLAY")
    UI.cbxText:SetPoint("LEFT", UI.cbx, "RIGHT", 10, 0);
    UI.cbxText:SetFontObject("GameFontNormal")
    UI.cbxText:SetText("Enabled");

    return UI, print("UI Frame loaded")
end

table.insert(UISpecialFrames, "core")

function C:Toggle()
    print("Toggle triggered")
    local menu = UI or C:CreateMenu();
    menu:SetShown(not menu:IsShown());
end
