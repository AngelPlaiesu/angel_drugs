-- Dependesies
local QBCore = exports['qb-core']:GetCoreObject()
local QBTarget = exports[Config.Target];

-- RegisterNetEvent

-- Variables
local weedPlots = {}

-- Functions
local function checkIfPlantCreated(WeedPlotTabel)
    for i, crop in ipairs(WeedPlotTabel) do
        if crop == 0 then
            return false
        end
    end
    return true
end

local function createWeedPlant(PlantData)
    local weedPlant = CreateObjectNoOffset(PlantData.ObjectHash, vector3(PlantData.x, PlantData.y, PlantData.z), false);
    if weedPlant == 0 then print("WeedPlantFailed") return false end

    return weedPlant;
end

local function deleteWeedPlot(weedPlot)
    for k, v in pairs(weedPlot) do
        if v ~= 0 then DeleteObject(v) end
    end
    print("WeedPlotDeleted")
    return true;
end

local function createWeedPlot(plotLocation)
    local weedPlot = {};
    local PlantData = {
        x = plotLocation.x,
        y = plotLocation.y,
        z = plotLocation.z,
        ObjectHash = Config.WeedPlant.ObjectHash
    };
    for i = 1, Config.WeedPlotData.Size, 1 do
        PlantData.y = PlantData.y - 1;
        local weedPlant = createWeedPlant(PlantData);
        if weedPlant then weedPlot[#weedPlot+1] = weedPlant else return false end;
    end
    if not checkIfPlantCreated(weedPlot) then
        deleteWeedPlot(weedPlot)
        print("WeedPlotFailed")
        return false;
    end

    return weedPlot;
end

local function createWeedPlots()
    for k,plot in pairs(Config.WeedPlotData.Locations) do
        local weedPlot = createWeedPlot(plot)
        if not createWeedPlot(plot) then return false else
            weedPlots[#weedPlots+1] = weedPlot
        end
    end

    return true
end

-- Handel Events
--[[ RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        if createWeedPlots() then print("WeedPlotCreated") else print("Failed")  end;
end) ]]
local PlantData = {
    x = Config.WeedPlotData.Locations[0].x,
    y = Config.WeedPlotData.Locations[0].y,
    z = Config.WeedPlotData.Locations[0].z,
    ObjectHash = Config.WeedPlant.ObjectHash
}

-- Play Gound
local WeedPlant = createWeedPlant(PlantData)
local WeedPlantId = json.encode(WeedPlant)

-- exports['qb-target']:AddCircleZone("WeedBox")
--[[ createWeedPlots() ]]
local WeedAddBoxZone = exports['qtarget']:AddBoxZone("WeedBox-".. WeedPlantId, vector3(PlantData.x, PlantData.y, PlantData.z), 3, 3, {
	name="WeedBox-".. WeedPlantId,
	heading=11.0,
	debugPoly=false,
    length = 5.0,
    width = 4.0,
	minZ=PlantData.y - 10.0,
	maxZ=PlantData.y + 10.0,
	},
    {
		options = {
			{
                type = "client",
				event = "angel_drugs:weed",
				icon = "fas fa-sign-in-alt",
				label = "Test2",
			},
			{
                type = "client",
				event = "angel_drugs:weed1",
				icon = "fas fa-sign-out-alt",
				label = "Test",
			},
		},
		distance = 3.5,
})

AddEventHandler("angel_drugs:weed", function ()
    print("Passed")
end)
AddEventHandler("angel_drugs:weed1", function ()
    print("Passed")
end)

print(WeedAddBoxZone)