---@diagnostic disable: undefined-field

SLASH_RELOADUI1 = "/rl" -- quicker reloads
SlashCmdList.RELOADUI = ReloadUI



----------------------------------------------------------------------------------------------------
-- NOTES
-- I would like to practice this app loading when entering a dungeon, then a mythic keystone dungeon
-- Loop through the party and get names

----------------------------------------------------------------------------------------------------


--Create The Form (UI)
local f = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
f:Hide()
f:SetSize(200, 250);
f:SetPoint("CENTER", UIParent, "CENTER", 750, 0)
f:SetMovable(true)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:RegisterForDrag("LeftButton") 
f:SetScript("OnDragStart", function(self) self:StartMoving() end) 


-- do de do do we do we do
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
    -- btn:SetScript("OnMouseDown", function()  end)
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


-- party list
local u = {
    "Player",
    "Party1",
    "Party2",
    "Party3",
    "Party4",
}

-- party info loop
function GroupInfo()
    for key, v in pairs(u) do    
        local n = GetUnitName(v)
        local c = UnitClass(v)
        print(key .. ",  " .. v .. ",  " .. n .. ",  " .. c)
    end
end


Jake_list = {
    "Whomptilizer",
    "Amelioration",
    "Gusthebus",
    "chungtesta",
    "Palmface",    
    "Sedition",
    "Jakeofcats",
    "lucilletwo",
    "cryinggame",
    "madys",
    "manimal",
    "Jacobcats",
    "Brownnote"
}


function Is_name_in_list(picked_name)
    for _, name in ipairs(Jake_list) do
        if name == picked_name then
            return true
        end
    end
    return false
end

C_ChatInfo.RegisterAddonMessagePrefix("ZUI-CHAT")

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_TARGET")

local lastSent = 0
local cooldown = 10

EventFrame:SetScript("OnEvent", function(self,event, ...)
    local currentTime = time()
    if currentTime - lastSent < cooldown then
        return
    end

    local jTarget = GetUnitName("Target")

    if event == "UNIT_TARGET" and Is_name_in_list(jTarget) then
        local class = strsplit(" ", UnitClass("Target"), 1)
        local message = "Character: ".. jTarget .." ("..class..")\n" ..
                        "When: " .. date() .. "\n" ..
                        "Where: " .. GetZoneText() .. " - " .. GetMinimapZoneText()
        C_ChatInfo.SendAddonMessage("ZUI-CHAT", message, "GUILD")
        lastSent = currentTime   
    end
end)
