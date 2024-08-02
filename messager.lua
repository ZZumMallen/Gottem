local addonName, core = ...
local G = core.A

local sendPrefix = "ope_gottem"

-- Character specific name save2
local playerName = UnitName("Player")

LibStub("AceComm-3.0"):Embed(G) ---@diagnostic disable-line

G.callbacks = G.callbacks or
    LibStub("CallbackHandler-1.0"):New(G)


-- slash command
SLASH_GOTTEM1 = "/gottem"
SlashCmdList["GOTTEM"] = function()
    InitVars()
end;

-- my info saves player name to charater db so you dont spam yourself and add extra traffic
GDDM_MY_INFO = {
    ME = playerName,
    TAR = "Unknown"
}


local function InInstance()
    local isInInstance, _ = IsInInstance()
    if isInInstance then
        return true
    else
        return false
    end
end

local function updateMessages()
    GDDM_MY_INFO.TAR = GetUnitName("Target")
end

local function IsNil(X)
    if X == nil then
        return true
    else
        return false
    end
end

local function InGuild(X)
    local guildName, _, _ = GetGuildInfo(X)
    if guildName == "Peons" then
        GetInfo(X)
        G:SendCommMessage(sendPrefix, GuildMsg, "Guild")
        return true
    else
        return false
    end
end

local function IsPlayerCharacter()
    if UnitIsPlayer("Target") then
        GetBasic()
        G:SendCommMessage(sendPrefix, NotListMsg, "Guild")
        return true
    else
        return false
    end
end

local function IsNPC()
    if UnitCreatureFamily("Target") == nil then
        GetBasic()
        G:SendCommMessage(sendPrefix, NPCMsg, "Guild")
        return true
    else
        return false
    end
end

local function IsAnimal()
    if UnitCreatureFamily("target") then
        GetBasic()
        G:SendCommMessage(sendPrefix, AnimalMsg, "Guild")
    return true
    else
        print("tell zach what this is")
        return false
    end
end

local function InCombat()
    if UnitAffectingCombat("Player") then
        return true
    end
end

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then -- This is where the loop starts
        G:RegisterComm(sendPrefix)
        local addon_loaded = true
        f:UnregisterEvent("ADDON_LOADED")

        function InitVars()
            -- checks if you are in an instance

            if addon_loaded then
                -- adds player name to the per character db
                updateMessages()
                K = GDDM_MY_INFO.TAR
                -- starts the event loop
                Verify_Target_In_List()
                return K
            end
        end

        -- message loop
        function Verify_Target_In_List()
            if InInstance() then
                return
            end

            if InCombat() then
                return
            end

            -- stops the message func if not targetting anything
            if IsNil(K) then
                return
            end

            if InGuild(K) then
                return
            end

            if IsPlayerCharacter() then
                return
            end

            if IsNPC() then
                return
            end

            if IsAnimal() then
                return
            end
        end

    elseif event == "CHAT_MESSAGE_ADDON" then
        G.OnCommReceived()
    end
end)


-------------------------------------------------------------
-- Receiving a messagge
-------------------------------------------------------------
function G.OnCommReceived(_, prefix, message, _, sender)
    if prefix == sendPrefix and sender ~= GDDM_MY_INFO.ME then
        MakeMessageWindow(message)
    else
        MakeMessageWindow(message) -- troubleshooting
        --print(message) -- deployment
    end
end

-------------------------------------------------------------
-- Funkytown - G. GetInfo & GetBasic
-------------------------------------------------------------
function GetInfo()
    local red = "|cFFFF0000"
    local reset = "|r"
    local green = "|cFF34f00e"
    local playerMe = green .. GDDM_MY_INFO.ME .. reset
    local myTarget = red .. GDDM_MY_INFO.TAR .. reset
    local tStamp = date("%I:%M%p - ")
    local locName, locX, locY

    local mapID = C_Map.GetBestMapForUnit("Target")

    ---@diagnostic disable-next-line
    local pos = C_Map.GetPlayerMapPosition(mapID, "Target");

    if pos == nil then
        locX = 0
        locY = 0
        return
    else
        locX = math.ceil(pos.x * 10000) / 100
        locY = math.ceil(pos.y * 10000) / 100
    end

    if GetZoneText() == GetMinimapZoneText() then
        locName = GetZoneText()
    else
        locName = GetMinimapZoneText() .. ", " .. GetZoneText()
    end

    ---@type string
    GuildMsg = tStamp .. playerMe.. " spotted " .. myTarget .."\n" ..
        "Found at " .. locX .. ", " .. locY .. " in " .. locName

    ListMsg = tStamp .. playerMe .. " spotted " .. myTarget .. "\n" ..
        "Found at " .. locX .. ", " .. locY .. " in " .. locName
    return red, green, reset, playerMe, myTarget
