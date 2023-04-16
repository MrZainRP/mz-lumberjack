Config = Config or {}

-----------------
--MZ-LUMBERJACK--
-----------------

Config.NotifyType = 'okok'              -- notification type: 'qb' for qb-core standard notifications, 'okok' for okokNotify notifications

Config.mzskills = true                  -- Set to "false" to disable mz-skills
-- if "Config.mzskills = true", then the following parameters apply:
Config.LumberSkill = "Lumberjack"
Config.LumberLevel0 = 0
Config.LumberLevel1 = 100
Config.LumberLevel2 = 200
Config.LumberLevel3 = 400
Config.LumberLevel4 = 800
Config.LumberLevel5 = 1600
Config.LumberLevel6 = 3200
Config.LumberLevel7 = 16400
Config.LumberLevel8 = 32800

-- Set this to "true" if you want to enable a processing lumber skill check (a different skill check applies for chopping wood) 
Config.ProcessMaterialCheck = true      -- Set to "false" to disable progressbar mini-game when processing various wood products.

Config.finalparse = true                -- Set to "true" to payout one more time when chopping progress bar completes. Otherwise set to false

---------------
--TREE SET UP--
---------------

Config.Choptime = 10                    -- Time (in seconds) to cut tree (with 2 loot parses). Do not change unless you are also going to change how the resource loots.

Config.Timeout = 2 * (60 * 1000)        -- Time (in minutes) that it takes for trees to regenerate.

--------------------------------
--SKILLCHECK FOR TREE CHOPPING--
--------------------------------

-- Set this to "true" if you want to enable a skill check for chopping wood (a different skill check applies for processing lumber products)
Config.Axeskillcheck = false            -- Change to "false" if you do not want to have a skillcheck before cutting down a tree.
--If "Config.Axeskillcheck" = true", then the following parameters apply:
Config.lowparse = 1                     -- Lowest number of skillcheck parses per wood chop.
Config.highparse = 2                    -- Highest number of skillcheck parses per wood chop.
Config.parsetimelow = 10                -- Lowest parse time per wood chop skill check.
Config.parsetimehigh = 14               -- Highest parse time per wood chop skill check.
Config.skillfailXP = 1                  -- amount of mz-skill (default is "Lumberjack") lost if skillcheck fails.

----------------------
--AXE CONFIGURATIONS--
----------------------

Config.Axe = {
    [`weapon_battleaxe`] = {}
}

Config.Axebreak = true                  -- Change to "false" if you do not want a chance for the axe to break.

Config.Axebreakchance = 1               -- Chance for the axe to break (in percentage, e.g. 1 = 1%)

------------
--CRAFTING--
------------

--------------
--MULCH BARK--
--------------
Config.BarkAmount = 5                   -- Amount of bark needed to start creating wooden mulch
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.barklow = 5                      -- Lowest number of skillbar parses to mulch tree bark
Config.barkhigh = 7                     -- Highest number of skillbar parses to mulch tree bark
-- mz-skill functions:
Config.mulchXPlow = 1                   -- Lowest amount of "Lumberjack" XP awarded for successful mulch
Config.mulchXPhigh = 3                  -- Highest amount of "Lumberjack" XP awarded for successful mulch
Config.mulchXPloss = 2                  -- Amount of XP lost for failing skillbar to mulch tree bark
-- progressBar functions:
Config.mulchtimelow = 10                -- Lowest time to process mulch.
Config.mulchtimehigh = 15               -- Highest time to process mulch.
-- Returns:
Config.mulchreturnlow = 1               -- Lowest mulch return.
Config.mulchreturnhigh = 2              -- Highest mulch return.

-------------
--BAG MULCH--
-------------
Config.mulchamount = 5                  -- Amount of bark needed to start bagging mulch
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.mulchlow = 5                     -- Lowest number of skillbar parses to bag mulch
Config.mulchhigh = 7                    -- Highest number of skillbar parses to bag mulch
-- mz-skill functions:
Config.bagmulchXPlow = 1                -- Lowest amount of "Lumberjack" XP awarded to bag mulch
Config.bagmulchXPhigh = 3               -- Highest amount of "Lumberjack" XP awarded to bag mulch
Config.bagmulchXPloss = 2               -- Amount of XP lost for failing skillbar to bag mulch
-- progressBar functions:
Config.bagmulchtimelow = 10             -- Lowest time to process mulch.
Config.bagmulchtimehigh = 15            -- Highest time to process mulch.
-- Returns:
Config.bagmulchreturn = 1               -- Lowest mulch return.

