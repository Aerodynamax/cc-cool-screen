-- add reduce function
-- require("sc.reduce")


---@type ccTweaked.peripherals.Inventory|any
local chest = peripheral.find("inventory")

if not peripheral.hasType(chest, "inventory") then
    return
end

---@class Storage: ccTweaked.peripherals.Inventory
local storage = chest

--#region indexing

---@class ItemDetails
---@field name string The item name
---@field displayName string The item display name
---@field maxCount integer The nax number of this item per slot

---@type { string: ItemDetails }
storage.itemTypes = {}

---@type integer
storage.freeSpace = 0


-- ---@type { string: boolean|nil }
-- storage.itemNames = {}

-- TODO: update item catalogue as we get more stuff
print("[storage] indexing ...")

-- get item maxes & names
local list = storage.list()

for i = 1, #list do
    local details = storage.getItemDetail(i)

    -- add if we haven't already
    if details == nil then
        print("empty")
        storage.freeSpace = storage.freeSpace + 64
    elseif not storage.itemTypes[details.name] then
        table.insert(storage.itemTypes, {
            details.name,
            details.displayName,
            details.maxCount
        })
    end

    if i % 10 == 1 then
        print("[storage] indexing: " .. (i / #list) * 100 .. "%")
    end
end

-- add the end bit that wasn't traversed
storage.freeSpace = storage.freeSpace + (storage.size() - #list) * 64

print("[storage] indexing complete.")
print("[storage] free space: " .. storage.freeSpace)

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
    local count = (storage.size() - #storage.list()) * 64

    for i, item in pairs(storage.list()) do
        if item ~= nil then
            maxToAdd = 64
            if storage.itemTypes[item.name] then
                maxToAdd = storage.itemTypes[item.name]
            end
            count = count + maxToAdd -- too slow: storage.getItemLimit(i)
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
