---@diagnostic disable: undefined-field
local addonName, core = ...;
local L = core.A

local h = CreateFrame("Frame")
h:RegisterEvent("ADDON_LOADED")

h:SetScript("OnEvent", function(self, event, arg1, ...) 
    if event == "ADDON_LOADED" and arg1 == addonName then
        L.tList = L.tList or {}

    end
end)



L.PartyList = {
    [1] = "PLAYER",
    [2] = "PARTY1",
    [3] = "PARTY2",
    [4] = "PARTY3",
    [5] = "PARTY4",
}


L.tList = {
    "Marnival",
    "Whomptilizer",
    "Amelioration",
    "Gusthebus",
    "Chungtesta",
    "Palmface",
    "Sedition",
    "Jakeofcats",
    "lucilletwo",
    "cryinggame",
    "madys",
    "manimal",
    "Jacobcats",
    "Brownnote",
    "Hogslammer",
    "Nanosmitten",
    "Tinkr",
    "Pirouette",
    "Mouse",
    "Sinestroo",
    "Vacca",
    "Bailbean",
    "Sunfeather",
    "Adrelia",
    "Bubbleôseven",
    "Flauris",
    "Umalinn",
    "Floweret",
    "Glõpanx",
    "Naril",
    "Cabe",
    "Roshana"

}

L.Messages = {


    
}