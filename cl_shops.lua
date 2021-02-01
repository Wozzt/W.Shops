ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end 
end)  

Wozz              = {}
Wozz.DrawDistance = 100
Wozz.Size         = {x = 0.6, y = 0.6, z = 0.6}
Wozz.Color        = {r = 125, g = 63, b = 175}
Wozz.Type         = 25



local menushop = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 200, 100}, Title = 'Supérette'},
	Data = { currentMenu = "Articles Disponibles", GetPlayerName()},
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			local btn = btn.name

			if btn == "Nourritures" then
				OpenMenu("Nourritures")	
			elseif btn == "Divers" then
				OpenMenu("Divers")
			elseif btn == "Pain" then
				OpenMenu("Payement")
			elseif btn == "Téléphone" then
				OpenMenu("Payement ")
			elseif btn == "Cash" then
				TriggerServerEvent('wozztv:buycash', 'bread', 5)
			elseif btn == "Banque" then
				TriggerServerEvent('wozztv:buybanque', 'bread', 5)
			elseif btn == "Cash " then
				TriggerServerEvent('wozztv:buycash', 'phone', 5)
			elseif btn == "Banque " then
				TriggerServerEvent('wozztv:buybanque', 'phone', 5)

		end
	end,
},

	Menu = {
		["Articles Disponibles"] = {
			b = {
				{name = "Nourritures",ask = "→→→", askX = true},
				{name = "Divers",ask = "→→→", askX = true},
			}
		},
		["Nourritures"] = {
			b = {
				{name = "Pain",ask = "~g~5$", askX = true},

			}
		},
		["Divers"] = {
			b = {
				{name = "Téléphone",ask = "~g~5$", askX = true},

			}
		},
		["Payement"] = {
			b = {
				{name = "Cash", ask = "", askX = true},
				{name = "Banque", ask = "", askX = true}, 
			}
		},
		["Payement "] = {
			b = {
				{name = "Cash ", ask = "", askX = true},
				{name = "Banque ", ask = "", askX = true}, 
			}
		}


	}	
}

local pos = {
	{x = -48.35,   y = -1757.86,  z = 28.45},
	{x = -706.08,  y = -914.44,  z = 19.2},
	{x = 1959.84,  y = 3740.44,  z = 32.36},
	{x = 24.26,  y = -1345.53,  z = 29.56},
	{x = 1727.61,  y = 6414.85,  z = 35.03},
	{x = -3241.87,  y = 999.86,  z = 12.83} 
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(pos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder ~g~au magasin.")
				if IsControlJustPressed(1,51) then 					
                    CreateMenu(menushop) 
				end
            end
        end
    end  
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_shopkeep_01",-47.25,-1758.8,28.42, 45.65, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, true) 
    FreezeEntityPosition(ped, true) 
    SetEntityInvincible(ped, true) 
end)

Citizen.CreateThread(function()

    for k in pairs(pos) do

	local blip = AddBlipForCoord(pos[k].x, pos[k].y, pos[k].z)

	SetBlipSprite(blip, 59)
	SetBlipColour(blip, 2)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("LTD")
    EndTextCommandSetBlipName(blip)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId()), true

        for k in pairs(pos) do
            if (Wozz.Type ~= -1 and GetDistanceBetweenCoords(coords, pos[k].x, pos[k].y, pos[k].z, true) < Wozz.DrawDistance) then
                DrawMarker(Wozz.Type, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Wozz.Size.x, Wozz.Size.y, Wozz.Size.z, Wozz.Color.r, Wozz.Color.g, Wozz.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
			end
        end
    end
end)