-------------------------
--PROCESS WOODEN WEDGES--
-------------------------
Config.wedgeamount = 8                  -- Amount of wedges needed.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.wedgelow = 5                     -- Lowest number of skillbar parses to process wedges.
Config.wedgehigh = 7                    -- Highest number of skillbar parses to process wedges.
-- mz-skill functions:
Config.wedgeXPlow = 1                   -- Lowest amount of "Lumberjack" XP awarded to process wedges.
Config.wedgeXPhigh = 3                  -- Highest amount of "Lumberjack" XP awarded to process wedges.
Config.wedgeXPloss = 2                  -- Amount of XP lost for failing skillbar to process wedges.
-- progressBar functions:
Config.wedgetimelow = 10                -- Lowest time to process wedges.
Config.wedgetimehigh = 15               -- Highest time to process wedges.
-- Returns:
Config.wedgereturnlow = 1               -- Lowest wedge return.
Config.wedgereturnhigh = 2              -- Highest wedge return.

---------------------
--PROCESS THIN LOGS--
---------------------
Config.thinamount = 6                   -- Amount of thin logs needed.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.thinlow = 5                      -- Lowest number of skillbar parses to process thin logs.
Config.thinhigh = 7                     -- Highest number of skillbar parses to process thin logs.
-- mz-skill functions:
Config.thinXPlow = 1                    -- Lowest amount of "Lumberjack" XP awarded to process thin logs.
Config.thinXPhigh = 5                   -- Highest amount of "Lumberjack" XP awarded to process thin logs.
Config.thinXPloss = 3                   -- Amount of XP lost for failing skillbar to process thin logs.
-- progressBar functions:
Config.thintimelow = 10                 -- Lowest time to process thin logs.
Config.thintimehigh = 15                -- Highest time to process thin logs.
-- Returns:
Config.thinreturnlow = 2                -- Lowest thin logs return.
Config.thinreturnhigh = 3               -- Highest thin log return.

--------------------
--PROCESS MID LOGS--
--------------------
Config.midamount = 4                    -- Amount of mid logs needed.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.midlow = 5                       -- Lowest number of skillbar parses to process mid logs.
Config.midhigh = 7                      -- Highest number of skillbar parses to process mid logs.
-- mz-skill functions:
Config.midXPlow = 1                     -- Lowest amount of "Lumberjack" XP awarded to process mid logs.
Config.midXPhigh = 7                    -- Highest amount of "Lumberjack" XP awarded to process mid logs.
Config.midXPloss = 4                    -- Amount of XP lost for failing skillbar to process mid logs.
-- progressBar functions:
Config.midtimelow = 10                  -- Lowest time to process mid logs.
Config.midtimehigh = 15                 -- Highest time to process mid logs.
-- Returns:
Config.midreturnlow = 3                 -- Lowest thin mid return.
Config.midreturnhigh = 5                -- Highest thin mid return.

----------------------
--PROCESS THICK LOGS--
----------------------
Config.thickamount = 2                  -- Amount of thick logs needed.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.thicklow = 5                     -- Lowest number of skillbar parses to process thick logs.
Config.thickhigh = 7                    -- Highest number of skillbar parses to process thick logs.
-- mz-skill functions:
Config.thickXPlow = 1                   -- Lowest amount of "Lumberjack" XP awarded to process thick logs.
Config.thickXPhigh = 10                 -- Highest amount of "Lumberjack" XP awarded to process thick logs.
Config.thickXPloss = 5                  -- Amount of XP lost for failing skillbar to process thick logs.
-- progressBar functions:
Config.thicktimelow = 10                -- Lowest time to process thick logs.
Config.thicktimehigh = 15               -- Highest time to process thick logs.
-- Returns:
Config.thickreturnlow = 4               -- Lowest thin thick return.
Config.thickreturnhigh = 7              -- Highest thin thick return.

