local addonName, core = ...;
local G = core.C
local messagePrefix = "ope_gottem"


SLASH_ZGG1 = "/gottem"
SlashCmdList["ZGG"] = function() C_ChatInfo.SendAddonMessage(messagePrefix, "go", "Guild") end;

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        C_ChatInfo.RegisterAddonMessagePrefix(messagePrefix)
        print("Messager Loaded")
    elseif
        event == "CHAT_MSG_ADDON" and arg1 == messagePrefix and arg2 == "go" then
            message("WE DID IT")
    end    
end)










