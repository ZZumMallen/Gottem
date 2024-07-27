local addonName, core = ...
local G = core.A

G.triggerPrefix = "ope_gottem"
G.sendPrefix = "gottem_send"


GDDM_DB_MSG = GDDM_DB_MSG or {} -- shorten do GDm
GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {} -- shorten to GDO
GDDM_DB_OPTIONS.INIT = GDDM_DB_OPTIONS.INIT or {}
GDDM_DB_OPTIONS.NPC = GDDM_DB_OPTIONS.NPC or {}
GDDM_DB_OPTIONS.Debug = GDDM_DB_OPTIONS.Debug or {}
GDDM_DB_OPTIONS.Animals = GDDM_DB_OPTIONS.Animals or {}
GDDM_DB_MSG.History = GDDM_DB_MSG.History or {}



LibStub("AceComm-3.0"):Embed(G)
local Callback = LibStub("CallbackHandler-1.0")

-- local unit, realm = UnitFullName("Player")
-- local playerName = tostring(unit) .. "-" .. tostring(realm)

local playerName = UnitName("Player")

GDDM_MY_INFO.ME = playerName

SLASH_GOTTEM1 = "/gottem"
SlashCmdList["GOTTEM"] = function() Verify_Target_In_List() end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, ...)      
    if event == "ADDON_LOADED" and arg1 == addonName then
        G:RegisterComm(G.sendPrefix)
        if GDDM_DB_OPTIONS.Debug == true then
            print("Addon Loaded")
        end

        function Verify_Target_In_List()
            local X = GetUnitName("Target")
            local T = "Target"

            if IsNil(X) then -- stops the party if nothing is targetted
                return
            end

            if InList(X) then                 
                return
            elseif
                IsPlayerCharacter(T) then
                return
            elseif
                WhatIsIt()
                then
                return
            end
        end

        SentTime = GetTime()
        GDDM_DB_OPTIONS.INIT = SentTime

    elseif     
        event == "CHAT_MESSAGE_ADDON" then            
            G.OnCommReceived()
    end
  
end)

function G.OnCommReceived(_, prefix, message, channel, sender)
    if prefix == G.sendPrefix and sender ~= GDDM_MY_INFO.ME then
        print(message)
    else
        print("Time to recycle")
    end
end

-------------------------------------------------------------
-- Checks
-------------------------------------------------------------
function IsNil(X)
    if X == nil then
        if GDDM_DB_OPTIONS.Debug == true then
            print("IsNil: true")
        end
        return true
    else 
        if GDDM_DB_OPTIONS.Debug == true then
            print("IsNil: true")
        end
        return false
    end
end

function InList(X) -- checks if the target is in the DB
    local found = true
    for _, j in ipairs(G.tList) do
        if j == X then 
            found = true
            if GDDM_DB_OPTIONS.Debug == true then
                 print("InList: True")
            end
            G.GetInfo(X)
            G:SendCommMessage(G.sendPrefix,G.In_List_Msg,"Guild")
            return true
        end
    end
    if not found then
        if GDDM_DB_OPTIONS.Debug == true then
            print("InList: false")
        end
        return false
    end
end

function IsPlayerCharacter(T,X) -- is it a player-character
    if UnitIsPlayer(T) then
        if GDDM_DB_OPTIONS.Debug == true then
            print("IsPlayer: true")
        end
        G.GetBasic(X)
        G:SendCommMessage(G.sendPrefix, G.Not_In_List_Msg, "Guild")
        return true
    else
        if GDDM_DB_OPTIONS.Debug == true then
            print("IsPlayer: false")
        end        
        return false
    end
end

function WhatIsIt(X)
    if UnitCreatureFamily("Target") == nil then
        if GDDM_DB_OPTIONS.Debug == true then
            print("Non-Creature found: "..UnitName("Target"))
        end
        G.GetBasic(X)
        G:SendCommMessage(G.sendPrefix, G.NPC_Msg, "Guild")
        return true
    else
        if GDDM_DB_OPTIONS.Debug == true then
            print("Creature found: "..UnitCreatureFamily("Target"))
        end
        G.GetBasic(X)
        G:SendCommMessage(G.sendPrefix, G.Animal_Msg, "Guild")
        return true 
    end
end


-------------------------------------------------------------
-- Funkytown - G. GetInfo & GetBasic
-------------------------------------------------------------

function G.GetInfo(X)
    local set_red_color = "|cFFFF0000"
    local reset_color = "|r"

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

    G.In_List_Msg = set_red_color .. tostring(X) .. reset_color ..
        " found at " .. tostring(G.locX) .. ", " .. tostring(G.locY) .. " in " .. tostring(G.locName)
end

function G.GetBasic(X)
    local set_red_color = "|cFFFF0000"
    local reset_color = "|r"

    if GetZoneText() == GetMinimapZoneText() then
        ---@type string
        G.locName = GetZoneText()
    else
        ---@type string
        G.locName = GetMinimapZoneText() .. ", " .. GetZoneText()
    end

    G.Not_In_List_Msg = set_red_color ..
        UnitName("player") .. reset_color .. ", found some guy named " .. GetUnitName("Target") .. ". Almost!"

    G.NPC_Msg = set_red_color ..
        UnitName("player") .. reset_color .. ", found an NPC named " .. GetUnitName("Target") .. ". Close Buddy!"

    G.Animal_Msg = set_red_color .. UnitName("player") .. reset_color .. "found a wild " .. GetUnitName("Target")
end













-- 
-- 
--     print(prefix, message, channel, sender, playerName)
-- end






--table.insert(GDDM_DB_MSG.History, { GetUnitName("Player"), 'MsgString' })

--     ---@type string
--     local messageString = set_red_color .. tostring(X) .. reset_color ..
--         " found at " .. tostring(G.locX) .. ", " .. tostring(G.locY) .. " in " .. tostring(G.locName) .. "\n"

--     print("G Message goes here")

--     --G:SendCommMessage(G.SendPrefix, messageString, "GUILD", nil)



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