------------------------
--PROCESS THICKER LOGS--
------------------------
Config.thickeramount = 2                -- Amount of thicker logs needed.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.thickerlow = 5                   -- Lowest number of skillbar parses to process thicker logs.
Config.thickerhigh = 7                  -- Highest number of skillbar parses to process thicker logs.
-- mz-skill functions:
Config.thickerXPlow = 1                 -- Lowest amount of "Lumberjack" XP awarded to process thicker logs.
Config.thickerXPhigh = 10               -- Highest amount of "Lumberjack" XP awarded to process thicker logs.
Config.thickerXPloss = 5                -- Amount of XP lost for failing skillbar to process thicker logs.
-- progressBar functions:
Config.thickertimelow = 10              -- Lowest time to process thicker logs.
Config.thickertimehigh = 15             -- Highest time to process thicker logs.
-- Returns:
Config.thickerreturnlow = 6             -- Lowest thin thicker return.
Config.thickerreturnhigh = 10           -- Highest thin thicker return.

-------------------
--MAKE MULCH BAGS--
-------------------
Config.plasticneeded = 5                -- Amount of planks needed to make a mulch bag.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.plasticlow = 5                   -- Lowest number of skillbar parses to make a mulch bag.
Config.plastichigh = 7                  -- Highest number of skillbar parses to make a mulch bag.
-- mz-skill functions:
Config.plasticXPlow = 1                 -- Lowest amount of "Lumberjack" XP awarded to make a mulch bag.
Config.plasticXPhigh = 1                -- Highest amount of "Lumberjack" XP awarded to make a mulch bag.
Config.plasticXPloss = 1                -- Amount of XP lost for failing skillbar to make a mulch bag.
-- progressBar functions:
Config.plastictimelow = 10              -- Lowest time to make a mulch bag.
Config.plastictimehigh = 15             -- Highest time to make a mulch bag.
-- Returns:
Config.plasticoutput = 1                -- Mulch bag output

----------------
--MAKE PALLETS--
----------------
Config.planksneeded = 3                 -- Amount of planks needed to make a pallet.
-- if "Config.ProcessMaterialCheck = true", then the following parameters apply:
Config.nailsneeded = 5                  -- Amount of rusty nails needed to make a pallet.
Config.palletlow = 5                    -- Lowest number of skillbar parses to make a pallet.
Config.pallethigh = 7                   -- Highest number of skillbar parses to make a pallet.
-- mz-skill functions:
Config.palletXPlow = 1                  -- Lowest amount of "Lumberjack" XP awarded to make a pallet.
Config.palletXPhigh = 10                -- Highest amount of "Lumberjack" XP awarded to make a pallet.
Config.palletXPloss = 5                 -- Amount of XP lost for failing skillbar to make a pallet.
-- progressBar functions:
Config.pallettimelow = 10               -- Lowest time to make a pallet.
Config.pallettimehigh = 15              -- Highest time to make a pallet.
-- Returns:
Config.palletoutput = 1                 -- Pallet output

----------------
--SELL RETURNS--
----------------

Config.LumberItems = { -- Items capable of being sold for $ (Add whatever items you want players to be able to sell here in the same format)
    [1] = {
        item = "woodenplanks",
        price = 250
    },
    [2] = {
        item = "mulchbag",
        price = 650
    },
    [3] = {
        item = "woodenpallet",
        price = 2500
    },
}


---------
--BLIPS--
---------

Config.LumberLocation = { -- Blip Location of lumber processing and trees.
    [1] = {
            coords = vector3(-537.51, 5322.91, 89.93),
            length = 1.2,
            width = 0.5,
            heading = 125,
            debugPoly = false,
            minZ = 32.15,
            maxZ = 36.15,
            distance = 1.0
        },
    }

Config.SellLocation = { -- Blip Location of wholesale hardware purchaser of lumber and lumber products.
    [1] = {
            coords = vector3(2026.02, 4986.21, 41.98),
            length = 1.2,
            width = 0.5,
            heading = 125,
            debugPoly = false,
            minZ = 32.15,
            maxZ = 36.15,
            distance = 1.0
        },
    }


Config.ProcessLocation = { -- Blip Location to process lumber and lumber related products.
    [1] = {
            coords = vector3(-497.18, 5279.39, 80.61),
            length = 6.3,
            width = 2.6,
            heading = 125,
            debugPoly = false,
            minZ = 78.41,
            maxZ = 82.41,
            distance = 1.0
        },
    }    

