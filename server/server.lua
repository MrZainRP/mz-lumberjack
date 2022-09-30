local QBCore = exports['qb-core']:GetCoreObject()

local Chopped = false

local ItemList = {
    ["treebark"] = "treebark",
    ["treemulch"] = "treemulch",
    ["woodwedge"] = "woodwedge",
    ["thinlog"] = "thinlog",
    ["midlog"] = "midlog",
    ["thicklog"] = "thicklog",
    ["thickerlog"] = "thickerlog",
    ["woodenplanks"] = "woodenplanks",
    ["rustynails"] = "rustynails",
}

-------------
--FUNCTIONS--
-------------

QBCore.Functions.CreateCallback('mz-lumberjack:axe', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("weapon_battleaxe") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterNetEvent('mz-lumberjack:setLumberStage', function(stage, state, k)
    Config.TreeLocations[k][stage] = state
    TriggerClientEvent('mz-lumberjack:getLumberStage', -1, stage, state, k)
end)

RegisterNetEvent('mz-lumberjack:setChoppedTimer', function()
    if not Chopped then
        Chopped = true
        CreateThread(function()
            Wait(Config.Timeout)
            for k, v in pairs(Config.TreeLocations) do
                Config.TreeLocations[k]["isChopped"] = false
                TriggerClientEvent('mz-lumberjack:getLumberStage', -1, 'isChopped', false, k)
            end
            Chopped = false
        end)
    end
end)

QBCore.Functions.CreateCallback('mz-lumberjack:lumber', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("tree_lumber") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
end)

-------------
--AXE BREAK--
-------------

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl0', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= Config.Axebreakchance then 
        Player.Functions.RemoveItem('weapon_battleaxe', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['weapon_battleaxe'], "remove", 1)
    end
end)

