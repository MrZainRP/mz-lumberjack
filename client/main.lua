local QBCore = exports['qb-core']:GetCoreObject()
local chopping = false
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local skilled = false
local lvl0 = false
local lvl1 = false 
local lvl2 = false
local lvl3 = false 
local lvl4 = false
local lvl5 = false 
local lvl6 = false
local lvl7 = false 
local lvl8 = false
local treebarkprocess = false
local baggingmulch = false
local woodwedgeprocess = false
local thinlogprocess = false
local midlogprocess = false
local thicklogprocess = false
local thickerlogprocess = false
local makepalletprocess = false
local makemulchbagprocess = false

RegisterNetEvent('mz-lumberjack:getLumberStage', function(stage, state, k)
    Config.TreeLocations[k][stage] = state
end)

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

-----------------
--CHOPPING WOOD--
-----------------

RegisterNetEvent('mz-lumberjack:StartChopping', function()
    for k, v in pairs(Config.TreeLocations) do
        if not Config.TreeLocations[k]["isChopped"] then
            if axe() then
                if Config.Axeskillcheck then 
                    local choptime = math.random(Config.parsetimelow, Config.parsetimehigh)
                    local chopparses = math.random(Config.lowparse, Config.highparse)
                    local skilled = exports['qb-lock']:StartLockPickCircle(chopparses, choptime)
                    if skilled then
                        ChopLumber(k)
                        skilled = false 
                    else
                        if Config.mzskills then 
                            local deteriorate = -Config.skillfailXP
                            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
                            if Config.NotifyType == 'qb' then
                                QBCore.Functions.Notify('-'..Config.skillfailXP.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
                            elseif Config.NotifyType == "okok" then
                                exports['okokNotify']:Alert("SKILLS", '-'..Config.skillfailXP.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
                            end   
                        end
                    end
                else
                    ChopLumber(k)
                end
            end
        end
    end
end)

local function axe()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)
    for k, v in pairs(Config.Axe) do
        if pedWeapon == k then
            return true
        end
    end
    if Config.NotifyType == 'qb' then
        QBCore.Functions.Notify('You do not have an axe...', "error", 3500)
    elseif Config.NotifyType == "okok" then
        exports['okokNotify']:Alert("NO AXE", "You do not have an axe...", 3500, "error")
    end   
end

RegisterNetEvent('mz-lumberjack:XPCheck', function()
    if Config.mzskills then 
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel8, function(hasskill)
            if hasskill then lvl8 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel7, function(hasskill)
            if hasskill then lvl7 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel6, function(hasskill)
            if hasskill then lvl6 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel5, function(hasskill)
            if hasskill then lvl5 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel4, function(hasskill)
            if hasskill then lvl4 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel3, function(hasskill)
            if hasskill then lvl3 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel2, function(hasskill)
            if hasskill then lvl2 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel1, function(hasskill)
            if hasskill then lvl1 = true end
        end)
        exports["mz-skills"]:CheckSkill(Config.LumberSkill, Config.LumberLevel0, function(hasskill)
            if hasskill then lvl0 = true end
        end)
    end
end) 

local finishChopCheck = true 

