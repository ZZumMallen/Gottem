local function HideOurFrame()
	ChatFrame1:Hide()
end

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

EventFrame:SetScript("OnEvent", function(self, event, ...)
	if(event == "PLAYER_ENTERING_WORLD") then
		C_Timer.After(1, HideOurFrame)
	end
end)

-- the above function is an example of how to deal with the addon loading process
-- if the addon is loading on game start


--Title
-- f.title = f:CreateFontString(nil, "OVERLAY");
-- f.title:SetFontObject("GameFontNormal");
-- f.title:SetPoint("LEFT", f.TitleBg, "LEFT", 5, 0);
-- f.title:SetText("ZUI Title Hope");


-- -- Function to process the user input through all functions
-- function Struggle()
--     local results = {}
--     for k in pairs(users) do
--         results[k] = {}
--         for z in ipairs(functions) do
--             results[k][z] = 0
--         end
--     end

--     for i = 1 , 2 do
--         print(results[i])
--     end
-- end


-- SLASH_FRAMESTK1 = "/fs"
-- SlashCmdList.FRAMESTK = function()
-- 	--LoadAddOn('Blizzard_DebugTools')
-- 	FrameStackTooltip_Toggle()
-- end

-- for i = 1, NUM_CHAT_WINDOWS do
-- 	_G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
-- end
