Config = {}

Config.WeedPlant = {}
Config.WeedPlotData=  {}
Config.Weed = {}

Config.Weed.Price = 200
Config.Weed.Ammount = 2
Config.Weed.item = "weed_og-kush"
Config.Weed.RefinedItem = "metalscrap"

Config.WeedPlant.ObjectHash = GetHashKey("prop_weed_01");

Config.WeedPlotData.Size = 5
Config.WeedPlotData.OffsetY = 1.5

-- Weed Refinement Table (Packaging)
Config.WeedRefineTable = {}
Config.WeedRefineTable.Locations = {}
Config.WeedRefineTable.ObjectHash = GetHashKey("prop_tool_bench02");

Config.WeedRefineTable.Locations[0] = {
    x = 1475.0,
    y = 1123.0,
    z = 113.5
}

-- WeedPlots
Config.WeedPlotData.Locations = {}

Config.WeedPlotData.Locations[0] = {
    x = 1462.0,
    y = 1113.0,
    z = 113.0
}
Config.WeedPlotData.Locations[1] = {
    x = 1460.0,
    y = 1113.0,
    z = 113.0
}
