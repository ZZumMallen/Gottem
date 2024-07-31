local addonName, core = ...
local G = core.A

G.triggerPrefix = "ope_gottem"
local sendPrefix = "gottem_send"

---@diagnostic disable:undefined-field
LibStub("AceComm-3.0"):Embed(G)
local Callback = LibStub("CallbackHandler-1.0")

-- Character specific name save
local playerName = UnitName("Player")

-- my info saves player name to charater db so you dont spam yourself and add extra traffic
GDDM_MY_INFO = {
    ME = playerName,
    TAR = "Unknown"
}

local function updateMessages()
    GDDM_MY_INFO.TAR = GetUnitName("Target")
end

SLASH_GOTTEM1 = "/gottem"
SlashCmdList["GOTTEM"] = function()
    InitVars()
end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then -- This is where the loop starts
        G:RegisterComm(sendPrefix)
        
        GDDM_DB_OPTIONS.POS = GDDM_DB_OPTIONS.POS or {"CENTER",nil,"CENTER",0,0}
       

        function InitVars()       
            updateMessages()
            K = GDDM_MY_INFO.TAR
            Verify_Target_In_List()
            return K
        end
        
        -- these are a bunch of checks to categorize responses
        -- also gives me a way to disable levels of stupidity
        -- enable/disable code was removed because I was mad while troubleshooting one day
        function Verify_Target_In_List()

            if IsNil(K) then -- stops the party if nothing is targetted
                return
            end

            if IsMeg(K) then -- checks for Megs shaman
                return
            end

            -- if InList(K) then
            --     return
            -- end
            
            if InGuild(K) then
                return
            end
            
            
            if IsPlayerCharacter() then
                return
            elseif
                WhatIsIt()
                then
                return
                end
            end

        SentTime = GetTime()
        GDDM_DB_OPTIONS.INIT = SentTime

    elseif event == "CHAT_MESSAGE_ADDON" then
        G.OnCommReceived()
    end
end) -- loop ends






-------------------------------------------------------------
-- Receiving a messagge
-------------------------------------------------------------
function G.OnCommReceived(_, prefix, message, _, sender)
    if prefix == sendPrefix and sender ~= GDDM_MY_INFO.ME then
        MakeMessageWindow(message)
    else
        print(message) -- change this to MakeMessageWindow(message) if you for trouble shooting in a wow client
    end
end


-------------------------------------------------------------
-- Checks
-------------------------------------------------------------
local MeganMsg, NotListMsg, ListMsg, NPCMsg, AnimalMsg
function IsNil(X)
    if X == nil then
        return true
    else
        return false
    end
end

function IsMeg(X)
    local m = X
    if m == "Mouse" then
        GetBasic()
        G:SendCommMessage(sendPrefix, MeganMsg, "Guild")
        return true
    else
        return false
    end
end

function InGuild(X)
    local guildName, _, _= GetGuildInfo(X)
    if guildName == "Peons" then
        GetInfo(X)
        G:SendCommMessage(sendPrefix, GuildMsg, "Guild")
        return true
    else
        return false
    end
end

function InList(X) -- checks if the target is in the DB
    local found = true
    for _, j in ipairs(G.tList) do
        if j == X then -- added this code because of megans shaman
            found = true
            GetInfo(X)
            G:SendCommMessage(sendPrefix,ListMsg,"Guild")
            return true
        end
    end
    if not found then
        return false
    end
end

function IsPlayerCharacter() -- is it a player-character
    if UnitIsPlayer("Target") then
        GetBasic()
        G:SendCommMessage(sendPrefix, NotListMsg, "Guild")
        return true
    else
        return false
    end
end

function WhatIsIt()
    if UnitCreatureFamily("Target") == nil then        
        GetBasic()
        G:SendCommMessage(sendPrefix, NPCMsg, "Guild")    
        return true
    else
        if GDDM_DB_OPTIONS.Animals == true then
            GetBasic()
            G:SendCommMessage(sendPrefix, AnimalMsg, "Guild")
        end
        return true
    end
end


