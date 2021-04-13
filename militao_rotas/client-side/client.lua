local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

militao = Tunnel.getInterface("militao_rotas")
-----------------------------------------------------------------------------------------------------------------------------------------
local service = false
local selecionado = 1
local verify = false
local militin = 1 
CreateThread(function()
    repeat
        Wait(militin)
        if not service then 
            for k,v in pairs(blip) do
                local ped = PlayerPedId()
                local cordplayer = GetEntityCoords(ped)
                local distance = GetDistanceBetweenCoords(cordplayer,v.x,v.y,v.z)
                if distance < 7 and distance > 2 then 
                    drawText3D(v.x,v.y,v.z,"~r~[ E ]~w~ PARA ENTRAR EM ~r~SERVIÇO~w~")
                end
                if distance < 2 then 
                    drawText3D(v.x,v.y,v.z,"~g~[ E ]~w~ PARA ENTRAR EM ~g~SERVIÇO~w~")
                    if IsControlJustPressed(0,38) then
                        TriggerEvent("Notify","sucesso",militaox,1000) 
                        service = true
                        CriandoBlip(rota,selecionado)
                    end
                end 
            end
        end
    until false
end)
CreateThread(function()
    repeat
        Wait(militin)
        if service then
            local ped = PlayerPedId()
            local cordplayer = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(cordplayer,rota[selecionado].x,rota[selecionado].y,rota[selecionado].z)
            if distance < 8 then
                drawText3D(rota[selecionado].x,rota[selecionado].y,rota[selecionado].z,"PRECIONE ~b~[E]~w~ PARA PEGAR AS ~b~PEÇAS~w~")
                if IsControlJustPressed(0,38) then
                    militao.ganharItem()
                    RemoveBlip(blips)
                    selecionado = selecionado +1
                    if selecionado >= numeroderotas + 1 then
                        selecionado = 1
                    end
                    CriandoBlip(rota,selecionado)
                end
            end
        end         
    until false
end)
CreateThread(function ()
    repeat
        Wait(1)
        if IsControlJustPressed(0,168) then 
            service = false
            TriggerEvent("Notify","negado","Voce saiu de serviço",1000)
            RemoveBlip(blips)
            selecionado = 1         
        end
    until false
end)



function drawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
end
function CriandoBlip(rota,selecionado)
    blips = AddBlipForCoord(rota[selecionado].x,rota[selecionado].y,rota[selecionado].z)
    SetBlipSprite(blips,1)
    SetBlipColour(blips,3)
    SetBlipScale(blips,0.4)
    SetBlipAsShortRange(blips,false)
    SetBlipRoute(blips,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Entrega")
    EndTextCommandSetBlipName(blips)
end