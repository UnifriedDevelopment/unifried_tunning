Items = {}

-->> Enable or Disable items
Items.Enable = false

-->> Define the item needed for each upgrade ("" means no item)
Items.UpgradeItem = {
    ["muffler"] = "",
    ["twostep"] = {
        [0] = "",
        [1] = "",
        [2] = "",
        [3] = "",
        [4] = "",
        [5] = ""
    },
    ["antilag"] = {
        [0] = "",
        [1] = "",
        [2] = "",
        [3] = "",
        [4] = "",
        [5] = ""
    },
    ["fuel"] = {
        [0] = "",
        [1] = "",
        [2] = "",
        [3] = "",
        [4] = "",
        [5] = ""
    }
}

-->> Defines which upgrades remove items (True means an item is removed)
Items.UseItem = {
    ["muffler"] = false,
    ["twostep"] = false,
    ["antilag"] = false,
    ["fuel"]    = false
}
