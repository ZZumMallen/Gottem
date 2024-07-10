local _, addon = ...

local characterList = {}


function addon.foo(mbr)
    getInfo(mbr)
    return info
end


-- Date/timer (as an ad hoc index), dungeon, k level, IGN , server, class, spec, rio


--GetSpecialization() returns which spec number n
--GetSpecializationRole(n) returns role TANK HEAL DPS
--GetSpecializationInfo(n) - returned 581 on DH
--unitGUID





-- party list
local partyList = {
    "Player",
    "Party1",
    "Party2",
    "Party3",
    "Party4",
}

-- party info loop
function GroupInfo()
    for _, v in pairs(partyList) do
        local ilvl = ("%.2f"):format(GetAverageItemLevel(v))
        local n = GetUnitName(v)
        local c = UnitClass(v)
        print(n .. "," .. c .. "," .. ilvl)
    end
end


-- --Player Clss info
-- localizedClass, englishClass, classIndex = UnitClass("unit");
-- u = "player"
-- print(strsplit(",", UnitClass(u), 1))
-- print("done")




local specList = {

    --Death Knight
    [250] = 'Blood',
    [251] = 'Frost',
    [252] = 'Unholy',

    --Demon Hunter
    [577] = 'Havoc',
    [581] = 'Vengeance',

    --Druid
    [102] = 'Balance',
    [103] = 'Feral',
    [104] = 'Guardian',
    [105] = 'Restoration',

    --Evoker
    [1467] = 'Devastation',
    [1468] = 'Preservation',
    [1473] = 'Augmentation',

    --Hunter
    [253] = 'Beast Mastery',
    [254] = 'Marksmanship',
    [255] = 'Survival',

    --Mage
    [62] = 'Arcane',
    [63] = 'Fire',
    [64] = 'Frost',

    --Monk
    [268] = 'Brewmaster',
    [270] = 'Mistweaver',
    [269] = 'Windwalker',

    --Paladin
    [65] = 'Holy',
    [66] = 'Protection',
    [70] = 'Retribution',

    --Priest
    [256] = 'Discipline',
    [257] = 'Holy',
    [258] = 'Shadow',

    --Rogue
    [259] = 'Assassination',
    [260] = 'Outlaw',
    [261] = 'Subtlety',

    --Shaman
    [262] = 'Elemental',
    [263] = 'Enhancement',
    [264] = 'Restoration',

    --Warlock
    [265] = 'Affliction',
    [266] = 'Demonology',
    [267] = 'Destruction',

    --Warropr
    [71] = 'Arms',
    [72] = 'Fury',
    [73] = 'Protection'

}