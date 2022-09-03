### MZ-LUMBERJACK - a progression (XP) based lumberjack job + crafting for QB-CORE based FiveM servers

Created by Mr_Zain#4139 - inspired by TRClassic#0001's "tr-lumberjack" resource - see: **[tr-lumberjack](https://github.com/trclassic92/tr-lumberjack)**

## PREVIEW

[![mz-lumberjack](https://i.imgur.com/sT0yDDO.jpeg)](https://youtu.be/f34kdZCqmIk "mz-lumberjack for FiveM by Mr_Zain#4139")

### Introduction 
- Chop down trees with your lumberjack axe and turn what you acquire into something that TJ's will acquire for good money.
- Highly customisable via config, everything from whether your tree chopping uses skillchecks or not to the XP a player obtains for each function is completely customisable (and everything in between including skill parses, progressbar timings, cost of inputs and outputs and sale prices)
- XP modifier via mz-skills applies for successful lumberjack function. More XP is awarded for successful crafting. The more XP a player has the better the chances of accessing more useful wood products.
- Resmon 0.00 idle - optimised with no range checking
- Customised to function with qb-core standard notifications + okokNotify notifications

### DEPENDENCIES

NOTE: You should have each of the dependencies other than qb-lock and mz-skills as part of a conventional qb-core install.

**[mz-skills](https://github.com/MrZainRP/mz-skills)** - to track skill progress. All credit to Kings#4220 for the original qb-skillz now **[B1-skillz](https://github.com/Burn-One-Studios/B1-skillz)**

**[progressbar](https://github.com/qbcore-framework/progressbar)**

**[qb-target](https://github.com/qbcore-framework/qb-target)**

**[qb-lock](https://github.com/Nathan-FiveM/qb-lock)**

OPTIONAL: You will need "plastic" and "rustynails" each of which is given by mz-bins and mz-scrap, respectively. If you are not running those resources, you will either need to add these items separately or replace them as crafting inputs. Both resources, like mz-skills, is freely available at:

**[mz-bins](https://github.com/MrZainRP/mz-bins)**

**[mz-scrap](https://github.com/MrZainRP/mz-scrap)**

### Installation Instruction

### A. MZ-SKILLS

1. If you do not already have mz-skills running in your server, ensure that mz-skills forms part of your running scripts. 

2. If this is your first time running mz-skills, be sure to run the "skills.sql" sql file and open the database. (This will add a data table to the existing "players" database which will hold the skill value for "Lumberjack" as well as other jobs)

### B. QB-CORE/SHARED/ITEMS.LUA

3. Add the following items to qb-core/shared/items.lua:

```lua
	--mz-lumberjack
	["thinlog"] 		 	 	 	 = {["name"] = "thinlog",           			["label"] = "Thin Pine Log",	 		["weight"] = 700, 		["type"] = "item", 		["image"] = "thinlog.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A freshly cut thin log of pine."},
    ["woodwedge"] 		 	 	 	 = {["name"] = "woodwedge",           			["label"] = "Log Wedge", 				["weight"] = 350,		["type"] = "item", 		["image"] = "woodwedge.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A wedge of a tree log, freshly cut and smelling like the forest."},
	["midlog"] 		 	 	 	 	 = {["name"] = "midlog",           				["label"] = "Medium Pine Log",	 		["weight"] = 1200,		["type"] = "item", 		["image"] = "midlog.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A medium weighted log of pine."},
	["thicklog"] 		 	 	 	 = {["name"] = "thicklog",           			["label"] = "Thick Pine Log",	 		["weight"] = 1550,		["type"] = "item", 		["image"] = "thicklog.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A thick, dense log of pine."},
    ["thickerlog"] 			 	 	 = {["name"] = "thickerlog", 					["label"] = "Thicker Pine Log", 		["weight"] = 2200, 		["type"] = "item", 		["image"] = "thickerlog.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "The thickest cut of pine achievable with a hand axe."},
	["treebark"] 		 	 		 = {["name"] = "treebark",           			["label"] = "Tree Bark",	 			["weight"] = 200, 		["type"] = "item", 		["image"] = "treebark.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Wooden bark stripped away from what looks like a pine tree."},
    ["treemulch"] 		 	 	 	 = {["name"] = "treemulch",           			["label"] = "Wooden Mulch", 			["weight"] = 200,		["type"] = "item", 		["image"] = "treemulch.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "An array of roughly cut wooden chunks for pulping purposes."},
	["emptymulchbag"] 		 	 	 = {["name"] = "emptymulchbag",           		["label"] = "Empty Mulch Bag",	 		["weight"] = 200,		["type"] = "item", 		["image"] = "emptymulchbag.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A tough and durable bag capable of holding many kilograms of product."},
	["mulchbag"] 		 	 	 	 = {["name"] = "mulchbag",           			["label"] = "Bag of Mulch",	 			["weight"] = 1200,		["type"] = "item", 		["image"] = "mulchbag.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A tough and heavy bag of tree mulch, ready to be sold."},
	["woodenplanks"] 		 	 	 = {["name"] = "woodenplanks",           		["label"] = "Wooden Planks",	 		["weight"] = 1100,		["type"] = "item", 		["image"] = "woodenplanks.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A bundle of 4x2 wooden planks with a variety of residential and commercial purposes."},
    ["woodenpallet"] 			 	 = {["name"] = "woodenpallet", 					["label"] = "Wooden Pallet", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "woodenpallet.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A sturdy pallet used in storage facilities in order for forklifts to move goods around a warehouse."},
```

4. "plastic" should be a part of your default qb-core server, I have included optional additional items here if your server does not include them:

```lua
	['plastic'] 					 = {['name'] = 'plastic', 			  	  	  	['label'] = 'Plastic', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'plastic.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
	["rustynails"]         	 	 = {["name"] = "rustynails",         		["label"] = "Rusted Nails",    			["weight"] = 150,       ["type"] = "item",      ["image"] = "rustynails.png",     		["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A collection of nails that have seen better days... Perhaps they can be cleaned?"},
```

### C. IMAGES

5. Add the images which appear in the "images" folder to your inventory images folder. For example, if you are using lj-inventory, add the images to: lj-inventory/html/images/

### D. LUMBER AXE

6. The resource will work regardless of what you call your axe, however, for aesthetic purposes, you can replace the item "weapon_battleaxe" with the following:

```lua
	['weapon_battleaxe'] 			 = {['name'] = 'weapon_battleaxe', 		 	  	['label'] = 'Lumber Axe', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_battleaxe.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large broad-bladed axe used in ancient warfare'},
```

Please note: The change to the battle axe is purely aesthetic, if it causes an issue with the functionality of the resource, the change can be reverted:

```lua
['weapon_battleaxe'] 			 = {['name'] = 'weapon_battleaxe', 		 	  	['label'] = 'Battle Axe', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_battleaxe.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large broad-bladed axe used in ancient warfare'},
```

7. In order to allow the axe to be purchaseable, you can amend QB-SHOPS/CONFIG.LUA to add the following to the end of the "hardware" store (starting at line 258 of config.lua if you have not otherwise amended qb-shops):

```lua
        [16] = {
            name = "weapon_battleaxe",
            price = 750,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
        },
```

### E. RESTART SERVER

8. If you attend to all of the above steps you will need to restart the server in order for the new added items to be recognised by qb-core. Starting the mz-scrap resource without doing this will cause errors. Please restart your server ensuring that mz-lumberjack is ensured/starts after qb-core starts (ideally it should just form part of your [qb] folder). Happy tree chopping and crafting!
