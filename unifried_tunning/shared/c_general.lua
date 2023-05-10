General = {}

General.Framework = "STANDALONE" -->> STANDALONE || ESX || QBCORE
General.Network   = true         -->> Should sounds and flames be networked
General.Debug     = false        -->> Enables Debug Prints

General.ModReferences = {
    ["Exhaust"] = 4,
    ["Engine"]  = 11,
    ["Turbo"]   = 18
}

General.UseStaticMinimumRPM = true -->> Set to false to use Config.DynamicMinimumRPM
General.StaticMinimumRPM    = 0.4  -->> RPM which the exhaust will stop making sound
General.DynamicMinimumRPM   = {
    ["Minimum"] = 0.35, -->> Min RPM that the exhaust will stop making sound
    ["Maximum"] = 0.40  -->> Max RPM that the exhaust wont make any sound
}