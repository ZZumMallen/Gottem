local addonName, core = ...
core.C = core.C or {}
local G = core.C

G.triggerPrefix = "ope_gottem"
G.sendMessagePrefix = "gottem_send"


local MyFullName

GDDM_DB_MSG = GDDM_DB_MSG or {}
GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {}
GDDM_DB_OPTIONS.NPC = GDDM_DB_OPTIONS.NPC or {}
GDDM_DB_OPTIONS.Combat = GDDM_DB_OPTIONS.Combat or {}
GDDM_DB_OPTIONS.Animals = GDDM_DB_OPTIONS.Animals or {}
GDDM_DB_MSG.History = GDDM_DB_MSG.History or {}

SLASH_ZGG1 = "/gottem"
SlashCmdList["ZGG"] = function() C_ChatInfo.SendAddonMessage(G.triggerPrefix, "go", "GUILD") end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, arg2, _, arg4,...)

    ---------------------------------------------------------
    -- Check for Addon Loaded
    ---------------------------------------------------------
    if event == "ADDON_LOADED" and arg1 == addonName then        
        C_ChatInfo.RegisterAddonMessagePrefix(G.triggerPrefix)
            -------------------------------------
            local name = GetUnitName("player")
            local realm = GetRealmName()
            MyFullName = name .. "-" .. realm
            -------------------------------------
        print("Addon Load Success: Messager")
    else
        print("Addon Load Fail: Messager")
        return
    end

    ---------------------------------------------------------
    -- Sender Message event
    ---------------------------------------------------------
    C_ChatInfo.RegisterAddonMessagePrefix(G.sendMessagePrefix)
    if event == "CHAT_MSG_ADDON" and arg1 == G.sendMessagePrefix and arg2 == "go" and arg4 == MyFullName then
        
        Verify_Target_In_List()
        local sendPackage = C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgStringReceived, "GUILD")

 
    elseif
        event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 ~= "go" and arg4 ~= MyFullName then
        
       
            -- G:MakeMessageWindow() 
            -- G:MakeText(MsgString)
            -- G:MakeWindowCloser()                       
        
    end
        
end)

table.insert(GDDM_DB_MSG.History, { GetUnitName("Player"), MsgString })


function Verify_Target_In_List()
    local X = GetUnitName("Target")
    local T = "Target"
    local P = "player"
    local set_red_color = "|cFFFF0000"
    local reset_color = "|r"

    if IsNil(X) then
        return
    end

    if InList(X) then
        return
    end

    if IsPlayer() then
        return
    end

    ---@class mapID:number
    local mapID = C_Map.GetBestMapForUnit(X)
    local pos = C_Map.GetPlayerMapPosition(mapID, X);


    if pos == nil then
        G.locX = 0
        G.locY = 0
        return
    else
        G.locX = math.ceil(pos.x * 10000) / 100
        G.locY = math.ceil(pos.y * 10000) / 100
    end

    if GetZoneText() == GetMinimapZoneText() then
        G.locName = GetZoneText()
    else
        G.locName = GetMinimapZoneText()..", "..GetZoneText()
    end

    local messageString = set_red_color ..  tostring(X) .. reset_color .. " found at " .. tostring(G.locX) .. ", " .. tostring(G.locY) .. " in " .. tostring(G.locName) .. "\n"
    
end


function IsNil(X)
    if X == nil then
        print("nil")
        return true
    else
        return false
    end
end

function InList(X)
    for _, j in ipairs(G.tList) do
        if j == X then
            return true
        else
            return false
        end
    end
end

function IsPlayer()
    if UnitIsPlayer("Target") then
        return true
    else
        return false
    end
end


function WhatIsIt(T)
    local result
    local thing = UnitCreatureFamily(T)
    if thing == nil then
        result = "NPC"
        return
    else
        result = "Animal or something"
        return
    end
end




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