---@diagnostic disable: undefined-field
---@diagnostic disable: inject-field
local _, ZUI = ...;
local S = ZUI.A

ZUISavedData = ZUISavedData or {}

local function SaveData(message)
    if not ZUISavedData.chatMessages then
        ZUISavedData.chatMessages = {}
    end
    table.insert(ZUISavedData.chatMessages, message)
end

local chat = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
chat:SetMovable(true)
chat:EnableMouse(true)
chat:RegisterForDrag("LeftButton")
chat:SetScript("OnDragStart", chat.StartMoving)
chat:SetScript("OnDragStop", chat.StopMovingOrSizing)
chat:Hide()
chat:SetSize(400, 150);
chat:SetPoint("CENTER", UIParent, "CENTER", 0, 300)

--make that title
chat.title = chat:CreateFontString(nil, "OVERLAY", "GameFontNormal");
chat.title:SetFontObject("GameFontNormal");
chat.title:SetPoint("TOPLEFT", chat.TitleBg, "TOPLEFT", 5, -4);
chat.title:SetText("ZUI Jake Spotter")

-- Create a font string to display the chat message
chat.message = chat:CreateFontString(nil, "OVERLAY", "GameFontNormal")
chat.message:SetFontObject("GameFontNormal")
chat.message:SetPoint("TOPLEFT", chat.title, "BOTTOMLEFT", 0, -6)
chat.message:SetWidth(chat:GetWidth() - 20) --new
chat.message:SetJustifyH("LEFT") --new
chat.message:SetJustifyV("TOP") --new

local function HideFrame()
    if chat:IsShown() then
        chat:Hide()
    end
end

HideFrame()

local function OnEvent(self, event, arg1, arg2, ...)
    if event == "CHAT_MSG_ADDON" and arg1 == "ZUI-CHAT" and 
    Check_all_the_things() == 1 then
        chat.message:SetText(arg2)
        chat:Show()
        SaveData(arg2)
        C_Timer.After(10, HideFrame)
    end
end


local chatEventFrame = CreateFrame("Frame")
chatEventFrame:RegisterEvent("CHAT_MSG_ADDON")
chatEventFrame:SetScript("OnEvent", OnEvent)

local regenEventFrame = CreateFrame("Frame")
regenEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
regenEventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")

function Check_all_the_things()
    local _, _, difficultyID = GetInstanceInfo()
    if difficultyID == 0 and UnitAffectingCombat("Player") == false then
        return 1
    end

end

-- split this into zui_chat
------------------------------------------------------

local allTheJakes = S.JakeList

function Is_name_in_list(picked_name)
    for _, name in ipairs(allTheJakes) do
        if name == picked_name then
            return true
        end
    end
    return false
end

C_ChatInfo.RegisterAddonMessagePrefix("ZUI-CHAT")

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_TARGET")

local lastSent = 0
local cooldown = 10

EventFrame:SetScript("OnEvent", function(self, event, ...)
    local currentTime = time()
    if currentTime - lastSent < cooldown then
        return
    end

    local jTarget = GetUnitName("Target")

    if event == "UNIT_TARGET" and Is_name_in_list(jTarget) then
        local class = strsplit(" ", UnitClass("Target"), 1)
        local message = "Character: " .. jTarget .. " (" .. class .. ")\n" ..
            "When: " .. date() .. "\n" ..
            "Where: " .. GetZoneText() .. " - " .. GetMinimapZoneText()
        C_ChatInfo.SendAddonMessage("ZUI-CHAT", message, "GUILD")
        lastSent = currentTime
    end
end)
