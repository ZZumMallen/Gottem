local addonName, core = ...
core.C = core.C or {}
local G = core.C

G.triggerPrefix = "ope_gottem"
G.messagePrefix = "sneak_right_past_ya_there"

local MyFullName

SLASH_ZGG1 = "/gottem"
SlashCmdList["ZGG"] = function() C_ChatInfo.SendAddonMessage(G.triggerPrefix, "go", "GUILD") end;

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
    elseif
        event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 == "go" and arg4 == MyFullName then
        C_ChatInfo.RegisterAddonMessagePrefix(G.triggerPrefix)
        Verify_Store()
    elseif
        event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 ~= "go" then
        message(arg2)
    end
end)

function Verify_Store()
    local X = GetUnitName("Target")
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
                print("That is an NPC named "..X.."...")
                return
            else
                print("Great, you found a " .. tostring(thing) .. ", you idiot!")
                return
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

    print(G.Result, G.locName, G.locX, G.locY)
    local msgString = tostring(X).." found at "..tostring(G.locX)..", "..tostring(G.locY).." in "..tostring(G.locName)
    C_ChatInfo.SendAddonMessage(G.triggerPrefix, msgString, "GUILD")

end
