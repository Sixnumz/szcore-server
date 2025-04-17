RegisterServerEvent("dailyquest:claimReward")
AddEventHandler("dailyquest:claimReward", function(questId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll("SELECT * FROM user_quests WHERE identifier = @id", {
        ['@id'] = identifier
    }, function(result)
        if result[1] and result[1].quest == questId and result[1].completed == 0 then
            local quest = Config.Quests[questId]
            if quest.objective(xPlayer) then
                -- แจกของ
                quest.reward(xPlayer)

                -- อัปเดตสถานะ
                MySQL.Async.execute("UPDATE user_quests SET completed = 1 WHERE identifier = @id", {
                    ['@id'] = identifier
                })

                TriggerClientEvent('esx:showNotification', source, '✅ รับรางวัลเรียบร้อย!')
            else
                TriggerClientEvent('esx:showNotification', source, '❌ ยังไม่สำเร็จภารกิจ')
            end
        end
    end)
end)
