[Mayron Wow Addons Series](https://www.youtube.com/watch?v=2G4iKA1m0FA&list=PL3wt7cLYn4N-3D3PTTUZBM2t1exFmoA2G&index=8)

# Saved Variables Path

# Holy shit
- Disable in combat
- Disable in a an instance
- save recent position

# CreateFrame Args:
```lua
local UIConfig = CreateFrame("Frame", "ZUI_MythicFrame", UIParent, "BasicFrameTemplateWithInset");

UIConfig.title

UIConfig is a widget

title is a key that is being added to the table followed with a font string
thinking like

UIConfig = {
    title,"font string"
}





```
1. type of frame is "Frame"
2. Global frame name is 'ZUI_MythicFrame'
3. Parent frame is **NOT** a string
4. Comma separated list (string list) of xml Templates to inherit from

# RelativePoint vals:
- TOPLEFT
- TOP
- TOPRIGHT
- LEFT
- CENTER
- BOTTOMLEFT
- BOTTOM
- BOTTOMRIGHT


To make use of this library you'll need to also have the usual LibStub and LibCallbackHandler libs.

For a real usage example, take a look at the RaidChecklist project.