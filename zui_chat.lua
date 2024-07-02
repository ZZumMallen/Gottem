
local chat = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset");
chat:Hide()
chat:SetSize(200, 250);
chat:SetPoint("CENTER", UIParent, "CENTER", -750, 300)

chat.title = chat:CreateFontString(nil, "OVERLAY", "GameFontNormal");
chat.title:SetFontObject("GameFontNormal");
chat.title:SetPoint("TOPLEFT", chat.TitleBg, "TOPLEFT", 10, -30);
chat.title:SetText("test")

-- Create a font string to display the chat message
chat.message = chat:CreateFontString(nil, "OVERLAY", "GameFontNormal")
chat.message:SetFontObject("GameFontNormal")
chat.message:SetPoint("TOPLEFT", chat.title, "BOTTOMLEFT", 0, -10)

function OnEvent(self, event, arg1, arg2, ...)
    if (event == "CHAT_MSG_ADDON" and arg1 == "ZUI-CHAT") then
        print(arg2)
        chat.message:SetText(arg2)
        chat:Show()
        C_Timer.After(3, HideFrame)
    end
end


function HideFrame()
    if chat:IsShown() then
        chat:Hide()
    end
end

HideFrame()


local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", OnEvent)

