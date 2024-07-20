-- ---@diagnostic disable: undefined-field
-- ---@diagnostic disable: inject-field

local addonName, core = ...;
local G = core.C




function OnEvent(self, event, arg1, ...)
    if event == "CHAT_MSG_SAY" and arg1 == "test" then
        X = GetUnitName("Target")
        
        if X == nil then
            return
        else
            for _, j in ipairs(G.tList) do
                if j == X then
                    print(X,j)
                end                               
            end            
        end
   
        ---@class mapID:number
        local mapID = C_Map.GetBestMapForUnit(X)        
        local pos = C_Map.GetPlayerMapPosition(mapID, "player");
        
        -- error still shows while in a nil check function
        ---@diagnostic disable-next-line:need-check-nil 
        print(C_Map.GetMapInfo(mapID).name, math.ceil(pos.x * 10000) / 100, math.ceil(pos.y * 10000) / 100)
    
    end
end

local t = CreateFrame("Frame")
t:RegisterEvent("CHAT_MSG_SAY")
t:SetScript("OnEvent", OnEvent)
