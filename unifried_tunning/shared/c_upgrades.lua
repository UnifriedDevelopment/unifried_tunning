Upgrades = {}

Upgrades.Antilag = {}
Upgrades.Fuel    = {}
Upgrades.Twostep = {}
Upgrades.Muffler = {}

------------------------------->> Antilag CONFIG <<------------------------------->>

-->> Enables or disables the use of antilag
Upgrades.Antilag.Enabled = 1 -->> 0 turns antilag off & 1 turns it on

-->> Defines the minimum and maximum antilag levels (Should match Timers.Antilag)
Upgrades.Antilag.Levels = {
    ["Minimum"] = 0,
    ["Maximum"] = 5
}

-->> Set turbo pressure to max pressure when antilag is active
Upgrades.Antilag.PinTurbo    = true
Upgrades.Antilag.MaxPressure = 1.0

------------------------------->> Fuel CONFIG <<------------------------------->>

-->> Enables or disables the use of fuel tuning
Upgrades.Fuel.Enabled = 1 -->> 0 turns fuel tuning off & 1 turns it on

-->> Defines the minimum and maximum fuel tuning levels
Upgrades.Fuel.Levels = {
    ["Minimum"] = 0,
    ["Maximum"] = 5
}

------------------------------->> Twostep CONFIG <<------------------------------->>

-->> Enables or disables the use of twostep
Upgrades.Twostep.Enabled = 1 -->> 0 turns twostep off & 1 turns it on

-->> Defines the minimum and maximum twostep levels
Upgrades.Twostep.Levels = {
    ["Minimum"] = 0,
    ["Maximum"] = 5
}

-->> Changes the RPM at which 2Step kicks in at different levels
Upgrades.Twostep.LevelRPM = {
    ["Default"] = 0.98,
    [0] = 0.97,
    [1] = 0.96,
    [2] = 0.95,
    [3] = 0.94,
    [4] = 0.93,
    [5] = 0.92
}

------------------------------->> Muffler CONFIG <<------------------------------->>

-->> Enables or disables the use of mufflers
--[[
    **WHEN ENABLED, CARS WILL NOT DO ANYTHING UNTIL THE MUFFLER IS REMOVED**
]]--
Upgrades.Muffler.Enabled = 1 -->> 0 turns mufflers off & 1 turns it on