----------
--OUTPUT--
----------

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl0', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 70 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 70 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl1', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 60 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 60 and chance <= 90 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 90 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl2', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 50 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 50 and chance <= 85 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 85 and chance <= 95 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 95 then 
        Player.Functions.AddItem('midlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['midlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl3', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 40 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 40 and chance <= 70 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 70 and chance <= 95 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 95 then 
        Player.Functions.AddItem('thicklog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl4', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 30 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 30 and chance <= 60 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 60 and chance <= 80 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 80 and chance <= 95 then 
        Player.Functions.AddItem('thicklog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", 1)
    elseif chance > 95 then 
        Player.Functions.AddItem('thickerlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl5', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 20 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 20 and chance <= 50 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 50 and chance <= 70 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 70 and chance <= 90 then 
        Player.Functions.AddItem('thicklog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", 1)
    elseif chance > 90 then 
        Player.Functions.AddItem('thickerlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl6', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    if chance <= 10 then 
        Player.Functions.AddItem('treebark', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", 1)
    elseif chance > 10 and chance <= 40 then
        Player.Functions.AddItem('woodwedge', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", 1)
    elseif chance > 40 and chance <= 65 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 65 and chance <= 80 then 
        Player.Functions.AddItem('thicklog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", 1)
    elseif chance > 80 then 
        Player.Functions.AddItem('thickerlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl7', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    local betteroutput = math.random(1, 2)
    if chance <= 10 then 
        Player.Functions.AddItem('treebark', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", betteroutput)
    elseif chance > 10 and chance <= 40 then
        Player.Functions.AddItem('woodwedge', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", betteroutput)
    elseif chance > 40 and chance <= 65 then 
        Player.Functions.AddItem('thinlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", 1)
    elseif chance > 65 and chance <= 80 then 
        Player.Functions.AddItem('thicklog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", 1)
    elseif chance > 80 then 
        Player.Functions.AddItem('thickerlog', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "add", 1)
    end  
end)

RegisterServerEvent('mz-lumberjack:lumberPayoutlvl8', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local chance = math.random(1, 100)
    local betteroutput = math.random(1, 2)
    if chance <= 10 then 
        Player.Functions.AddItem('treebark', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "add", betteroutput)
    elseif chance > 10 and chance <= 40 then
        Player.Functions.AddItem('woodwedge', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "add", betteroutput)
    elseif chance > 40 and chance <= 65 then 
        Player.Functions.AddItem('thinlog', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "add", betteroutput)
    elseif chance > 65 and chance <= 80 then 
        Player.Functions.AddItem('thicklog', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "add", betteroutput)
    elseif chance > 80 then 
        Player.Functions.AddItem('thickerlog', betteroutput)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "add", betteroutput)
    end  
end)

--------------
--MULCH BARK--
--------------

RegisterServerEvent('mz-lumberjack:server:MulchBark')
AddEventHandler('mz-lumberjack:server:MulchBark', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local treebark = Player.Functions.GetItemByName('treebark')
    if Player.PlayerData.items ~= nil then 
        if treebark ~= nil then 
            if treebark.amount >= Config.BarkAmount then 
                Player.Functions.RemoveItem("treebark", Config.BarkAmount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treebark'], "remove", Config.BarkAmount)
                TriggerClientEvent("mz-lumberjack:client:MulchBarkMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough tree bark to mulch (Need "..Config.BarkAmount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED BARK", "You do not have enough tree bark to mulch (Need "..Config.BarkAmount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetMulch')
AddEventHandler('mz-lumberjack:server:GetMulch', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.mulchreturnlow, Config.mulchreturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("treemulch", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treemulch'], "add", amount)
    else
        Player.Functions.AddItem("treemulch", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treemulch'], "add", 1)
    end
end)

-------------
--BAG MULCH--
-------------

RegisterServerEvent('mz-lumberjack:server:BagMulch')
AddEventHandler('mz-lumberjack:server:BagMulch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local treemulch = Player.Functions.GetItemByName('treemulch')
    if Player.PlayerData.items ~= nil then 
        if treemulch ~= nil then 
            if treemulch.amount >= Config.mulchamount then 
                Player.Functions.RemoveItem("treemulch", Config.mulchamount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['treemulch'], "remove", Config.mulchamount)
                Player.Functions.RemoveItem("emptymulchbag", 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['emptymulchbag'], "remove", 1)
                TriggerClientEvent("mz-lumberjack:client:BagMulchMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough mulch to bag (Need "..Config.mulchamount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED MULCH", "You do not have enough mulch to bag (Need "..Config.mulchamount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetBaggedMulch')
AddEventHandler('mz-lumberjack:server:GetBaggedMulch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = Config.bagmulchreturn
    Player.Functions.AddItem("mulchbag", amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mulchbag'], "add", amount)
end)

-------------------------
--PROCESS WOODEN WEDGES--
-------------------------

RegisterServerEvent('mz-lumberjack:server:ProcessWoodWedge')
AddEventHandler('mz-lumberjack:server:ProcessWoodWedge', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local woodwedge = Player.Functions.GetItemByName('woodwedge')
    if Player.PlayerData.items ~= nil then 
        if woodwedge ~= nil then 
            if woodwedge.amount >= Config.wedgeamount then 
                Player.Functions.RemoveItem("woodwedge", Config.wedgeamount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodwedge'], "remove", Config.wedgeamount)
                TriggerClientEvent("mz-lumberjack:client:ProcessWoodWedgeMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough wooden wedges to process (Need "..Config.wedgeamount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED WOODEN WEDGES", "You do not have enough wooden wedges to process (Need "..Config.wedgeamount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetPlanks')
AddEventHandler('mz-lumberjack:server:GetPlanks', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.wedgereturnlow, Config.wedgereturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("woodenplanks", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", amount)
    else
        Player.Functions.AddItem("woodenplanks", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", 1)
    end
end)

---------------------
--PROCESS THIN LOGS--
---------------------

RegisterServerEvent('mz-lumberjack:server:ProcessThinLogs')
AddEventHandler('mz-lumberjack:server:ProcessThinLogs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local thinlog = Player.Functions.GetItemByName('thinlog')
    if Player.PlayerData.items ~= nil then 
        if thinlog ~= nil then 
            if thinlog.amount >= Config.thinamount then 
                Player.Functions.RemoveItem("thinlog", Config.thinamount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thinlog'], "remove", Config.thinamount)
                TriggerClientEvent("mz-lumberjack:client:ProcessThinLogsMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough thin logs to process (Need "..Config.thinamount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED THIN LOGS", "You do not have enough thin logs to process (Need "..Config.thinamount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetThinPlanks')
AddEventHandler('mz-lumberjack:server:GetThinPlanks', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.thinreturnlow, Config.thinreturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("woodenplanks", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", amount)
    else
        Player.Functions.AddItem("woodenplanks", Config.thinreturnlow)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", Config.thinreturnlow)
    end
end)

--------------------
--PROCESS MID LOGS--
--------------------

RegisterServerEvent('mz-lumberjack:server:ProcessMidLogs')
AddEventHandler('mz-lumberjack:server:ProcessMidLogs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local midlog = Player.Functions.GetItemByName('midlog')
    if Player.PlayerData.items ~= nil then 
        if midlog ~= nil then 
            if midlog.amount >= Config.midamount then 
                Player.Functions.RemoveItem("midlog", Config.midamount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['midlog'], "remove", Config.midamount)
                TriggerClientEvent("mz-lumberjack:client:ProcessMidLogsMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough Medium Pine Logs (Need "..Config.midamount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED MEDIUM PINE", "You do not have enough Medium Pine Logs (Need "..Config.midamount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetMediumPlanks')
AddEventHandler('mz-lumberjack:server:GetMediumPlanks', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.midreturnlow, Config.midreturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("woodenplanks", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", amount)
    else
        Player.Functions.AddItem("woodenplanks", Config.midreturnlow)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", Config.midreturnlow)
    end
end)

------------
--PLASTIC--
------------

RegisterServerEvent('mz-lumberjack:server:ProcessThickLogs')
AddEventHandler('mz-lumberjack:server:ProcessThickLogs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local thicklog = Player.Functions.GetItemByName('thicklog')
    if Player.PlayerData.items ~= nil then 
        if thicklog ~= nil then 
            if thicklog.amount >= Config.thickamount then 
                Player.Functions.RemoveItem("thicklog", Config.thickamount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thicklog'], "remove", Config.thickamount)
                TriggerClientEvent("mz-lumberjack:client:ProcessThickLogsMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough thick pine logs to process (Need "..Config.thickamount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED THICK LOGS", "You do not have enough thick pine logs to process (Need "..Config.thickamount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetThickPlanks')
AddEventHandler('mz-lumberjack:server:GetThickPlanks', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.thickreturnlow, Config.thickreturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("woodenplanks", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", amount)
    else
        Player.Functions.AddItem("woodenplanks", Config.thickreturnlow)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", Config.thickreturnlow)
    end
end)

------------------------
--PROCESS THICKER LOGS--
------------------------

RegisterServerEvent('mz-lumberjack:server:ProcessThickerLogs')
AddEventHandler('mz-lumberjack:server:ProcessThickerLogs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local thickerlog = Player.Functions.GetItemByName('thickerlog')
    if Player.PlayerData.items ~= nil then 
        if thickerlog ~= nil then 
            if thickerlog.amount >= Config.thickeramount then 
                Player.Functions.RemoveItem("thickerlog", Config.thickeramount)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thickerlog'], "remove", Config.thickeramount)
                TriggerClientEvent("mz-lumberjack:client:ProcessThickerLogsMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough thicker pine logs to process (Need "..Config.thickeramount..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED THICKER PINE", "You do not have enough thicker pine logs to process (Need "..Config.thickeramount..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetThickerPlanks')
AddEventHandler('mz-lumberjack:server:GetThickerPlanks', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(Config.thickerreturnlow, Config.thickerreturnhigh)
    local chance = math.random(1, 4)
    if chance == 4 then 
        Player.Functions.AddItem("woodenplanks", amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", amount)
    else
        Player.Functions.AddItem("woodenplanks", Config.thickerreturnlow)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "add", Config.thickreturnlow)
    end
end)

---------------
--MAKE PALLET--
---------------

RegisterServerEvent('mz-lumberjack:server:MakePallet')
AddEventHandler('mz-lumberjack:server:MakePallet', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local woodenplanks = Player.Functions.GetItemByName('woodenplanks')
    local rustynails = Player.Functions.GetItemByName('rustynails')
    if Player.PlayerData.items ~= nil then 
        if woodenplanks ~= nil then 
            if woodenplanks.amount >= Config.planksneeded then
                if rustynails ~= nil then 
                    if rustynails.amount >= Config.nailsneeded then 
                        Player.Functions.RemoveItem("woodenplanks", Config.planksneeded)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenplanks'], "remove", Config.planksneeded)
                        Player.Functions.RemoveItem("rustynails", Config.nailsneeded)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rustynails'], "remove", Config.nailsneeded)
                        TriggerClientEvent("mz-lumberjack:client:MakePalletMinigame", src)
                    else
                        if Config.NotifyType == 'qb' then
                            TriggerClientEvent('QBCore:Notify', src, "You do not have enough nails (Need "..Config.nailsneeded..")", 'error')
                        elseif Config.NotifyType == "okok" then
                            TriggerClientEvent('okokNotify:Alert', source, "NEED RUSTY NAILS", "You do not have enough nails (Need "..Config.nailsneeded..")", 3500, 'error')
                        end
                    end
                end    
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough eooden planks (Need "..Config.planksneeded..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED PLANKS", "You do not have enough eooden planks (Need "..Config.planksneeded..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent('mz-lumberjack:server:GetPallet')
AddEventHandler('mz-lumberjack:server:GetPallet', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = Config.palletoutput
    Player.Functions.AddItem("woodenpallet", amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['woodenpallet'], "add", amount)
end)

--------------
--MULCH BAGS--
--------------

RegisterServerEvent('mz-lumberjack:server:MakeMulchBags')
AddEventHandler('mz-lumberjack:server:MakeMulchBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local plastic = Player.Functions.GetItemByName('plastic')
    if Player.PlayerData.items ~= nil then 
        if plastic ~= nil then 
            if plastic.amount >= Config.plasticneeded then 
                Player.Functions.RemoveItem("plastic", Config.plasticneeded)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['plastic'], "remove", Config.plasticneeded)
                TriggerClientEvent("mz-lumberjack:client:MakeMulchBagsMinigame", src)
            else
                if Config.NotifyType == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, "You do not have enough plastic (Need "..Config.plasticneeded..")", 'error')
                elseif Config.NotifyType == "okok" then
                    TriggerClientEvent('okokNotify:Alert', source, "NEED PLASTIC", "You do not have enough plastic (Need "..Config.plasticneeded..")", 3500, 'error')
                end
            end
        end
    end
end)

RegisterServerEvent("mz-lumberjack:server:GetMulchBag")
AddEventHandler("mz-lumberjack:server:GetMulchBag", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = Config.plasticoutput
    Player.Functions.AddItem("emptymulchbag", amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['emptymulchbag'], "add", amount)
end)

--------------
--SELL ITEMS--
--------------

QBCore.Functions.CreateCallback('mz-lumberjack:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

RegisterNetEvent("mz-lumberjack:server:sellTrashItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        Player.Functions.AddMoney("cash", totalPrice)
        if Config.NotifyType == "qb" then    
            TriggerClientEvent("QBCore:Notify", src, Lang:t('success.sold', {value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice}), 'success')
        elseif Config.NotifyType == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, "SOLD!", Lang:t('success.sold', {value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice}), 3500, 'success')
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        if Config.NotifyType == "qb" then    
            TriggerClientEvent("QBCore:Notify", src, Lang:t('error.no_items'), "error")
        elseif Config.NotifyType == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, "WRONG ITEMS?", "You do not have the necessary items", 3500, 'error')
        end
    end
end)
