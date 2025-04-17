-- ให้ของผู้เล่น
RegisterServerEvent("sz_test:giveItem")
AddEventHandler("sz_test:giveItem", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("water", 1) -- ให้ item น้ำ 1 ขวด
end)
