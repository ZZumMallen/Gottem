local addonName, core = ...
_G["zGottem"] = core
core.A = {} 

GDDM_DB_OPTIONS = GDDM_DB_OPTIONS or {}
GDDM_DB_OPTIONS.INIT = GDDM_DB_OPTIONS.INIT or {}
GDDM_DB_OPTIONS.NPC = GDDM_DB_OPTIONS.NPC or true
GDDM_DB_OPTIONS.Debug = GDDM_DB_OPTIONS.Debug or false
GDDM_DB_OPTIONS.Animals = GDDM_DB_OPTIONS.Animals or true
GDDM_DB_OPTIONS.Pos = GDDM_DB_OPTIONS.Pos or {0,0}

GDDM_DB_MSG = GDDM_DB_MSG or {}
GDDM_DB_MSG.History = GDDM_DB_MSG.History or {}

GDDM_MY_INFO = GDDM_MY_INFO or {}


 -- clean this up