Config.TreeLocations = {
    [1] = {
        ["coords"] = vector3(-504.47, 5392.09, 75.82),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [2] = {
        ["coords"] = vector3(-510.08, 5389.15, 73.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [3] = {
        ["coords"] = vector3(-558.32, 5418.98, 62.78),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [4] = {
        ["coords"] = vector3(-561.47, 5420.32, 62.39),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [5] = {
        ["coords"] = vector3(-578.9, 5427.22, 58.54),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [6] = {
        ["coords"] = vector3(-600.28, 5397.03, 52.48),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [7] = {
        ["coords"] = vector3(-614.04, 5399.73, 50.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [8] = {
        ["coords"] = vector3(-616.38, 5403.72, 50.59),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [9] = {
        ["coords"] = vector3(-553.08, 5445.65, 64.16),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [10] = {
        ["coords"] = vector3(-500.53, 5401.34, 75.05),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [11] = {
        ["coords"] = vector3(-491.78, 5395.47, 77.57),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [12] = {
        ["coords"] = vector3(-457.24, 5398.19, 79.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [13] = {
        ["coords"] = vector3(-456.87, 5408.32, 79.26),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [14] = {
        ["coords"] = vector3(-627.6, 5322.19, 59.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [15] = {
        ["coords"] = vector3(-626.05, 5315.49, 60.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [16] = {
        ["coords"] = vector3(-628.47, 5286.07, 63.75),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [17] = {
        ["coords"] = vector3(-604.23, 5243.57, 71.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [18] = {
        ["coords"] = vector3(-599.94, 5239.87, 71.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [19] = {
        ["coords"] = vector3(-556.65, 5233.61, 72.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [20] = {
        ["coords"] = vector3(-557.92, 5224.02, 77.24),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [21] = {
        ["coords"] = vector3(-546.26, 5219.38, 77.94),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [22] = {
        ["coords"] = vector3(-537.93, 5226.47, 78.52),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [23] = {
        ["coords"] = vector3(-628.32, 5286.04, 63.76),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [24] = {
        ["coords"] = vector3(-633.1, 5275.56, 69.11),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [25] = {
        ["coords"] = vector3(-604.37, 5243.69, 71.89),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [26] = {
        ["coords"] = vector3(-646.03, 5269.73, 74.01),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [27] = {
        ["coords"] = vector3(-644.29, 5241.2, 76.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [28] = {
        ["coords"] = vector3(-657.02, 5296.15, 69.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [29] = {
        ["coords"] = vector3(-659.05, 5293.48, 70.02),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [30] = {
        ["coords"] = vector3(-664.32, 5277.7, 74.4),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [31] = {
        ["coords"] = vector3(-615.24, 5433.06, 54.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [32] = {
        ["coords"] = vector3(-616.14, 5424.5, 51.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [33] = {
        ["coords"] = vector3(-690.07, 5304.85, 70.51),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [34] = {
        ["coords"] = vector3(-647.58, 5278.99, 71.5),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [35] = {
        ["coords"] = vector3(-711.88, 5272.45, 74.9),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [36] = {
        ["coords"] = vector3(-717.63, 5273.15, 76.79),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [37] = {
        ["coords"] = vector3(-729.92, 5278.28, 79.37),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [38] = {
        ["coords"] = vector3(-744.23, 5280.94, 82.28),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [39] = {
        ["coords"] = vector3(-743.59, 5304.4, 75.18),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [40] = {
        ["coords"] = vector3(-721.02, 5325.07, 71.85),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [41] = {
        ["coords"] = vector3(-716.16, 5329.28, 70.69),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [42] = {
        ["coords"] = vector3(-699.59, 5324.75, 70.48),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [43] = {
        ["coords"] = vector3(-669.34, 5311.17, 66.77),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [44] = {
        ["coords"] = vector3(-676.53, 5341.06, 66.27),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [45] = {
        ["coords"] = vector3(-691.8, 5351.77, 67.62),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [46] = {
        ["coords"] = vector3(-680.17, 5391.28, 54.03),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [47] = {
        ["coords"] = vector3(-713.42, 5402.5, 52.36),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [48] = {
        ["coords"] = vector3(-715.61, 5406.11, 51.49),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [49] = {
        ["coords"] = vector3(-735.81, 5407.12, 49.21),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [50] = {
        ["coords"] = vector3(-738.6, 5376.57, 56.34),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [51] = {
        ["coords"] = vector3(-748.75, 5346.78, 61.03),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [52] = {
        ["coords"] = vector3(-654.91, 5215.31, 84.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [53] = {
        ["coords"] = vector3(-643.2, 5206.16, 87.48),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [54] = {
        ["coords"] = vector3(-646.91, 5191.49, 96.49),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [55] = {
        ["coords"] = vector3(-621.18, 5187.91, 94.13),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [56] = {
        ["coords"] = vector3(-600.45, 5175.93, 98.56),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
}