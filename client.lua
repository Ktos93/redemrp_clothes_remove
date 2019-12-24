local lista_kapelusze = {} --hat
local lista_kapelusze_f = {}
----------------------------------------------------------------------------------------------------------------------------
local lista_koszula = {} --shirt
local lista_koszula_f = {}
--------------------------------------------------------------------------------------------------------------------------------------
local lista_kamizelka = {} --vest
local lista_kamizelka_f = {}
--------------------------------------------
local lista_spodnie = {} --pants
local lista_spodnie_f = {}
------------------------------------------
local lista_maska = {} --mask
local lista_maska_f = {}
------------------------------------------
local lista_buty = {} --boots
local lista_buty_f = {}
-----------------------------------------
local lista_plaszcz = {} --coats
local lista_plaszcz_f = {}
---------------------------------------
local lista_rekawiczki = {} -- gloves
local lista_rekawiczki_f = {}

local lista_bandana = {}
local lista_bandana_f = {}

local lista_spodnica = {} --skirt


local adding2 = true
local adding = true
local femalelegs = {}
local malelegs = {}
local legs = nil
local legs2 = nil

local glowna = lista_kapelusze
local sex_global = 1



Citizen.CreateThread(function()
    while adding do
        Citizen.Wait(0)
        --print("Dzieje sie")
        for i, v in ipairs(MaleComp) do
            if v.category == "hats" then
                table.insert(lista_kapelusze, v.Hash)
            elseif v.category == "shirts" then
                table.insert(lista_koszula, v.Hash)
            elseif v.category == "vests" then
                table.insert(lista_kamizelka, v.Hash)
            elseif v.category == "pants" then
                table.insert(lista_spodnie, v.Hash)
            elseif v.category == "masks" then
                table.insert(lista_maska, v.Hash)
            elseif v.category == "coats" then
                table.insert(lista_plaszcz, v.Hash)
            elseif v.category == "boots" then
                table.insert(lista_buty, v.Hash)
            elseif v.category == "legs" then
                table.insert(malelegs, v.Hash)
            elseif v.category == "gloves" then
                table.insert(lista_rekawiczki, v.Hash)
            elseif v.category == "neckwear" then
                table.insert(lista_bandana, v.Hash)
            end
        end
        adding = false
    end
end)


Citizen.CreateThread(function()
    while adding2 do
        Citizen.Wait(0)
        --print("Dzieje sie 2")
        for i, v in ipairs(FemaleComp) do
            if v.category == "hats" then
                table.insert(lista_kapelusze_f, v.hash)
            elseif v.category == "shirts" then
                table.insert(lista_koszula_f, v.hash)
            elseif v.category == "vests" then
                table.insert(lista_kamizelka_f, v.hash)
            elseif v.category == "pants" then
                table.insert(lista_spodnie_f, v.hash)
            elseif v.category == "boots" then
                table.insert(lista_buty_f, v.hash)
            elseif v.category == "masks" then
                table.insert(lista_maska_f, v.hash)
            elseif v.category == "coats" then
                table.insert(lista_plaszcz_f, v.hash)
            elseif v.category == "skirts" then
                table.insert(lista_spodnica, v.hash)
            elseif v.category == "legs" then
                table.insert(femalelegs, v.hash)
            elseif v.category == "gloves" then
                table.insert(lista_rekawiczki_f, v.hash)
            elseif v.category == "neckwear" then
                table.insert(lista_bandana_f, v.hash)
            else end
        end
        adding2 = false
    end
end)





