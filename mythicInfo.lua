---@diagnostic disable: undefined-field
print("mythicInfo loaded")

local _, core= ...;
local M = core.A;


local function FinallyGetSpec(partyMemberName)
    local currentSpec = GetSpecialization()
    local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
    return currentSpecName
end

-- party info loop
function M.GroupInfo()
    for _, v in pairs(M.PartyList) do        
        local ilvl = ("%.1f"):format(GetAverageItemLevel())
        local n = GetUnitName(v)
        local c = UnitClass(v)
        local s = FinallyGetSpec(v)
        return ilvl, n, c, s
    end    
end 

-- event listener fot testing purposes
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("CHAT_MSG_SAY")
EventFrame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
    local myCurrentName = UnitGUID('player')
    if event == "CHAT_MSG_SAY" and arg1 == "test" and arg2 ~= myCurrentName then
        print(M.GroupInfo())
    end
end)







-------------------------------------------------
-- --Player Clss info
-- localizedClass, englishClass, classIndex = UnitClass("unit");
-- u = "player"
-- print(strsplit(",", UnitClass(u), 1))
-- print("done")
--GetSpecialization() returns which spec number n
--GetSpecializationRole(n) returns role TANK HEAL DPS
--GetSpecializationInfo(n) - returned 581 on DH
--unitGUID
