Config.Quests = {
    ["collect_items"] = {
        label = "เก็บสมุนไพร 5 ชิ้น",
        objective = function(xPlayer)
            return xPlayer.getInventoryItem("herb").count >= 5
        end,
        reward = function(xPlayer)
            xPlayer.addMoney(1000)
        end
    },
    ["drive_distance"] = {
        label = "ขับรถให้ครบ 3 กิโลเมตร",
        objective = function(xPlayer)
            -- ต้องติดระบบระยะทางแยกเอง (ทำใน step ต่อไปได้)
            return false
        end,
        reward = function(xPlayer)
            xPlayer.addInventoryItem("repairkit", 1)
        end
    }
}
