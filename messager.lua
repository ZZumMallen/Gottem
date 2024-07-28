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


---@diagnostic disable-next-line
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

            if G.IsNil(X) then -- stops the party if nothing is targetted
                return
            end

            if G.IsMeg(X) then
                return
            end

            if G.InList(X) then            
                return
            elseif
                G.IsPlayerCharacter(T) then
                    print("Ischaracter run")
                return
            elseif
                G.WhatIsIt()
                then
                return
            end
        end

        SentTime = GetTime()
        GDDM_DB_OPTIONS.INIT = SentTime

    elseif event == "CHAT_MESSAGE_ADDON" then
        G.OnCommReceived()

    end
    
end)

---@diagnostic disable:redundant-parameter
-------------------------------------------------------------
-- Receiving a messagge
-------------------------------------------------------------
function G.OnCommReceived(_, prefix, message, _, sender)
    if prefix == G.sendPrefix and sender ~= GDDM_MY_INFO.ME then
        print(message)
    else
       
        G:MakeMessageWindow(message)
    end
end

-------------------------------------------------------------
-- Checks
-------------------------------------------------------------
function G.IsNil(X)
    if X == nil then
        return true
    else 
        return false
    end
end

function G.IsMeg(X)
    if X == "Mouse" then
        G:SendCommMessage(G.sendPrefix, G.Megan, "Guild")
        return true
    else
        return false
    end
end

function G.InList(X) -- checks if the target is in the DB
    local found = true
    for _, j in ipairs(G.tList) do
        if j == X then -- added this code because of megans shaman
            found = true
            G.GetInfo(X)
            G:SendCommMessage(G.sendPrefix,G.In_List_Msg,"Guild")
            return true
        end
    end
    if not found then
        return false
    end
end

function G.IsPlayerCharacter(T,X) -- is it a player-character
    if UnitIsPlayer(T) then
        G.GetBasic(X)
        G:SendCommMessage(G.sendPrefix, G.Not_In_List_Msg, "Guild")
        return true
    else   
        return false
    end
end



function G.WhatIsIt(X)
    if UnitCreatureFamily("Target") == nil then
        
        
        if GDDM_DB_OPTIONS.MPC == true then
            G.GetBasic(X)
            G:SendCommMessage(G.sendPrefix, G.NPC_Msg, "Guild")
        end
        return true
    else
        if GDDM_DB_OPTIONS.Animals == true then
            G.GetBasic(X)
            G:SendCommMessage(G.sendPrefix, G.Animal_Msg, "Guild")
        end
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

function G.GetBasic()
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

    G.Animal_Msg = set_red_color .. UnitName("player") .. reset_color .. " found a wild " .. GetUnitName("Target")

    G.Megan = set_red_color .. "Dammit Meg" .. reset_color

end



------------------------------------------------------------------------------
-- Message Box area
------------------------------------------------------------------------------
local previousWindow

function G:MakeMessageWindow(message)
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end
    
    MsgFrame = CreateFrame("frame", nil, UIParent, "InsetFrameTemplate3")
    MsgFrame:Hide()
    MsgFrame:SetSize(510, 30)
    MsgFrame:ClearAllPoints()
    MsgFrame:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "TOPLEFT", 0, 0)
    MsgFrame:EnableMouse(true);
    MsgFrame:SetMovable(true);
    MsgFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
    MsgFrame:RegisterForDrag("LeftButton");
    MsgFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);
    MsgFrame:Show()

    MsgFrame.Closer = CreateFrame("Button", nil, MsgFrame, "UIPanelButtonTemplate")
    MsgFrame.Closer:SetSize(30, 30)
    MsgFrame.Closer:SetPoint("TOPRIGHT", MsgFrame, "TOPRIGHT", 0, 2)
    MsgFrame.Closer:SetText("X")
    MsgFrame.Closer:SetScript("OnMouseDown", function(self)
        MsgFrame:Hide()
    end)

    MsgFrame.MessageContainer = MsgFrame:CreateFontString(nil, "OVERLAY")
    MsgFrame.MessageContainer:SetPoint("LEFT", MsgFrame, "LEFT", 10, 0);
    MsgFrame.MessageContainer:SetFontObject("Game13Font")
    MsgFrame.MessageContainer:CanWordWrap()
    MsgFrame.MessageContainer:SetText(message)
    previousWindow = MsgFrame
    
    return MsgFrame    
end