-------------------------------------------------------------
-- Funkytown - G. GetInfo & GetBasic
-------------------------------------------------------------
function GetInfo(X)
    
    local red = "|cFFFF0000"
    local reset = "|r"
    local green = "|cFF34f00e"
    local playerMe = green .. GDDM_MY_INFO.ME .. reset
    local myTarget = red .. GDDM_MY_INFO.TAR .. reset
    local tStamp = date("%I:%M%p - ")

    local mapID = C_Map.GetBestMapForUnit("Target")

    ---@diagnostic disable-next-line
    local pos = C_Map.GetPlayerMapPosition(mapID, "Target");

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
        G.locName = GetMinimapZoneText() .. ", " .. GetZoneText()
    end

    ---@type string
    GuildMsg = tStamp .. playerMe.. " spotted " .. myTarget .."\n" ..
        "Found at " .. G.locX .. ", " .. G.locY .. " in " .. G.locName

    ListMsg = tStamp .. playerMe .. " spotted " .. myTarget .. "\n" ..
        "Found at " .. G.locX .. ", " .. G.locY .. " in " .. G.locName
    return red, green, reset, playerMe, myTarget
end

function GetBasic()
    local red = "|cFFFF0000"
    local reset = "|r"
    local green = "|cFF34f00e"
    local playerMe = green .. GDDM_MY_INFO.ME .. reset
    local myTarget = red .. GDDM_MY_INFO.TAR .. reset
    local tStamp = date("%I:%M%p - ")

    if GetZoneText() == GetMinimapZoneText() then
        ---@type string
        G.locName = GetZoneText()
    else
        ---@type string
        G.locName = GetMinimapZoneText() .. ", " .. GetZoneText()
    end

    NotListMsg = tStamp..playerMe .. " found some guy named " .. myTarget .. "\n" ..
        "Almost!"

    NPCMsg = tStamp .. playerMe .. " found an NPC named " .. myTarget .. "\n" ..
        "Close one buddy!"

    AnimalMsg = tStamp .. playerMe .. " found a wild " .. myTarget .. "\n" ..
        "Looks like one if those BIRDS got out"

    MeganMsg = red .. "Dammit Meg" .. reset
end

------------------------------------------------------------------------------
-- Message Box
------------------------------------------------------------------------------
local previousWindow
local previousTimer
-- I want the frame to time out after x seconds but reset on new message
-- this function removes the previous message
function MakeMessageWindow(message)
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end

    if previousTimer then
        previousTimer:Cancel()
        previousTimer = nil
    end

    --message frames
    MsgFrame = CreateFrame("frame", "MessageFrame", UIParent, "InsetFrameTemplate3")
    MsgFrame:Hide()
    MsgFrame:SetSize(540, 60)
    -- MsgFrame:ClearAllPoints()
    MsgFrame:SetPoint(GDDM_DB_OPTIONS.POS[1], GDDM_DB_OPTIONS.POS[2], GDDM_DB_OPTIONS.POS[3], GDDM_DB_OPTIONS.POS[4],
        GDDM_DB_OPTIONS.POS[5])
    MsgFrame:EnableMouse(true);
    MsgFrame:SetMovable(true);
    MsgFrame:RegisterForDrag("LeftButton");
    MsgFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);
    MsgFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, parent, relativePoint, xOfs, yOfs = MsgFrame:GetPoint()
        -- DEFAULT_CHAT_FRAME:AddMessage(point)
        -- DEFAULT_CHAT_FRAME:AddMessage(parent)
        -- DEFAULT_CHAT_FRAME:AddMessage(relativePoint)
        -- DEFAULT_CHAT_FRAME:AddMessage(xOfs)
        -- DEFAULT_CHAT_FRAME:AddMessage(yOfs)
        GDDM_DB_OPTIONS.POS = { point, parent, relativePoint, xOfs, yOfs }
    end);

    MsgFrame:Show()

    MsgFrame.Closer = CreateFrame("Button", nil, MsgFrame, "UIPanelButtonTemplate")
    MsgFrame.Closer:SetSize(30, 30)
    MsgFrame.Closer:SetPoint("TOPRIGHT", MsgFrame, "TOPRIGHT", 0, 2)
    MsgFrame.Closer:SetText("X")
    MsgFrame.Closer:SetScript("OnMouseDown", function(self)
        MsgFrame:Hide()
    end)

    MsgFrame.MessageContainer = MsgFrame:CreateFontString(nil, "OVERLAY")
    MsgFrame.MessageContainer:SetPoint("TOPLEFT", MsgFrame, "TOPLEFT", 10, -5);
    MsgFrame.MessageContainer:SetFontObject("Game15Font")
    MsgFrame.MessageContainer:SetJustifyH("LEFT")
    MsgFrame.MessageContainer:SetSpacing(3)
    MsgFrame.MessageContainer:SetWordWrap(true)
    MsgFrame.MessageContainer:SetText(message)

    previousWindow = MsgFrame
    previousTimer = C_Timer.NewTimer(5,function (self)
        MsgFrame:Hide()        
    end)

    return MsgFrame
end



