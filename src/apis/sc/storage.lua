-- add reduce function
require("sc.reduce")


---@type inventory|Peripheral
local chest = peripheral.find("inventory")

---@class Storage: inventory
local storage = chest

function storage.totalCount()
    return table.reduce(
        storage.list(),
        function(accumulated, itemInfo)
            return accumulated + itemInfo.count
        end,
        0
    )
end

return storage
