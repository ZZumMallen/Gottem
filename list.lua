---@diagnostic disable: undefined-field
local _, core = ...;
local L = core.C

if not L.PartyList then L.PartyList = {} end

print("List Loaded")

-- party list
L.PartyList = {
    [1] = "PLAYER",
    [2] = "PARTY1",
    [3] = "PARTY2",
    [4] = "PARTY3",
    [5] = "PARTY4",
}

L.JakeList = {
    "Whomptilizer",--
    "Amelioration",--
    "Gusthebus",--
    "chungtesta",--
    "Palmface",
    "Sedition",
    "Jakeofcats",
    "lucilletwo",
    "cryinggame",
    "madys",
    "manimal",
    "Jacobcats",
    "Brownnote"
}


-- list of specs by specID
L.SpecList = {

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