local function ChopLumber(k)
    local animDict = "melee@hatchet@streamed_core"
    local animName = "plyr_rear_takedown_b"
    local Player = PlayerPedId()
    local choptime = (Config.Choptime * 1000)
    chopping = true
    if Config.mzskills then 
        TriggerEvent('mz-lumberjack:XPCheck')
    end 
    FreezeEntityPosition(Player, true)
    QBCore.Functions.Progressbar("Chopping_Tree", "Chopping tree...", choptime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('mz-lumberjack:setLumberStage', "isChopped", true, k)
        TriggerServerEvent('mz-lumberjack:setLumberStage', "isOccupied", false, k)
        TriggerServerEvent('mz-lumberjack:setChoppedTimer')
        if Config.mzskills then 
            local chance = 1
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, chance)
            if Config.Axebreak then 
                TriggerServerEvent('mz-lumberjack:server:RemoveAxe')
            end
        else 
            if Config.Axebreak then 
                TriggerServerEvent('mz-lumberjack:server:RemoveAxe')
            end
        end
        chopping = false
        ClearPedTasks(Player)
        TaskPlayAnim(Player, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        FreezeEntityPosition(Player, false)
    end, function()
        ClearPedTasks(Player)
        TriggerServerEvent('mz-lumberjack:setLumberStage', "isOccupied", false, k)
        chopping = false
        TaskPlayAnim(Player, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        FreezeEntityPosition(Player, false)
    end)
    TriggerServerEvent('mz-lumberjack:setLumberStage', "isOccupied", true, k)
    CreateThread(function()
        local counter = 2
        while chopping do
            counter = counter - 1
            loadAnimDict(animDict)
            TaskPlayAnim(Player, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(Config.Choptime*1000/6.25)
            loadAnimDict(animDict)
            TaskPlayAnim(Player, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(Config.Choptime*1000/6.25)
            loadAnimDict(animDict)
            TaskPlayAnim(Player, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(Config.Choptime*1000/6.25)
            if counter > 0 and chopping then
                if Config.mzskills then 
                    finishChopCheck = false 
                    if lvl8 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl8', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl7 then
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl7', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl6 then
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl6', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl5 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl5', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl4 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl4', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl3 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl3', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl2 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl2', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl1 then 
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl1', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    elseif lvl0 then  
                        TriggerServerEvent('mz-lumberjack:lumberPayoutlvl0', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    end
                else 
                    TriggerServerEvent('mz-lumberjack:server:lumberPayoutNOXP', finishChopCheck)
                    finishChopCheck = true 
                    Wait(Config.Choptime*1000/26)
                end 
            elseif counter == 0 then 
                chopping = false
                ClearPedTasks(Player)
                TaskPlayAnim(Player, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                FreezeEntityPosition(Player, false)
                if Config.mzskills then 
                    local lvl0 = false
                    local lvl1 = false 
                    local lvl2 = false
                    local lvl3 = false 
                    local lvl4 = false
                    local lvl5 = false 
                    local lvl6 = false
                    local lvl7 = false 
                    local lvl8 = false
                end
                if Config.finalparse then 
                    if Config.mzskills then 
                        finishChopCheck = false 
                        if lvl8 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl8', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl7 then
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl7', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl6 then
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl6', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl5 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl5', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl4 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl4', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl3 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl3', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl2 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl2', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl1 then 
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl1', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        elseif lvl0 then  
                            TriggerServerEvent('mz-lumberjack:lumberPayoutlvl0', finishChopCheck)
                            finishChopCheck = true 
                            Wait(Config.Choptime*1000/26)
                        end
                    else 
                        TriggerServerEvent('mz-lumberjack:server:lumberPayoutNOXP', finishChopCheck)
                        finishChopCheck = true 
                        Wait(Config.Choptime*1000/26)
                    end
                end  
            end
        end
    end)
end

CreateThread(function()
    for k, v in pairs(Config.TreeLocations) do
        exports["qb-target"]:AddBoxZone("trees" .. k, v.coords, 1.6, 1.6, {
            name = "trees" .. k,
            heading = 40,
            minZ = v.coords["z"] - 2,
            maxZ = v.coords["z"] + 2,
            debugPoly = false
        }, {
            options = {
                {
                    action = function()
                        if axe() then
                            if Config.Axeskillcheck then 
                                local choptime = math.random(Config.parsetimelow, Config.parsetimehigh)
                                local chopparses = math.random(Config.lowparse, Config.highparse)
                                local skilled = exports['qb-lock']:StartLockPickCircle(chopparses, choptime)
                                if skilled then
                                    ChopLumber(k)
                                    skilled = false 
                                else
                                    if Config.mzskills then
                                        local deteriorate = -Config.skillfailXP
                                        exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('-'..Config.skillfailXP.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("SKILLS", '-'..Config.skillfailXP.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
                                        end   
                                    end
                                end
                            else
                                ChopLumber(k)
                            end
                        end
                    end,
                    type = "client",
                    event = "mz-lumberjack:StartChopping",
                    icon = "fa fa-hand",
                    label = "Chop tree",
                    canInteract = function()
                        if v["isChopped"] or v["isOccupied"] then
                            return false
                        end
                        return true
                    end,
                }
            },
            distance = 1.1
        })
    end
end)

--------------
--MULCH BARK--
--------------

CreateThread(function()
    exports['qb-target']:AddBoxZone("processwoodparts", vector3(-497.18, 5279.39, 80.61), 2.6, 6.3, {
        name = "processwoodparts",
        heading = 340,
        debugPoly = false,
        minZ = 78.41,
        maxZ = 82.41,
        }, {
            options = { 
            {
                num = 1, 
                type = "client",
                event = "mz-lumberjack:client:MulchBark",
                icon = 'fas fa-tree',
                label = 'Mulch Bark'
            },
            {
                num = 2, 
                type = "client",
                event = "mz-lumberjack:client:BagMulch",
                icon = 'fas fa-shopping-bag',
                label = 'Bag Mulch'
            },
            {
                num = 3, 
                type = "client",
                event = "mz-lumberjack:client:ProcessWoodWedge",
                icon = 'fas fa-tools',
                label = 'Process Log Wedges'
            },
            {
                num = 4,
                type = "client",
                event = "mz-lumberjack:client:ProcessThinLogs",
                icon = 'fas fa-tools',
                label = 'Process Thin Pine Logs'
            },
            {
                num = 5, 
                type = "client",
                event = "mz-lumberjack:client:ProcessMidLogs",
                icon = 'fas fa-tools',
                label = 'Process Medium Pine Logs'
            },
            {
                num = 6,
                type = "client",
                event = "mz-lumberjack:client:ProcessThickLogs",
                icon = 'fas fa-tools',
                label = 'Process Thick Pine Logs'
            },
            {
                num = 7,
                type = "client",
                event = "mz-lumberjack:client:ProcessThickerLogs",
                icon = 'fas fa-tools',
                label = 'Process Thicker Pine Logs'
            },
            {
                num = 8,
                type = "client",
                event = "mz-lumberjack:client:MakePallet",
                icon = 'fas fa-tools',
                label = 'Make Pallet'
            },
            
        },
        distance = 1.5,
     })
end)

RegisterNetEvent('mz-lumberjack:client:MulchBark', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("treebark") then
            TriggerServerEvent("mz-lumberjack:server:MulchBark")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["treebark"]["name"], image = QBCore.Shared.Items["treebark"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need bark to mulch...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED TREE BARK", "You need bark to mulch...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:MulchBarkMinigame', function(source)
    treebarkprocess = true
    MulchBarkMinigame(source)
end)

function MulchBarkMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"}) 
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.barklow, Config.barkhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:MulchBarkProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin to process the bark into mulch.', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("MULCHING BARK", "You begin to process the bark into mulch.", 3500, "success")
            end
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1200, 1600),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
    if Config.NotifyType == 'qb' then
        QBCore.Functions.Notify('The bark breaks into unuseable pieces...', "error", 3500)
    elseif Config.NotifyType == "okok" then
        exports['okokNotify']:Alert("BARK RUINED", "The bark breaks into unuseable pieces...", 3500, "error")
    end
    if Config.mzskills then
        Wait(500)
        local deteriorate = -Config.mulchXPloss
        exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('-'..Config.mulchXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("SKILLS", '-'..Config.mulchXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
        end
    end
    treebarkprocess = false
    FailedAttemps = 0
    SucceededAttempts = 0
    NeededAttempts = 0
    craftprocesscheck = false
    ClearPedTasks(PlayerPedId())
    end)
end

local mulchCheck = true 

RegisterNetEvent('mz-lumberjack:client:MulchBarkProcess', function()
    treebarkprocess = true
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    local mulchtime = math.random(Config.mulchtimelow*1000, Config.mulchtimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Grinding bark into mulch...", mulchtime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        mulchCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetMulch", mulchCheck)
        mulchCheck = true 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        treebarkprocess = false
        Wait(1000)
        if Config.mzskills then   
            Wait(500)
            local BetterXP = math.random(Config.mulchXPlow, Config.mulchXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.mulchXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)
        end
    end, function() -- Cancel
        treebarkprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

-------------
--BAG MULCH--
-------------

RegisterNetEvent('mz-lumberjack:client:BagMulch', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("treemulch") and QBCore.Functions.HasItem("emptymulchbag") then
            TriggerServerEvent("mz-lumberjack:server:BagMulch")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["treemulch"]["name"], image = QBCore.Shared.Items["treemulch"]["image"]}, 
                [2] = {name = QBCore.Shared.Items["emptymulchbag"]["name"], image = QBCore.Shared.Items["emptymulchbag"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need a bag and some mulch...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED MATERIALS", "You need a bag and some mulch...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end 
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:BagMulchMinigame', function(source)
    baggingmulch = true 
    BagMulchMinigame(source)
end)

function BagMulchMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.mulchlow, Config.mulchhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:BagMulchProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin bagging up the mulch...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("BAGGING MULCH", "You begin bagging up the mulch...", 3500, "success")
            end   
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1400, 1600),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You tear a hole in the bag... Nice work...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("BAG RUINED", "You tear a hole in the bag... Nice work...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.bagmulchXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.bagmulchXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.bagmulchXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end  
        end
        baggingmulch = false
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local baggedCheck = true 

RegisterNetEvent('mz-lumberjack:client:BagMulchProcess', function()
    baggingmulch = true 
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    local bagmulchtime = math.random(Config.bagmulchtimelow*1000, Config.bagmulchtimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Bagging mulch...", bagmulchtime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        baggingmulch = false 
        baggedCheck = false
        TriggerServerEvent("mz-lumberjack:server:GetBaggedMulch", baggedCheck)
        baggedCheck = true
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then
            Wait(500)
            local BetterXP = math.random(Config.bagmulchXPlow, Config.bagmulchXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.bagmulchXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)
        end
    end, function() -- Cancel
        baggingmulch = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

-------------------------
--PROCESS WOODEN WEDGES--
-------------------------

RegisterNetEvent('mz-lumberjack:client:ProcessWoodWedge', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("woodwedge") then
            TriggerServerEvent("mz-lumberjack:server:ProcessWoodWedge")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["woodwedge"]["name"], image = QBCore.Shared.Items["woodwedge"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need wooden wedges to process...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED WEDGES", "You need wooden wedges to process...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:ProcessWoodWedgeMinigame', function(source)
    woodwedgeprocess = true
    ProcessWoodWedgeMinigame(source)
end)

function ProcessWoodWedgeMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.wedgelow, Config.wedgehigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:ProcessWoodWedgeProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin processing the wooden wedges into planks...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("PROCESSING WOOD", "You begin processing the wooden wedges into planks...", 3500, "success")
            end 
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1400, 1600),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        woodwedgeprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Your hand slips and the wedges are ruined...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("WEDGES RUINED", "Your hand slips and the wedges are ruined...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.wedgeXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.wedgeXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.wedgeXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end  
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local planksCheck = true 

RegisterNetEvent('mz-lumberjack:client:ProcessWoodWedgeProcess', function()
    woodwedgeprocess = true
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local wedgetime = math.random(Config.wedgetimelow*1000, Config.wedgetimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Cutting wedges to size...", wedgetime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        woodwedgeprocess = false
        planksCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetPlanks", planksCheck)
        planksCheck = true 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then  
            Wait(500)
            local BetterXP = math.random(Config.wedgeXPlow, Config.wedgeXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.wedgeXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)
        end
    end, function() -- Cancel
        woodwedgeprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

---------------------
--PROCESS THIN LOGS--
---------------------

RegisterNetEvent('mz-lumberjack:client:ProcessThinLogs', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("thinlog") then
            TriggerServerEvent("mz-lumberjack:server:ProcessThinLogs")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["thinlog"]["name"], image = QBCore.Shared.Items["thinlog"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need thin logs to process...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED THIN LOGS", "You need thin logs to process...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end
    end   
end)

RegisterNetEvent('mz-lumberjack:client:ProcessThinLogsMinigame', function(source)
    thinlogprocess = true
    ProcessThinLogsMinigame(source)
end)

function ProcessThinLogsMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.thinlow, Config.thinhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:ProcessThinLogsProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You sculpt your thin logs...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("PROCESSING THIN LOGS", "You sculpt your thin logs...", 3500, "success")
            end   
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1200, 1500),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
            thinlogprocess = false
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You cut too deep and ruin the thing logs...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("THIN LOGS RUINED", "You cut too deep and ruin the thing logs...", 3500, "error")
            end
            if Config.mzskills then
                Wait(500)
                local deteriorate = -Config.thinXPloss
                exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
                if Config.NotifyType == 'qb' then
                    QBCore.Functions.Notify('-'..Config.thinXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
                elseif Config.NotifyType == "okok" then
                    exports['okokNotify']:Alert("SKILLS", '-'..Config.thinXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
                end  
            end 
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            craftprocesscheck = false
            ClearPedTasks(PlayerPedId())
    end)
end

local thinPlanksCheck = true 

RegisterNetEvent('mz-lumberjack:client:ProcessThinLogsProcess', function()
    thinlogprocess = true
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local thinlogstime = math.random(Config.thintimelow*1000, Config.thintimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Processing Thin logs...", thinlogstime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        thinlogprocess = false
        thinPlanksCheck = false  
        TriggerServerEvent("mz-lumberjack:server:GetThinPlanks", thinPlanksCheck)
        thinPlanksCheck = true 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then
            Wait(500)
            local BetterXP = math.random(Config.thinXPlow, Config.thinXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.thinXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)
        end
    end, function() -- Cancel
        thinlogprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

--------------------
--PROCESS MID LOGS--
--------------------

RegisterNetEvent('mz-lumberjack:client:ProcessMidLogs', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("midlog") then
            TriggerServerEvent("mz-lumberjack:server:ProcessMidLogs")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["midlog"]["name"], image = QBCore.Shared.Items["midlog"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need Medium Pine Logs to process...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED MEDIUM PINE", "You need Medium Pine Logs to process...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:ProcessMidLogsMinigame', function(source)
    midlogprocess = true
    ProcessMidLogsMinigame(source)
end)

function ProcessMidLogsMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.midlow, Config.midhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:ProcessMidLogsProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin processing the medium pine logs.', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("PROCESSING MEDIUM LOGS", "You begin processing the medium pine logs.", 3500, "success")
            end  
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1200, 1500),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        midlogprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You cut too deep and ruin the medium logs...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("MEDIUM PINE RUINED", "You cut too deep and ruin the medium logs...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.midXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.midXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.midXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end  
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local mediumPlanksCheck = true 

RegisterNetEvent('mz-lumberjack:client:ProcessMidLogsProcess', function()
    midlogprocess = true
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local midpinetime = math.random(Config.midtimelow*1000, Config.midtimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Processing medium pine logs...", midpinetime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        midlogprocess = false
        mediumPlanksCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetMediumPlanks", mediumPlanksCheck)
        mediumPlanksCheck = true 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then 
            Wait(500)
            local BetterXP = math.random(Config.midXPlow, Config.midXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.midXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)
        end 
    end, function() -- Cancel
        midlogprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

----------------------
--PROCESS THICK LOGS--
----------------------

RegisterNetEvent('mz-lumberjack:client:ProcessThickLogs', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("thicklog") then
            TriggerServerEvent("mz-lumberjack:server:ProcessThickLogs")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["thicklog"]["name"], image = QBCore.Shared.Items["thicklog"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need thick pine logs...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED THICK PINE", "You need thick pine logs...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:ProcessThickLogsMinigame', function(source)
    thicklogprocess = true 
    ProcessThickLogsMinigame(source)
end)

function ProcessThickLogsMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.thicklow, Config.thickhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            ProcessThickLogsProcess()
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You carefully cut through the thick pine logs...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("PROCESSING THICK PINE", "You carefully cut through the thick pine logs...", 3500, "success")
            end
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1200, 1500),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        thicklogprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You cut the logs too deep and ruin them...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("THICK LOGS RUINED", "You cut the logs too deep and ruin them...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.thickXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.thickXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.thickXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end  
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local thickPlanksCheck = true

RegisterNetEvent('mz-lumberjack:client:ProcessThickLogsProcess', function()
    thicklogprocess = true 
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local thicktime = math.random(Config.thicktimelow*1000, Config.thicktimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Processing thick pine logs...", thicktime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        thicklogprocess = false
        thickPlanksCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetThickPlanks", thickPlanksCheck)
        thickPlanksCheck = true
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then
            Wait(500)
            local BetterXP = math.random(Config.thickXPlow, Config.thickXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.thickXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)   
        end
    end, function() -- Cancel
        thicklogprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

------------------------
--PROCESS THICKER LOGS--
------------------------

RegisterNetEvent('mz-lumberjack:client:ProcessThickerLogs', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then     
        if QBCore.Functions.HasItem("thickerlog") then
            TriggerServerEvent("mz-lumberjack:server:ProcessThickerLogs")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["thickerlog"]["name"], image = QBCore.Shared.Items["thickerlog"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need thicker pine logs to process...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED THICKER LOGS", "You need thicker pine logs to process...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:ProcessThickerLogsMinigame', function(source)
    thickerlogprocess = true 
    ProcessThickerLogsMinigame(source)
end)

function ProcessThickerLogsMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.thickerlow, Config.thickerhigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            ProcessThickerLogsProcess()
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin to process the thicker pine log...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("PROCESSING THICKER LOG", "You begin to process the thicker pine log...", 3500, "success")
            end 
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1300, 1500),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        thickerlogprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You cut the logs too deep and ruin them...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("THICKER LOGS RUINED", "You cut the logs too deep and ruin them...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.thickerXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.thickerXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.thickerXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end 
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local thickerPlankCheck = true

RegisterNetEvent('mz-lumberjack:client:ProcessThickerLogsProcess', function()
    thickerlogprocess = true 
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    local thickertime = math.random(Config.thickertimelow*1000, Config.thickertimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Processing thicker logs...", thickertime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        thickerlogprocess = false
        thickerPlankCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetThickerPlanks", thickerPlankCheck)
        thickerPlankCheck = true  
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then  
            Wait(500)
            local BetterXP = math.random(Config.thickerXPlow, Config.thickerXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.thickerXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)   
        end
    end, function() -- Cancel
        thickerlogprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

---------------
--MAKE PALLET--
---------------

RegisterNetEvent('mz-lumberjack:client:MakePallet', function()
    if not treebarkprocess and not baggingmulch and not woodwedgeprocess and not thinlogprocess and not midlogprocess and not thicklogprocess and not thickerlogprocess and not makepalletprocess then 
        if QBCore.Functions.HasItem("rustynails") and QBCore.Functions.HasItem("woodenplanks") then
            TriggerServerEvent("mz-lumberjack:server:MakePallet")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["woodenplanks"]["name"], image = QBCore.Shared.Items["woodenplanks"]["image"]}, 
                [2] = {name = QBCore.Shared.Items["rustynails"]["name"], image = QBCore.Shared.Items["rustynails"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need some planks and nails...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED PLANKS AND NAILS", "You need some planks and nails...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end    
end)

RegisterNetEvent('mz-lumberjack:client:MakePalletMinigame', function(source)
    makepalletprocess = true
    MakePalletMinigame(source)
end)

function MakePalletMinigame(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"hammer"})
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.palletlow, Config.pallethigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1800),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerEvent('mz-lumberjack:client:MakePalletProcess')
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You start building a wooden pallet...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("BUILDING PALLET", "You start building a wooden pallet...", 3500, "success")
            end   
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1300, 1600),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        makepalletprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You bash through the wooden plank and drop your nails...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("MATERIALS RUINED", "You bash through the wooden plank and drop your nails...", 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.palletXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.palletXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.palletXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end 
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local palletCheck = true 

RegisterNetEvent("mz-lumberjack:client:MakePalletProcess", function()
    makepalletprocess = true
    TriggerEvent('animations:client:EmoteCommandStart', {"hammer"})
    local pallettime = math.random(Config.pallettimelow*1000, Config.pallettimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Making pallet...", pallettime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        palletCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetPallet", palletCheck)
        palletCheck = true 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then
            Wait(500)
            local BetterXP = math.random(Config.palletXPlow, Config.palletXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.palletXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)   
        end 
        makepalletprocess = false
    end, function() -- Cancel
        makepalletprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end)

--------------
--MULCH BAGS--
--------------

CreateThread(function()
    exports['qb-target']:AddBoxZone("makemulchbag", vector3(718.98, -963.44, 30.4), 1.7, 1.2, {
        name = "makemulchbag",
        heading = 90,
        debugPoly = false,
        minZ = 29.00,
        maxZ = 31.00,
        }, {
            options = { 
            {
                type = "client",
                event = "mz-lumberjack:client:MakeMulchBags",
                icon = 'fas fa-shopping-bag',
                label = 'Make Mulch Bag'
            },
        },
        distance = 1.5,
     })
end)

RegisterNetEvent('mz-lumberjack:client:MakeMulchBags', function()
    if not makemulchbagprocess then 
        if QBCore.Functions.HasItem("plastic") then
            TriggerServerEvent("mz-lumberjack:server:MakeMulchBags")
        else
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["plastic"]["name"], image = QBCore.Shared.Items["plastic"]["image"]}, 
            }  
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You need plastic to make mulch bags...', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEED PLASTIC", "You need plastic to make mulch bags...", 3500, "error")
            end   
            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            Wait(3000)
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('You are already doing something... Slow down!', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("CONCENTRATE", 'You are already doing something... Slow down!', 3500, "error")
        end   
    end
end)

RegisterNetEvent('mz-lumberjack:client:MakeMulchBagsMinigame', function(source)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
    makemulchbagprocess = true
    if Config.ProcessMaterialCheck then 
        MakeMulchBagsMinigame(source)
    else 
        BreakBottlesProcess()
    end 
end)

function MakeMulchBagsMinigame(source)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(Config.plasticlow, Config.plastichigh)
    end
    local maxwidth = 30
    local maxduration = 3000
    Skillbar.Start({
        duration = math.random(1400, 1900),
        pos = math.random(15, 30),
        width = math.random(13, 17),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            BreakBottlesProcess()
            Wait(500)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('You begin sewing together mulch bag...', "success", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("MAKING MULCH BAG", 'You begin sewing together mulch bag...', 3500, "success")
            end   
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1200, 1500),
                pos = math.random(10, 30),
                width = math.random(11, 12),
            })
        end
    end, function()
        makemulchbagprocess = false
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Your hand slips and you tear through the plastic...', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("PLASTIC TORN", 'Your hand slips and you tear through the plastic...', 3500, "error")
        end
        if Config.mzskills then
            Wait(500)
            local deteriorate = -Config.plasticXPloss
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, deteriorate)
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify('-'..Config.plasticXPloss.. 'XP to '..Config.LumberSkill..'.', "error", 3500)
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("SKILLS", '-'..Config.plasticXPloss.. 'XP to '..Config.LumberSkill..'.', 3500, "error")
            end 
        end
        FailedAttemps = 0
        SucceededAttempts = 0
        NeededAttempts = 0
        craftprocesscheck = false
        ClearPedTasks(PlayerPedId())
    end)
end

local mulchbagCheck = true

function BreakBottlesProcess()
    local mulchbagtime = math.random(Config.plastictimelow*1000, Config.plastictimehigh*1000)
    QBCore.Functions.Progressbar("grind_coke", "Making mulch bag...", mulchbagtime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        mulchbagCheck = false 
        TriggerServerEvent("mz-lumberjack:server:GetMulchBag", mulchbagCheck)
        mulchbagCheck = true
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        Wait(1000)
        if Config.mzskills then
            Wait(500)
            local BetterXP = math.random(Config.plasticXPlow, Config.plasticXPhigh)
            local multiplier = math.random(1, 4)
            if multiplier >= 3 then
                skillup = BetterXP
            else
                skillup = Config.plasticXPlow
            end
            exports["mz-skills"]:UpdateSkill(Config.LumberSkill, skillup)   
        end 
        makemulchbagprocess = false
    end, function() -- Cancel
        makemulchbagprocess = false
        ClearPedTasks(PlayerPedId())
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify('Process Cancelled', "error", 3500)
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("TASK STOPPED", "Process Cancelled", 3500, "error")
        end 
    end)
end

--------------
--SELL ITEMS--
--------------

CreateThread(function()
    exports['qb-target']:AddBoxZone("selllumberitems", vector3(2029.41, 4981.0, 42.1), 1.1, 0.8, {
        name = "selllumberitems",
        heading = 313,
        debugPoly = false,
        minZ = 39.1,
        maxZ = 43.1,
        }, {
            options = { 
            {
                type = "client",
                event = "mz-lumberjack:client:menuSelect",
                icon = 'fas fa-dollar-sign',
                label = 'Sell Merchandise'
            },
        },
        distance = 2,
     })
end)

RegisterNetEvent('mz-lumberjack:client:menuSelect', function()
    local waittime = 3500
    TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
    QBCore.Functions.Progressbar("smoke_joint", "Anyone home...", waittime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Wait(1000)
        TriggerEvent('animations:client:EmoteCommandStart', {"cop"})
        TriggerEvent('mz-lumberjack:client:openMenu')
    end)
end)

RegisterNetEvent('mz-lumberjack:client:openMenu', function()
    local pawnShop = {
        {
            header = "TJ's Warehouse Acquisitions",
            isMenuHeader = true,
        },
        {
            header = "We buy all of your...",
            txt = "... lumber and lumber related products!",
            params = {
                event = "mz-lumberjack:client:openPawn",
                args = {
                    items = Config.LumberItems
                }
            }
        }
    }
    exports['qb-menu']:openMenu(pawnShop)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNetEvent('mz-lumberjack:client:openPawn', function(data)
    QBCore.Functions.TriggerCallback('mz-lumberjack:server:getInv', function(inventory)
        local PlyInv = inventory
        local pawnMenu = {
            {
                header = "TJ's Warehouse Acquisitions",
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    pawnMenu[#pawnMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = Lang:t('info.sell_items', { value = data.items[i].price }),
                        params = {
                            event = 'mz-lumberjack:client:pawnitems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = data.items[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end
        pawnMenu[#pawnMenu + 1] = {
            header = Lang:t('info.back'),
            params = {
                event = 'mz-lumberjack:client:openMenu'
            }
        }
        exports['qb-menu']:openMenu(pawnMenu)
    end)
end)

RegisterNetEvent('mz-lumberjack:client:pawnitems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = Lang:t('info.title'),
        submitText = Lang:t('info.sell'),
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = Lang:t('info.max', { value = item.amount })
            }
        }
    })
    if sellingItem then
        if not sellingItem.amount then
            return
        end
        if tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('mz-lumberjack:server:sellTrashItems', item.name, sellingItem.amount, item.price)
        else
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NEGATIVE?", "You cannot sell a negative amount...", 3500, "error")
            end 
        end
    end
end)

---------
--BLIPS--
---------

CreateThread(function()
    for _, value in pairs(Config.LumberLocation) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, 77)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Mavro's Lumber")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    for _, value in pairs(Config.SellLocation) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, 375)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("TJ's Warehouse Acquisitions")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    for _, value in pairs(Config.ProcessLocation) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, 365)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 10)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Lumber Processing")
        EndTextCommandSetBlipName(blip)
    end
end)