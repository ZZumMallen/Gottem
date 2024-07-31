local _, core = ...;
local L = core.A


--className, classFilename, classId = UnitClass("Player")

local classColorID = {
    [1] = "warrior",
    [2] = "paladin",
    [3] = "hunter",
    [4] = "rogue",
    [5] = "priest",
    [6] = "dk",
    [7] = "shaman",
    [8] = "mage",
    [9] = "warlock",
    [10] = "monk",
    [11] = "druid",
    [12] = "demonhunter",
    [13] = "evoker",
}

local class_colors = {
    ["Warrior"] = "C79C6E",
    ["Paladin"] = "F58CBA",
    ["Hunter"] = "ABD473",
    ["Rogue"] = "FFF569",
    ["Priest"] = "FFFFFF",
    ["Death knight"] = "C79C6E",
    ["Shaman"] = "C79C6E",
    ["Mage"] = "40C7EB",
    ["Warlock"] = "8787ED",
    ["Monk"] = "C79C6E",
    ["Druid"] = "FF7D0A",
    ["Demon Hunter"] = "C79C6E",
    ["Evoker"] = "C79C6E",
}


local PartyList = {
    [1] = "PLAYER",
    [2] = "PARTY1",
    [3] = "PARTY2",
    [4] = "PARTY3",
    [5] = "PARTY4",
}


L.tList = { }

