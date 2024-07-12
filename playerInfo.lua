local _, ZUI = ...
local P = ZUI.A

local partyList = P.PartyList
local specList = P.SpecList

-- local function finallyGetSpec()
--     local _, _, classIndex = UnitClass("unit");
--     local specNum = GetSpecialization(classIndex)
-- end




-- party info loop
function GroupInfo()
    for _, v in pairs(partyList) do
        
        local ilvl = ("%.1f"):format(GetAverageItemLevel())
        local n = GetUnitName(v)
        local c = UnitClass(v)
  
        print(n .. "," .. ilvl)
    end
end

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("CHAT_MSG_SAY")
EventFrame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
    local myCurrentName = UnitGUID('player')
    if event == "CHAT_MSG_SAY" and arg1 == "test" and arg2 ~= myCurrentName then
        GroupInfo()
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
