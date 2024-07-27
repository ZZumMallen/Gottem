local addonName, core = ...
local T = core.A;


SLASH_TEST1 = "/zest"
SlashCmdList["zest"] = function() print("test") end;

function CreateNewFrame(W,H,pte,parent,rPte,xO,yO)
    UI = CreateFrame("Frame", nil, UIParent,"BasicFrameTemplateWithInset")
    UI:SetSize(W,H)
    UI:SetPoint(pte,parent,rPte,xO,yO)
    return UI
end

function CreatePanelButton(pte,UI,rPte,x,y,w,h,text)
    UI.Btn = CreateFrame("BUTTON", nil, UI, "UIPanelButtonTemplate")
    UI.Btn:SetPoint(pte,UI,rPte,x,y)
    UI.Btn:SetSize(w,h)
    UI.Btn:SetText(text)
    UI.Btn:SetNormalFontObject("GameFontNormal");
    UI.Btn:SetHighlightFontObject("GameFontHighlight");
    return UI.Btn
end




F1 = CreateNewFrame(00,200,"CENTER",UIParent,"CENTER",-400,400)

F2 = CreateNewFrame(200, 200, "CENTER", UIParent, "CENTER", 0, 400)

F3 = CreateNewFrame(200, 200, "CENTER", UIParent, "CENTER", 400, 400)

F4 = CreateNewFrame(200, 200, "CENTER", UIParent, "CENTER", -400, 100)

F5 = CreateNewFrame(200, 200, "CENTER", UIParent, "CENTER", 0, 100)

F6 = CreateNewFrame(200, 200, "CENTER", UIParent, "CENTER", 400, 100)

B1 = CreatePanelButton(F2,"CENTER",4)























--
--
--     print(prefix, message, channel, sender, playerName)
-- end






--table.insert(GDDM_DB_MSG.History, { GetUnitName("Player"), 'MsgString' })

--     ---@type string
--     local messageString = set_red_color .. tostring(X) .. reset_color ..
--         " found at " .. tostring(G.locX) .. ", " .. tostring(G.locY) .. " in " .. tostring(G.locName) .. "\n"

--     print("G Message goes here")

--     --G:SendCommMessage(G.SendPrefix, messageString, "GUILD", nil)



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


--     ---------------------------------------------------------
--     -- Sender Message event
--     ---------------------------------------------------------
--     C_ChatInfo.RegisterAddonMessagePrefix(G.sendMessagePrefix)
--     if event == "CHAT_MSG_ADDON" and arg1 == G.sendMessagePrefix and arg2 == "go" and arg4 == MyFullName then

--         Verify_Target_In_List()
--         local sendPackage = C_ChatInfo.SendAddonMessage(G.triggerPrefix, 'MsgStringReceived', "GUILD")


--     elseif
--         event == "CHAT_MSG_ADDON" and arg1 == G.triggerPrefix and arg2 ~= "go" and arg4 ~= MyFullName then


--             -- G:MakeMessageWindow()
--             -- G:MakeText(MsgString)
--             -- G:MakeWindowCloser()

--     end

-- end)
