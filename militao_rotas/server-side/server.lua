local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")

militao = {}
Tunnel.bindInterface("militao_rotas",militao)
Proxy.addInterface("militao_rotas",militao)
----------------------------------------------------------------------------------------------------------------------
function militao.ganharItem()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if  vRP.giveInventoryItem(user_id,item,quantidadeDeItens,true) then
            return true
    
        end
    end          
end