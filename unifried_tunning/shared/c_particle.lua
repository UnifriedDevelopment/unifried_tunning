Particle = {}

-->> Defines the size of Particle.List
Particle.SmallListSize = 1
Particle.LargeListSize = 1

-->> Defines the flame particle variations
Particle.List = {
    ["Small"] = {
        {["Libary"] = "core", ["Name"] = "veh_sm_car_small_backfire"}
    },
    ["Large"] = {
        {["Libary"] = "core", ["Name"] = "veh_backfire"}
    }
}

-->> Flame Size Parameters
Particle.Parameters = {
    ["NoAction"]   = 0.5, -->> Flame size in which nothing happens
    ["JustSound"]  = 0.8, -->> Flame size which only sound is produced
    ["SmallFlame"] = 1.5  -->> Flame size where the small particle is used
}

-->> If true vehicles can have different flame sizes, if false vehicle mods can increase flame size
Particle.UseVehicles = false

-->> Defines the length of the flame that each mod adds
Particle.Mods = {
    ["Engine"] = 0.2, -->> So a level 4 engine will increase flame size by 0.2 * 4 = 0.8
    ["Fuel"]   = 0.3,
    ["Turbo"]  = 0.5  -->> With the turbo, this value is multiplied by the turbo pressure at that moment
}

-->> Defines flame size for a specific vehicle model or default
Particle.Vehicles = {
    ["Default"] = 2.5,
    ["jester"]  = 4.0 -->> Just an example on how to add a vehicle to the table
}

-->> Vary flame size by RPM
Particle.VarySizeWithRPM = true

-->> Defines the "natural" variation between flames
Particle.VariationDifference = 0.5 * (100) -->> 0.0 for no variation (The * 100 is needed, only change the first value)

