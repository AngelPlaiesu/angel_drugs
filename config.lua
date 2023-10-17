Config = {}
Config.WeedPlant = {}
Config.WeedPlotData=  {}

Config.WeedPlant.ObjectHash = GetHashKey("prop_weed_01");

Config.WeedPlotData.Size = 5

Config.WeedPlotData.Locations = {}

Config.WeedPlotData.Locations[0] = {
    x = 1462.0,
    y = 1113.0,
    z = 113.0
}
Config.WeedPlotData.Locations[1] = {
    x = 1461.0,
    y = 1113.0,
    z = 113.0
}

Config.WeedPlotData.Locations[2] = {
    x = 1469.0,
    y = 1103.0,
    z = 113.0
}

Config.WeedPlotData.Locations[3] = {
    x = 1470.0,
    y = 1100.0,
    z = 113.0
}

--[[ Config.WeedPlant.BoxZoneConfig({
    width = 1,
    heigth =1,
    options = {},
    menu = {
            options = {
                {
                    type = "client",
                    event = "angel_drugs:weedPickUp",
                    icon = "fas fa-hand-holding-water",
                    label = "Test2",
                },
            },
            distance = 2.0,
    }
}) ]]