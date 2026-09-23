---@type ccTweaked.peripherals.Inventory|any
local chest = peripheral.find("inventory")

if not chest or not peripheral.hasType(chest, "inventory") then
    return nil
end

---@class Storage: ccTweaked.peripherals.Inventory
local storage = chest

--#region indexing

---@class ItemDetails
---@field name string The item name
---@field displayName string The item display name
---@field maxCount integer The nax number of this item per slot

---@type table<string, ItemDetails>
storage.itemTypes = {}

---@class StorageIndex Functions and values relating to storage indexing (a list of all types of items for fast maxCount lookups & stuff).
storage.index = {}

---@type integer The default max stack size of an item the indexer hasn't indexed
storage.index.defaultMaxCount = 64

---@type boolean Whether the storage system has been indexed.  If it is false, you need to run storage.index.index()
storage.index.isIndexed = false

---@type string[]
storage.index.latestLog = {}

-- get item maxes & names
function storage.index.index()
    storage.index.isIndexed = false
    table.insert(storage.index.latestLog, "starting indexing ...")

    local list = storage.list()

    for i, item in pairs(list) do
        -- only update new values
        if item and not storage.itemTypes[item.name] then
            local successful, details = pcall(storage.getItemDetail, i)

            if successful and details then
                storage.itemTypes[item.name] = {
                    name = item.name,
                    displayName = details.displayName,
                    maxCount = details.maxCount
                }
            end

            -- sleep is only required if we run getItemDetail because it peripheral calls take 1 tick to do
            sleep(0) -- allow keyboard interupts
        end

        table.insert(storage.index.latestLog, "indexing: " .. math.floor((i / #list) * 100) .. "%")
    end

    storage.index.isIndexed = true
    table.insert(storage.index.latestLog, "indexing completed.")
end

--#endregion

--- Returns the number of items currently in the inventory.
---@return integer -- The number of items currently in the inventory
function storage.count()
    local count = 0

    for i, item in pairs(storage.list()) do
        if item ~= nil and item.count ~= nil then
            count = count + item.count
        end
    end

    return count
end

--- Returns the maximum number of items the inventory can hold.
---@return integer -- The maximum number of items the inventory can hold
function storage.maxCount()
    -- offset with the extra bit that doesn't get indexed
    local count = (storage.size() - #storage.list()) * storage.index.defaultMaxCount

    for i, item in pairs(storage.list()) do
        if item ~= nil then
            -- if fast lookups are available, use them
            if storage.itemTypes[item.name] then
                count = count + storage.itemTypes[item.name].maxCount
            else
                count = count + (storage.getItemDetail(i).maxCount or storage.index.defaultMaxCount)
                sleep(0) -- yield
            end
        else
            count = count + storage.index.defaultMaxCount
        end
    end


    return count
end

--- Returns the percentage of storage taken up
---@return integer
function storage.percentage()
    return math.floor((storage.count() / storage.maxCount()) * 100)
end

return storage
