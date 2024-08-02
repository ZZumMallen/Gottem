local addonName, core = ...
local T = core.A;


GDDM_MY_INFO = GDDM_MY_INFO or {}

GDDM_MY_INFO.POS = GDDM_MY_INFO.POS or {}
GDDM_MY_INFO.POS = {}

SLASH_TEST1 = "/zest"
SlashCmdList["zest"] = function() print("test") end;

GameMenuFrame:SetScale(0.6)
MinimapCluster:SetScale(0.75)

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        print("Addon Loaded")

        MovableFrame()

        end
    end)

function MovableFrame()
local UI = CreateFrame("Frame", "SaveLoc", UIParent, "BasicFrameTemplateWithInset")
    UI:SetSize(200, 200)
    UI:SetPoint("CENTER", UIParent, "CENTER", GDDM_MY_INFO.POS[1], GDDM_MY_INFO.POS[2])
    UI:EnableMouse(true)
    UI:SetMovable(true);
    UI:RegisterForDrag("LeftButton");
    UI:SetScript("OnDragStart", function(self) self:StartMoving() end);         
    UI:SetScript("OnDragStop", function(self)            
        self:StopMovingOrSizing()
        local _, _, _, xOfs, yOfs = UI:GetPoint()            
        -- DEFAULT_CHAT_FRAME:AddMessage(point)
        -- DEFAULT_CHAT_FRAME:AddMessage(relativeTo)
        DEFAULT_CHAT_FRAME:AddMessage(xOfs)
        DEFAULT_CHAT_FRAME:AddMessage(yOfs)
        GDDM_MY_INFO.POS = { xOfs, yOfs }
    end)
end
 


 

function CreatePanelButton(pte,rPte,x,y,w,h,text)
    UI.Btn = CreateFrame("BUTTON", nil, UI, "UIPanelButtonTemplate")
    UI.Btn:SetPoint(pte,UI,rPte,x,y)
    UI.Btn:SetSize(w,h)
    UI.Btn:SetText(text)
    UI.Btn:SetNormalFontObject("GameFontNormal");
    UI.Btn:SetHighlightFontObject("GameFontHighlight");
    return UI.Btn
end


-- function Util:displayTime(timeInSeconds)
--     local math = math
--     local days = math.floor(timeInSeconds / 86400)
--     local hours = math.floor(math.fmod(timeInSeconds, 86400) / 3600)
--     local minutes = math.floor(math.fmod(timeInSeconds, 3600) / 60)
--     local seconds = math.floor(math.fmod(timeInSeconds, 60))
--     return format("%dD:%2dHr:%2dMin", days, hours, minutes)
-- end






-- EventRegistry:RegisterCallback("PlayerSpellsFrame.SpellBookFrame.Show", function()
-- PlayerSpellsFrame:SetScale(0.6)
-- PlayerSpellsFrame:SetMovable(true);
-- PlayerSpellsFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
-- PlayerSpellsFrame:RegisterForDrag("LeftButton");
-- PlayerSpellsFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);





