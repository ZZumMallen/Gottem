local addonName, core = ...;
local G = core.C
local messagePrefix = "ope_gottem"


SLASH_ZGG1 = "/gottem"
SlashCmdList["ZGG"] = function() C_ChatInfo.SendAddonMessage(messagePrefix, "go", "GUILD") end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        C_ChatInfo.RegisterAddonMessagePrefix(messagePrefix)
        print("Messager Loaded")
    end
end)

local c = CreateFrame("Frame")
c:RegisterEvent("CHAT_MSG_ADDON")
c:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
    if event == "CHAT_MESSAGE_ADDON" and arg1 == messagePrefix and arg2 == "go" then
        print("message sent")
    end
end)









