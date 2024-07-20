---@diagnostic disable: undefined-field

local addonName, core = ...;
local M = core.C;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1,...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        if ZUI_MYTHIC_DB["DEBUG"] == true then print(arg1 .. ": " .. "Party Info Loaded") end;
        if not M.PartyList then M.PartyList = {} end
            if not ZUI_MYTHIC_PARTY3 then ZUI_MYTHIC_PARTY3 = {} end
                if not ZUI_MYTHIC_PARTY3.PARTY then ZUI_MYTHIC_PARTY3.PARTY = {} end
                    for i = 1, 5 do
                        ZUI_MYTHIC_PARTY3.PARTY[M.PartyList[i]] = {}
                        -- local name = GetUnitName(M.PartyList[i])
                        -- local class = UnitClass(M.PartyList[i])
                        for j = 1,3 do
                            if j == 1 then
                                ZUI_MYTHIC_PARTY3.PARTY[M.PartyList[i]][j] = GetTime()
                            else if j == 2 then
                                ZUI_MYTHIC_PARTY3.PARTY[M.PartyList[i]][j] = GetUnitName(M.PartyList[i])
                            else if j == 3 then
                                ZUI_MYTHIC_PARTY3.PARTY[M.PartyList[i]][j] = UnitClass(M.PartyList[i])
                            end
                        end
                    end
                end
            end
        end
    end)


local j = CreateFrame("FRAME")
j:RegisterEvent("PLAYER_LOGOUT")
j:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGOUT" then
        ZDB.DUNGEON = ZDB.DUNGEON or {};
        ZDB.DUNGEON = "Dungeon Name Goes here"
    end
end)
----------------------------------------------------------------

--= M.PartyList[i]
-- -- event listener fot testing purposes
-- local EventFrame = CreateFrame("frame", "EventFrame")
-- EventFrame:RegisterEvent("CHAT_MSG_SAY")
-- EventFrame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
--     local myCurrentName = UnitGUID('player')
--     if event == "CHAT_MSG_SAY" and arg1 == "test" and arg2 ~= myCurrentName then
--         print(M.GroupInfo())
--     end
-- end)

-- Class = UnitClass(v)

-- for j = 1,2 do
--     MDB.PLAYER[M.PartyList[m]][j] = Class
-- end

-- for m = 1, 5 do
--     MDB.PLAYER[M.PartyList[m]] = {}
