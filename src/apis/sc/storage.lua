-- add reduce function
-- require("sc.reduce")


---@type inventory|Peripheral
local chest = peripheral.find("inventory")

---@class Storage: inventory
local storage = chest

function storage.totalCount()
    local count = 0

    for idx = 1, storage.size() do
        local item = storage.getItemDetail(idx)
        if item ~= nil then
            count = count + item.count
        end
    end

    return count
end

return storage
