ESX.RegisterServerCallback('dailyquest:getQuest', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll("SELECT * FROM user_quests WHERE identifier = @id", {
        ['@id'] = identifier
    }, function(result)
        if result[1] then
            local questId = result[1].quest
            local quest = Config.Quests[questId]

            -- เช็คว่าเควสนี้ทำสำเร็จหรือยัง
            local completed = result[1].completed == 1

            cb({
                label = quest.label,
                completed = completed,
                questId = questId
            })
        else
            -- ถ้ายังไม่มีข้อมูล จะสุ่มเควส
            local newQuest = getRandomQuest()
            MySQL.Async.execute("INSERT INTO user_quests (identifier, quest, completed, last_reset) VALUES (@id, @quest, 0, NOW())", {
                ['@id'] = identifier,
                ['@quest'] = newQuest
            }, function()
                cb({
                    label = Config.Quests[newQuest].label,
                    completed = false,
                    questId = newQuest
                })
            end)
        end
    end)
end)

function getRandomQuest()
    local keys = {}
    for k in pairs(Config.Quests) do table.insert(keys, k) end
    return keys[math.random(#keys)]
end
