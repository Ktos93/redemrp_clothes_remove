---------------------THANKS Ideo FOR  MENU BASE-----------------

-------------------------------------------------------------------------------------
Keys = {
    ["LEFT"] = 0xA65EBAB4, ["RIGHT"] = 0xDEB34313, ["TOP"] = 0x6319DB71, ["DOWN"] = 0x05CA7C52,
    ["NENTER"] = 0xC7B5340A
}
--------------------------------------------------------------------------------------
local button_limit = 8
Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
Menu.from = 0
Menu.to = button_limit
MenuTitle = "Menu"
local menu_long = 0
local menu_yoffset = 0
------------------------------------Move Menu ---------------------
local menu_xoffset = 0.15
local yoffset = 0.3
-----------------------------------
local menu_wif = 0
local menu__title_height = 0

local xmin = 0.0
local xmax = 0.3
local ysize = 0.04
local xtext = xmin + menu_xoffset + 0.005
local ytitle = yoffset - 0.089
-----------------------------------------------------------------------------------
function Menu.addButton(name, func,args)
    Menu.GUI[Menu.buttonCount +1] = {}
    Menu.GUI[Menu.buttonCount +1]["name"] = name
    Menu.GUI[Menu.buttonCount+1]["func"] = func
    Menu.GUI[Menu.buttonCount+1]["args"] = args
    Menu.GUI[Menu.buttonCount+1]["active"] = false
    Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin
    Menu.GUI[Menu.buttonCount+1]["ymin"] = yoffset - ysize
    Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax
    Menu.GUI[Menu.buttonCount+1]["ymax"] = ysize
    Menu.buttonCount = Menu.buttonCount+1
end

----------------------------------------------------------------------------------------------
function updateSelection()
    if IsControlJustPressed(1, Keys["DOWN"])  then
        if (Menu.selection <= Menu.to and Menu.selection < Menu.buttonCount - 1) then
            Menu.selection = Menu.selection + 1
        else
            Menu.selection = Menu.from
        end
    elseif IsControlJustPressed(1, Keys["TOP"]) then
        if (Menu.selection >= Menu.from and Menu.selection >  0) then
            Menu.selection = Menu.selection - 1
        else
            Menu.selection = Menu.to - 1
        end
    elseif IsControlJustPressed(1, Keys["NENTER"])  then
        if Menu.buttonCount > 0 then
            MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
        end
    end
    local iterator = 0
    for id, settings in ipairs(Menu.GUI) do
        Menu.GUI[id]["active"] = false
        if(iterator == Menu.selection ) then
            Menu.GUI[iterator +1]["active"] = true
        end
        iterator = iterator +1
    end
end
-----------------------------------------------------------------------------------
function Menu.renderGUI()
    if not Menu.hidden then
        renderButtons()
        updateSelection()
    end
end

function menu()
    HasStreamedTextureDictLoaded("generic_textures")
    DrawSprite("generic_textures", "hud_menu_4a", menu_xoffset, menu_yoffset, 0.25, menu_long, 0.2, 000, 2, 2, 255, 1)
    DrawSprite("generic_textures", "hud_menu_4a", menu_xoffset, menu_yoffset, 0.25, menu_long, 0.2, 000, 2, 2, 180, 1)
    DrawSprite("generic_textures", "hud_menu_4a", menu_xoffset, menu__title_height, 0.20, 0.1, 0.1, 100, 1, 1, 190, 0)
end


function renderButtons()
    if  Menu.buttonCount == 1 then
        menu_long = 0.2
        menu_yoffset = 0.04 + yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 2 then
        menu_long = 0.25
        menu_yoffset = -0.02 + yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 3 then
        menu_long = 0.31
        menu_yoffset = yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 4 then
        menu_long = 0.34
        menu_yoffset = 0.03 + yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 5 then
        menu_long = 0.38
        menu_yoffset = 0.05	+ yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 6 then
        menu_long = 0.43
        menu_yoffset = 0.08 + yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 7 then
        menu_long = 0.46
        menu_yoffset = 0.08 + yoffset
        menu__title_height = -0.065 + yoffset
    elseif Menu.buttonCount == 8 then
        menu_long = 0.49
        menu_yoffset = 0.1 + yoffset
        menu__title_height = -0.065 + yoffset
    end
    menu()
    SetTextScale(0.8,0.8)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 255)
    SetTextCentre(true)
    Citizen.InvokeNative(0x1BE39DBAA7263CA5, 0, 0, 0, 0, 0)
    local str = CreateVarString(10, "LITERAL_STRING", "MENU", Citizen.ResultAsLong())
    DisplayText(str, xtext, ytitle)


    for id, settings in pairs(Menu.GUI) do
        if id > Menu.from and id <= Menu.to then
            local yPos = settings["ymin"] + (id * ysize) - (Menu.from * ysize)
            if(settings["active"]) then
                textColor = {100, 1, 1,255}
                DrawSprite("generic_textures", "hud_menu_4a", menu_xoffset, yPos, 0.20, 0.05, 0.1, 200,200,200, 180, 0)
            else

                textColor = {255,255,255,200}
            end
            SetTextScale(0.0,0.4)
            SetTextFontForCurrentCommand(1)
            SetTextColor(textColor[1],textColor[2],textColor[3],textColor[4])
            SetTextCentre(true)
            local str = CreateVarString(10, "LITERAL_STRING", settings["name"], Citizen.ResultAsLong())
            DisplayText(str, xtext, (yPos - 0.0125))
        end
    end
end



--------------------------------------------------------------------------------------------------------------------

function ClearMenu()
    --Menu = {}
    Menu.GUI = {}
    Menu.buttonCount = 0
    Menu.selection = 0
    Menu.from = 0
    Menu.to = button_limit
end

function MenuCallFunction(fnc, arg)
    _G[fnc](arg)
end
