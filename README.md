# wow_physicalpercent

Custom code used in conjunction with the weakauras2 addon.
Tracks incomming damage over the last 5 seconds and displays the percent that is physical damage.

Trigger.lua -- called each time a COMBAT_LOG_EVENT_UNFILTERED happens.
Init.lua    -- called once when this weakaura is loaded.
Display.lua -- called every frame by weakauras2 to determine what value to display.
