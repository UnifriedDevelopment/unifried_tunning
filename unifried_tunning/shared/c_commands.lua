Commands = {}

Commands.Tune = {
    ["Command"] = "tune",
    ["Description"] = "Tune your vehicle!",
    ["TuneNames"] = {
        ["Antilag"] = "antilag",
        ["TwoStep"] = "twostep",
        ["Fuel"]    = "fuel",
        ["Muffler"] = "muffler"
    },
    ["Suggestions"] = {
        ["1"] = {
            ["Name"] = "system",
            ["Help"] = "antilag / twostep / fuel / muffler"
        },
        ["2"] = {
            ["Name"] = "value",
            ["Help"] = "0, 1, 2, 3 etc"
        }
    }
}

Commands.CheckTune = {
    ["Command"] = "checktune",
    ["Description"] = "Tune your vehicle!",
    ["Suggestions"] = {
        ["1"] = {
            ["Name"] = "system",
            ["Help"] = "antilag / twostep / fuel / muffler"
        }
    }
}