RegisterNetEvent('redemrp_clothes_remove:start')
AddEventHandler('redemrp_clothes_remove:start', function(skin, ubranie)
    print("poszlo")
    local _skin = json.decode(skin)
    local _ubranie = json.decode(ubranie)
    local sex = 1
    if _skin.sex == "male" then
        sex = 1
        sex_global = sex
        if tonumber(_skin.skin) == 1 then
            legs = '0x' .. malelegs[5]
        elseif tonumber(_skin.skin) == 2 then          
            legs = '0x' .. malelegs[5]
        elseif tonumber(_skin.skin) == 3 then          
            legs = '0x' .. malelegs[1]
        elseif tonumber(_skin.skin) == 4 then          
            legs = '0x' .. malelegs[3]
        elseif tonumber(_skin.skin) == 5 then           
            legs = '0x' .. malelegs[4]
        elseif tonumber(_skin.skin) == 6 then
            legs = '0x' .. malelegs[2]
        else end
    else
        sex = 2
        sex_global = sex
        if tonumber(_skin.skin) == 1 then           
            legs2 = '0x' .. femalelegs[1]
        elseif tonumber(_skin.skin) == 2 then           
            legs2 = '0x' .. femalelegs[2]
        elseif tonumber(_skin.skin) == 3 then
            legs2 = '0x' .. femalelegs[3]
        elseif tonumber(_skin.skin) == 4 then         
            legs2 = '0x' .. femalelegs[5]
        elseif tonumber(_skin.skin) == 5 then           
            legs2 = '0x' .. femalelegs[6]
        elseif tonumber(_skin.skin) == 6 then
            legs2 = '0x' .. femalelegs[8]
        else end
    end
    local spodnie = 0
    function Spodnie()
	if sex_global == 1 then
	
        if spodnie == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            spodnie = 1
            if  sex_global == 1 then
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(legs),true,true,true)
            end

        else
            if  sex_global == 1 then
                glowna = lista_spodnie
            else
                glowna = lista_spodnie_f
            end
            spodnie = 0
            wartosc = tonumber(_ubranie.spodnie)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")

            end
            Buty()
            Buty()
        end
		
		end
    end
    local koszula = 0
    function Koszula()
        if koszula == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            koszula = 1

        else
            if  sex_global == 1 then
                glowna = lista_koszula
            else
                glowna = lista_koszula_f
            end

            koszula = 0
            wartosc = tonumber(_ubranie.koszula)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
            Kamizelka()
            Kamizelka()
        end
    end

    local kamizelka = 0
    function Kamizelka()
        if kamizelka == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            kamizelka = 1

        else
            if  sex_global == 1 then
                glowna = lista_kamizelka
            else
                glowna = lista_kamizelka_f
            end
            kamizelka = 0
            wartosc = tonumber(_ubranie.kamizelka)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
        end
    end

    local buty = 0
    function Buty()
        if buty == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            buty = 1

        else
            if  sex_global == 1 then
                glowna = lista_buty
            else
                glowna = lista_buty_f
            end
            buty = 0
            wartosc = tonumber(_ubranie.buty)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
        end
    end

    local kapelusz = 0
    function Kapelusz()
        if kapelusz == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            kapelusz = 1

        else
            if  sex_global == 1 then
                glowna = lista_kapelusze
            else
                glowna = lista_kapelusze_f
            end
            kapelusz = 0
            wartosc = tonumber(_ubranie.kapelusz)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
        end
    end

    local rekawiczki = 0
    function Rekawiczki()
        if rekawiczki == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            rekawiczki = 1

        else
            if  sex_global == 1 then
                glowna = lista_rekawiczki
            else
                glowna = lista_rekawiczki_f
            end
            rekawiczki = 0
            wartosc = tonumber(_ubranie.rekawiczki)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
        end
    end
    local plaszcz = 0
    function Plaszcz()
        if plaszcz == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            plaszcz = 1
            Koszula()
            Koszula()
            Kamizelka()
            Kamizelka()

        else
            if  sex_global == 1 then
                glowna = lista_plaszcz
            else
                glowna = lista_plaszcz_f
            end
            plaszcz = 0
            wartosc = tonumber(_ubranie.plaszcz)
            if wartosc > 1 then
				hash = ("0x" .. glowna[20])
				ladowanie(hash)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
            end

        end
    end
    local bandana = 0
    function Bandana()
        if bandana == 0 then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            bandana = 1

        else
            if  sex_global == 1 then
                glowna = lista_bandana
            else
                glowna = lista_bandana_f
            end
            bandana = 0
            wartosc = tonumber(_ubranie.bandana)
            if wartosc > 1 then
                --print(wartosc)
                hash = ("0x" .. glowna[wartosc])
                ladowanie(hash)
                --print("poszło4")
            end
        end
    end
end)


----------------------------------------------------------------------------------------------------------------------------------------------------------



function ladowanie(hash)
    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  tonumber(hash), true, true, true)
    --print("poszło13")
    --print(hash)
end



function Load_menu()
    ped = GetPlayerPed(-1);
    MenuTitle="Menu :"
    ClearMenu()
	if sex_global == 1 then
		Menu.addButton("Pants", "Spodnie", nil)
	end
    Menu.addButton("Shirt", "Koszula", nil)
    Menu.addButton("Vest", "Kamizelka", nil)
    Menu.addButton("Hat", "Kapelusz", nil)
    Menu.addButton("Gloves", "Rekawiczki", nil)
    Menu.addButton("Boots", "Buty", nil)
    Menu.addButton("Coat", "Plaszcz", nil)
    Menu.addButton("Bandana", "Bandana", nil)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 0x9959A6F0) then
		 TriggerServerEvent("redemrp_clothing:loadClothes", 3, function(cb)
        end)
		  Citizen.Wait(500)
            Load_menu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI() -- Draw menu on each tick if Menu.hidden = false
    end
end)

