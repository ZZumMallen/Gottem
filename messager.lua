local addonName, core = ...
local G = core.A

G.triggerPrefix = "ope_gottem"
G.sendPrefix = "gottem_send"

GDDM_DB_MSG = GDDM_DB_MSG or {} -- shorten do GDm
GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {} -- shorten to GDO
GDDM_DB_OPTIONS.NPC = GDDM_DB_OPTIONS.NPC or {}
GDDM_DB_OPTIONS.Debug = GDDM_DB_OPTIONS.Debug or false
GDDM_DB_OPTIONS.Animals = GDDM_DB_OPTIONS.Animals or {}
GDDM_DB_MSG.History = GDDM_DB_MSG.History or {}

local debug = GDDM_DB_OPTIONS.Debug

local AceComm = LibStub("AceComm-3.0")
local Callback = LibStub("CallbackHandler-1.0")

SLASH_GOTTEM1 = "/gottem"
SlashCmdList["GOTTEM"] = function() Verify_Target_In_List() end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, ...)      
    if event == "ADDON_LOADED" and arg1 == addonName then
-------------------------------------------------------------
-- Respect the event loop
-------------------------------------------------------------
        function Verify_Target_In_List()
            local X = GetUnitName("Target")
            local T = "Target"

            if IsNil(X) then -- stops the party if nothing is targetted
                return
            end

            if InList(X) then -- 
                G.GetInfo(X)
                return
            elseif
                IsPlayer(T) then
                return
            elseif
                WhatIsIt() then
                return
            end
        end
-------------------------------------------------------------
-- Respect the event loop
-------------------------------------------------------------
    end
end)







-------------------------------------------------------------
-- Funkytown
-------------------------------------------------------------
function G.GetInfo(X)
    ---@class mapID:number
    local mapID = C_Map.GetBestMapForUnit(X)
    local pos = C_Map.GetPlayerMapPosition(mapID, X);

    if pos == nil then
        ---@class locX:number
        ---@class locY:number
        G.locX = 0
        G.locY = 0
        return
    else
        ---@class locX:number
        ---@class locY:number
        G.locX = math.ceil(pos.x * 10000) / 100
        G.locY = math.ceil(pos.y * 10000) / 100
    end

    if GetZoneText() == GetMinimapZoneText() then
        ---@type string
        G.locName = GetZoneText()
    else
        ---@type string
        G.locName = GetMinimapZoneText() .. ", " .. GetZoneText()
    end
    
    
    print(G.locName, G.locX, G.locY)

    -- print(tostring(G.locName)) also works but why
end


function IsNil(X)
    if X == nil then
        print("IsNil: true")
        return true
    else 
        print("IsNil: false")
        return false
    end
end

function InList(X)
    local found = true
    for _, j in ipairs(G.tList) do
        if j == X then 
            print(j,X)
            found = true
            print("InList: True")
            return true
        end
    end
    if not found then
        print("InList: false")
        return false
    end
end
        
function IsPlayer(T)
    if UnitIsPlayer(T) then
        print("IsPlayer: true")
        return true
    else
        print("IsPlayer: false")
        return false
    end
end


function WhatIsIt()
    if UnitCreatureFamily("Target") == nil then
        print(UnitName("Target"))
        return
    else
        print(UnitCreatureFamily("Target"))
    end
end





--table.insert(GDDM_DB_MSG.History, { GetUnitName("Player"), 'MsgString' })
-- local set_red_color = "|cFFFF0000"
-- local reset_color = "|r"
--     ---@type string
--     local messageString = set_red_color .. tostring(X) .. reset_color ..
--         " found at " .. tostring(G.locX) .. ", " .. tostring(G.locY) .. " in " .. tostring(G.locName) .. "\n"

--     print("acecomm Message goes here")

--     --AceComm:SendCommMessage(G.SendPrefix, messageString, "GUILD", nil)



--  if GDDM_DB_OPTIONS["Animals"] == true then     
--                 MsgString = "Idiot "..red..GetUnitName("player")..reset.." found a "..tostring(thing).." instead..."
--                 C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgString, "GUILD")

    --    if GDDM_DB_OPTIONS["NPC"] == true then           
    --         MsgString = red..tostring(X)..reset.." found the elusive NPC; "..tostring(X).."..."
    --         C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgString, "GUILD")
    --         return
    --     else

       -- Verify_Store()
        -- MsgStringSend = red..arg4..reset.." found at "..tostring(G.locX)..", "..tostring(G.locY).." in "..tostring(G.locName).."\n"
        -- Package = C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgStringSend, "GUILD")


--     ---------------------------------------------------------
--     -- Sender Message event
--     ---------------------------------------------------------
--     C_ChatInfo.RegisterAddonMessagePrefix(G.sendMessagePrefix)
--     if event == "CHAT_MSG_ADDON" and arg1 == G.sendMessagePrefix and arg2 == "go" and arg4 == MyFullName then

--         Verify_Target_In_List()
--         local sendPackage = C_ChatInfo.SendAddonMessage(G.triggerPrefix, 'MsgStringReceived', "GUILD")


--     elseif
--         event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 ~= "go" and arg4 ~= MyFullName then


--             -- G:MakeMessageWindow()
--             -- G:MakeText(MsgString)
--             -- G:MakeWindowCloser()

--     end

-- end)
