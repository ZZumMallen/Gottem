---@diagnostic disable: undefined-field

SLASH_RELOADUI1 = "/rl" -- quicker reloads
SlashCmdList.RELOADUI = ReloadUI


-- SLASH_FRAMESTK1 = "/fs"
-- SlashCmdList.FRAMESTK = function()
--     --LoadAddOn('Blizzard_DebugTools')
--     FrameStackTooltip_Toggle()
-- end

for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
end

----------------------------------------------------------------------------------------------------
-- NOTES
-- I would like to practice this app loading when entering a dungeon, then a mythic keystone dungeon
-- Loop through the party and get names

----------------------------------------------------------------------------------------------------


--Create The Form (UI)
local f = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
f:SetSize(300, 500);
f:SetPoint("CENTER", UIParent, "CENTER", 500, 0)

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
f:RegisterEvent("PLAYER_LOGOUT")

f:SetScript("OnEvent", function(self, event)
    if event == "UPDATE_MOUSEOVER_UNIT" then        
        pfx()
    end
end)




-- Define your functions
function GetUnitName(u)
    return "Name: " .. u
end

function UnitClass(u)
    return "Class: " .. u
end

-- array storage
