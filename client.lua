-- Dependesies
local QBCore = exports['qb-core']:GetCoreObject()
local QBTarget = exports['qtarget'];
-- RegisterNetEvent

-- Variables
local weedPlots = {}
local refineTables = {}

-- Functions
local function checkIfPlantCreated(WeedPlotTabel)
    for i, crop in ipairs(WeedPlotTabel) do
        if crop == 0 then
            return false
        end
    end
    return true
end

local function uuid()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

--weed:
local function createWeedBoxZone(weedPlantCords)
    local boxZoneID = uuid();

    local WeedAddBoxZoneCords = vector3(weedPlantCords.x, weedPlantCords.y, weedPlantCords.z) + vector3(0, 0, 1.5)

    local WeedAddBoxZone = QBTarget:AddBoxZone("WeedBox-" .. boxZoneID, WeedAddBoxZoneCords, 1, 1, {
            name = "WeedBox-" .. boxZoneID,
            heading = 11.0,
            debugPoly = true,
            minZ = weedPlantCords.z,
            maxZ = weedPlantCords.z + 2,
        },
        {
            options = {
                {
                    type = "client",
                    event = "angel_drugs:weedPickUp",
                    icon = "fas fa-hand-holding-water",
                    label = "Test2",
                },
            },
            distance = 2.0,
        })
    return WeedAddBoxZone
end

local function createWeedPlant(plantData)
    local weedPlatCords = vector3(plantData.x, plantData.y, plantData.z)
    local weedPlant = CreateObjectNoOffset(Config.WeedPlant.ObjectHash, weedPlatCords, false);
    if weedPlant == 0 then
        print("WeedPlantFailed")
        return false
    end
    local BoxZone = createWeedBoxZone(weedPlatCords);
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
    };
    for i = 1, Config.WeedPlotData.Size, 1 do
        PlantData.y = PlantData.y - Config.WeedPlotData.OffsetY;
        local weedPlant = createWeedPlant(PlantData);
        if weedPlant then weedPlot[#weedPlot + 1] = weedPlant else return false end;
    end
    if not checkIfPlantCreated(weedPlot) then
        deleteWeedPlot(weedPlot)
        print("WeedPlotFailed")
        return false;
    end

    return weedPlot;
end

local function createWeedPlots()
    for k, plot in pairs(Config.WeedPlotData.Locations) do
        local weedPlot = createWeedPlot(plot)
        if not weedPlot then return false end;
        weedPlots[#weedPlots + 1] = weedPlot
    end

    return true
end

--Tables:
local function createTableBoxZone(tableCords)
    local boxZoneID = uuid();

    local RefineTableBoxCords = vector3(tableCords.x, tableCords.y, tableCords.z) + vector3(0, 0, .2)

    local RefineTableBoxZone = QBTarget:AddBoxZone("RefineTable-" .. boxZoneID, RefineTableBoxCords, 2, 1, {
            name = "RefineTable-" .. boxZoneID,
            heading = 11.0,
            debugPoly = true,
            minZ = tableCords.z,
            maxZ = tableCords.z + 1,
        },
        {
            options = {
                {
                    type = "client",
                    event = "angel_drugs:refineWeed",
                    icon = "fas fa-hand-holding-water",
                    label = "Refine Weed",
                },
            },
            distance = 2.0,
        })

    return RefineTableBoxZone
end

local function createRefineTable(tableData)
    local tableCords = vector3(tableData.x, tableData.y, tableData.z)
    local refineTable = CreateObjectNoOffset(Config.WeedRefineTable.ObjectHash, tableCords, false);
    if refineTable == 0 then
        print("WeedPlantFailed")
        return false
    end
    local BoxZone = createTableBoxZone(tableCords);
    return refineTable;
end

local function createRefineTables()
    for k, cords in pairs(Config.WeedRefineTable.Locations) do
        local table = createRefineTable(cords)
        if not table then return false end;
        refineTables[#refineTables + 1] = table
    end

    return true
end

-- Handel Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if createWeedPlots() then print("WeedPlotsCreated") else print("WeedPlots: Failed") end;
    if createRefineTables() then print("RefineTablesCreated") else print("RefineTables: Failed") end;
end)

AddEventHandler("angel_drugs:weedPickUp", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.money.cash > Config.Weed.Price then
        QBCore.Functions.Progressbar('WeedPickUp', 'Collecting Weed', 2000, false, true, {

            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false
        }, {}, {}, {}, function()
            TriggerServerEvent('angel_drugs:WeedPickUp:Server', PlayerData.source)
        end, function()
            return -- progres fails
        end)
    end
end)

AddEventHandler("angel_drugs:refineWeed", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if QBCore.Functions.HasItem(Config.Weed.item) then
        QBCore.Functions.Progressbar('WeedRefine', 'Refine-ing Weed', 2000, false, true, {

            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false
        }, {}, {}, {}, function()
            TriggerServerEvent('angel_drugs:refineWeed:Server', PlayerData.source)
        end, function()
            return -- progres fails
        end)
    end
    return;
end)
