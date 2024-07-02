local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")

UPDATE_INSTANCE_INFO


EventFrame:SetScript("OnEvent", function(self,event, ...)
    

    if(event == "UNIT_SPELLCAST_SENT") then
        local i = 1
        local _, _, _, spellID = ...

        if(spellID == 203720) then
            i = i + 1
            print("Zach did da spikes".. i)
            
        elseif(spellID == 202138) then
            print("Chain me daddy")
        else
            return
        end
    
    
    
    end
end)

