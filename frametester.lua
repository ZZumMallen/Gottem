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
    UI.Btn:SetPoint(pte,parent,rPte,x,y)
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
