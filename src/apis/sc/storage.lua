-- add reduce function
-- require("sc.reduce")


---@type inventory|Peripheral
local chest = peripheral.find("inventory")

---@class Storage: inventory
local storage = chest

function storage.totalCount()
    local count = 0

    for idx = 1, #storage.size() do
        count = count + storage.getItemDetail(1).count
    end

    return count
end

return storage
