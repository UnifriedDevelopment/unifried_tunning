    --[[
        **WHEN CHANGING TIMERS BE AWARE OF THE PERFORMANCE COST**
    ]]--

Timers = {}

-->> Defines the default wait  period between checks
Timers.Default = {
    ["Minimum"] = 1000,
    ["Maximum"] = 1500
}

Timers.SafeWait = 50 -->> Added to the flame wait to prevent overloading the game

-->> Defines the wait period for guard clauses that expect a change in a couple hundred ms
Timers.ShorterWait = 500

-->> Defines the wait time for guard clauses that check for conditions that shouldn't change very couple of hundred ms
Timers.LongerWait = 5000

-->> Defines the Wait time when using antilag
Timers.Antilag = {
    ["Default"] = {
        ["Minimum"] = 1000,
        ["Maximum"] = 1500
    },
    [0] = {
        ["Minimum"] = 750,
        ["Maximum"] = 1000
    },
    [1] = {
        ["Minimum"] = 500,
        ["Maximum"] = 750
    },
    [2] = {
        ["Minimum"] = 250,
        ["Maximum"] = 500
    },
    [3] = {
        ["Minimum"] = 100,
        ["Maximum"] = 250
    },
    [4] = {
        ["Minimum"] = 100,
        ["Maximum"] = 200
    },
    [5] = {
        ["Minimum"] = 100,
        ["Maximum"] = 150
    }
}
