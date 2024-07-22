-- ---@diagnostic disable: undefined-field
-- ---@diagnostic disable: inject-field

local addonName, core = ...;
local G = core.C

-- function Verify_Storez()
--     local X = GetUnitName("Target")
--     if X == nil then
--             G.Result = print("you need to target something")
--         return
--     else
--         if UnitIsPlayer("Target") then 
--             for _, j in ipairs(G.tList) do                    
--                 if j == X then
--                     print(X)
--                     G.isFound = true
--                     G.foundTarget = X
--                     G.Result = X
--                 end                                 
--             end
--         else
--             local thing = UnitCreatureFamily("target")
--             print("That's a " .. thing .. " you idiot!")
--             return
--         end          
--     end

--     ---@class mapID:number
--     local mapID = C_Map.GetBestMapForUnit(X)        
--     local pos = C_Map.GetPlayerMapPosition(mapID, X);        

--     G.locName = C_Map.GetMapInfo(mapID).name

--     if pos == nil then
--         G.locX = 0
--         G.locY = 0            
--         return 
--     else
--         G.locX = math.ceil(pos.x * 10000) / 100
--         G.locY = math.ceil(pos.y * 10000) / 100
--     end
--     print(G.Result, G.isFound, G.foundTarget, G.locName, G.locX, G.locY)
-- end