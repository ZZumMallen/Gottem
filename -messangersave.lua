local addonName, core = ...
core.C = core.C or {}
local G = core.C

G.triggerPrefix = "ope_gottem"
G.messagePrefix = "sneak_right_past_ya_there"

local MyFullName

GDDM_DB_MSG = GDDM_DB_MSG or {}
GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {}
GDDM_DB_OPTIONS.NPC = GDDM_DB_OPTIONS.NPC or {}
GDDM_DB_OPTIONS.Combat = GDDM_DB_OPTIONS.Combat or {}
GDDM_DB_OPTIONS.Animals = GDDM_DB_OPTIONS.Animals or {}

SLASH_ZGG1 = "/gottem"
--SlashCmdList["ZGG"] = function() C_ChatInfo.SendAddonMessage(G.triggerPrefix, "go", "GUILD") end;



local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, arg2, _, arg4,...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        C_ChatInfo.RegisterAddonMessagePrefix(G.triggerPrefix)
        local name = GetUnitName("player")
        local realm = GetRealmName()
        MyFullName = name .. "-" .. realm
        print("Messager Loaded")
    end
        if event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 == "go" and arg4 == MyFullName then
        C_ChatInfo.RegisterAddonMessagePrefix(G.triggerPrefix)
        Verify_Store()
        MsgStringSend = red..arg4..reset.." found at "..tostring(G.locX)..", "..tostring(G.locY).." in "..tostring(G.locName).."\n"
        Package = C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgStringSend, "GUILD")
    elseif
        event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg4 ~= MyFullName then
        GDDM_DB_MSG.History = GDDM_DB_MSG.History or {} 
       
            G:MakeMessageWindow() 
            G:MakeText(MsgString)
            G:MakeWindowCloser()                       
        table.insert(GDDM_DB_MSG.History, { GetUnitName("Player"), MsgString })
    end
        
end)




function Verify_Store()
    local X = GetUnitName("Target")
    local red = "|cFFFF0000"
    local reset = "|r"
    if X == nil then
        G.Result = print("you need to target something")
        return
    else
        if UnitIsPlayer("Target") then
            for _, j in ipairs(G.tList) do
                if j == X then
                    G.Result = X
                end
            end
        else
            local thing = UnitCreatureFamily("target")
            if thing == nil then
                if GDDM_DB_OPTIONS["NPC"] == true then           
                    MsgString = red..tostring(X)..reset.." found the elusive NPC; "..tostring(X).."..."
                    C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgString, "GUILD")
                    return
                else
                    print("That is an NPC")
                    return
                end
            else
                if GDDM_DB_OPTIONS["Animals"] == true then     
                        MsgString = "Idiot "..red..GetUnitName("player")..reset.." found a "..tostring(thing).." instead..."
                        C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgString, "GUILD")
                    return
                else
                    print("Thats some kind of bird")
                    return
                end
            end
        end
    end

    ---@class mapID:number
    local mapID = C_Map.GetBestMapForUnit(X)
    local pos = C_Map.GetPlayerMapPosition(mapID, X);

    --G.locName = C_Map.GetMapInfo(mapID).name

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

    local red = "|cFFFF0000"
    local reset = "|r"
    --MsgString = red..tostring(X)..reset

    --print(G.Result, G.locName, G.locX, G.locY)
    
    
       
   
        
    
    MsgStringReceived = red..tostring(X)..reset.." found at "..tostring(G.locX)..", "..tostring(G.locY).." in "..tostring(G.locName).."\n"
    Package = C_ChatInfo.SendAddonMessage(G.triggerPrefix, MsgStringReceived, "GUILD")
end