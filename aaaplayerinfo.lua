local _, addon = ...

local mbr -- party member
local characterList = {}


function addon.foo(mbr)
    getInfo(mbr)
    return info
end


-- Date/timer (as an ad hoc index), dungeon, k level, IGN , server, class, spec, rio


-- party list
local u = {
    "Player",
    "Party1",
    "Party2",
    "Party3",
    "Party4",
}

-- party info loop
function GroupInfo()
    for _, v in pairs(u) do
        local ilvl = ("%.2f"):format(GetAverageItemLevel(v))
        local n = GetUnitName(v)
        local c = UnitClass(v)
        print(n .. "," .. c .. "," .. ilvl)
    end
end