end

function GetBasic()
    local red = "|cFFFF0000"
    local reset = "|r"
    local green = "|cFF34f00e"
    local playerMe = green .. GDDM_MY_INFO.ME .. reset
    local myTarget = red .. GDDM_MY_INFO.TAR .. reset
    local tStamp = date("%I:%M%p - ")
    local locName

    if GetZoneText() == GetMinimapZoneText() and locName then
        ---@type string
        locName = GetZoneText()
    else
        ---@type string
        locName = GetMinimapZoneText() .. ", " .. GetZoneText()
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


function MakeMessageWindow(message)
    -- resets the message window
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end

    -- resets the timer
    if previousTimer then
        previousTimer:Cancel()
        previousTimer = nil
    end

    PlaySoundFile("Interface\\AddOns\\zGottem\\Media\\moleman_fidget_5140242.ogg")

    --message frames
    MsgFrame = CreateFrame("frame", "MessageFrame", UIParent, "InsetFrameTemplate3")
    MsgFrame:Hide()
    MsgFrame:SetSize(540, 60)
    MsgFrame:SetPoint(GDDM_DB_OPTIONS.POS[1], GDDM_DB_OPTIONS.POS[2], GDDM_DB_OPTIONS.POS[3], GDDM_DB_OPTIONS.POS[4],
        GDDM_DB_OPTIONS.POS[5])
    MsgFrame:EnableMouse(true);
    MsgFrame:SetMovable(true);
    MsgFrame:RegisterForDrag("LeftButton");
    MsgFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);
    MsgFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, parent, relativePoint, xOfs, yOfs = MsgFrame:GetPoint()
        GDDM_DB_OPTIONS.POS = { point, parent, relativePoint, xOfs, yOfs }
    end);

    MsgFrame:Show()



    -- Creates the close button
    MsgFrame.Closer = CreateFrame("Button", nil, MsgFrame, "UIPanelButtonTemplate")
    MsgFrame.Closer:SetSize(30, 30)
    MsgFrame.Closer:SetPoint("TOPRIGHT", MsgFrame, "TOPRIGHT", 0, 2)
    MsgFrame.Closer:SetText("X")
    MsgFrame.Closer:SetScript("OnMouseDown", function(self)
        MsgFrame:Hide()
    end)

    -- Creates the text
    MsgFrame.MessageContainer = MsgFrame:CreateFontString(nil, "OVERLAY")
    MsgFrame.MessageContainer:SetPoint("TOPLEFT", MsgFrame, "TOPLEFT", 10, -5);
    MsgFrame.MessageContainer:SetFontObject("Game15Font")
    MsgFrame.MessageContainer:SetJustifyH("LEFT")
    MsgFrame.MessageContainer:SetSpacing(3)
    MsgFrame.MessageContainer:SetWordWrap(true)
    MsgFrame.MessageContainer:SetText(message)

    --adds window to bottom of 'stack'
    previousWindow = MsgFrame
    --starts the timer
    previousTimer = C_Timer.NewTimer(5,function (self)
        MsgFrame:Hide()
    end)

    return MsgFrame
end



-------------------------------------------------------------
-- Unused list check - not yet implemented
-------------------------------------------------------------
-- function InList(X) -- checks if the target is in the DB
--     local found = true
--     for _, j in ipairs(G.tList) do
--         if j == X then -- added this code because of megans shaman
--             found = true
--             GetInfo(X)
--             G:SendCommMessage(sendPrefix, ListMsg, "Guild")
--             return true
--         end
--     end
--     if not found then
--         return false
--     end
-- end
