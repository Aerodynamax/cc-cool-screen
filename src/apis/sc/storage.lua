-- require()
bigInv = require("fbc.mega_inventory")

--- Returns all connected peripherals of the stated type
---@param peripheralType ccTweaked.peripherals.type|string the type of peripheral to look for
function peripheral.allOfType(peripheralType)
    ---@type ccTweaked.peripherals.Command[]
    ---|ccTweaked.peripherals.Computer[]
    ---|ccTweaked.peripherals.Drive[]
    ---|ccTweaked.peripherals.EnergyStorage[]
    ---|ccTweaked.peripherals.FluidStorage[]
    ---|ccTweaked.peripherals.Inventory[]
    ---|ccTweaked.peripherals.Modem[]
    ---|ccTweaked.peripherals.Monitor[]
    ---|ccTweaked.peripherals.Printer[]
    ---|ccTweaked.peripherals.Speaker[]
    ---|ccTweaked.peripherals.WiredModem[]
    return peripheral.find(
        peripheralType,
        function(name, wrapped)
            return peripheral.hasType(wrapped, "inventory") or false
        end
    )
end

chest = bigInv.new(peripheral.allOfType("inventory"))

-- ---@type ccTweaked.peripherals.Inventory|any
-- local chest = peripheral.find("inventory")

if not chest then
    error("Error loading inventories: did you actually connect the chests to the computer?")
end

---@class Storage: MegaInventory
local storage = chest

--#region helpers

--- Safely get detailed information about an item in this inventory.
---@param slot integer The slot to get more info about
---@return ItemDetailed? info Information about the item in the slot or nil if no item is present
function storage:getItemDetailSafe(slot)
    local successful, details = pcall(storage.getItemDetail, self, slot)

    if successful and details then
        return details
    else
        return nil
    end
end

--#endregion

--#region indexing

---@class ItemDetails
---@field name string The item name
---@field displayName string The item display name
---@field maxCount integer The nax number of this item per slot

---@class StorageIndexer Functions and values relating to storage indexing (a list of all types of items for fast maxCount lookups & stuff).
storage.indexer = {}

---@type integer The default max stack size of an item the indexer hasn't indexed
storage.indexer.defaultMaxCount = 64

---@type boolean Whether the storage system has been indexed.  If it is false, you need to run storage.index.index()
storage.indexer.isIndexed = false

---@type string[] The log of the most recent indexing attempt.  Reset when calling `storage.index.index()`
storage.indexer.latestLog = {}

---@type table<string, ItemDetails> A cache of all item type's details for performance. <br> <br> **TODO: make this store full details, also use name+tags for index**
storage.indexer.itemTypes = {}

--- Returns the number of unique item types the indexer has stored.
---@return integer -- the number of unique item types the indexer has stored
function storage.itemTypesCount()
    local count = 0
    for _ in pairs(storage.indexer.itemTypes) do
        count = count + 1
    end
    return count
end

-- get item maxes & names
function storage.indexer.index()
    storage.indexer.isIndexed = false
    storage.indexer.latestLog = { "starting indexing ..." }

    local initialItemTypes = storage.itemTypesCount()

    local list = storage:list()

    for i, item in ipairs(list) do
        -- only update new values
        if item and not storage.indexer.itemTypes[item.name] then
            local details = storage:getItemDetailSafe(i)

            if details then
                storage.indexer.itemTypes[item.name] = {
                    name = item.name,
                    displayName = details.displayName,
                    maxCount = details.maxCount
                }
            end

            -- sleep is only required if we run getItemDetail because it peripheral calls take 1 tick to do
            sleep(0) -- allow keyboard interupts
        end

        table.insert(storage.indexer.latestLog, "indexing: " .. math.floor((i / #list) * 100) .. "%")
    end

    -- save if found anything new
    if storage.itemTypesCount() > initialItemTypes then
        table.insert(storage.indexer.latestLog, "saving index ...")
        if storage.indexer.save() then
            table.insert(storage.indexer.latestLog, "saved index successfully.")
        else
            table.insert(storage.indexer.latestLog, "failted to saved index, probably no storage remaining.")
        end
    end

    storage.indexer.isIndexed = true
    table.insert(storage.indexer.latestLog, "indexed " .. storage.itemTypesCount() .. " unique items successfully.")
end

--- Index a slot and return the details of that item.  If the slot is already indexed or the slot can't be accessed, returns nil.
---@param slot number The slot to index
---@return ItemDetailed? -- The details of the given slot
function storage.indexer:indexSlot(slot)
    local details = storage:getItemDetailSafe(slot)

    if details and not storage.indexer.itemTypes[details.name] then
        storage.indexer.itemTypes[details.name] = {
            name = details.name,
            displayName = details.displayName,
            maxCount = details.maxCount
        }
        return details
    end
end

---@type string The path where the index is saved/loaded from.  Basically required for large storage systems as computers reboot when unloaded & reloaded.
storage.indexer.savePath = ".indexedDB"

--- Save the current indexed DB so it can be loaded next time.
---@return boolean -- Whether the save was successful or not
function storage.indexer.save()
    print("[items indexer] saving index to disk ...")

    local file = fs.open(storage.indexer.savePath, "w+")
    if not file then
        print("[items indexer] failed to save index.")
        return false
    end

    file.write(textutils.serialise(storage.indexer.itemTypes, { allow_repetitions = false, compact = true }))
    file.close()

    print("[items indexer] saved index to disk.")

    return true
end

--- Save the current indexed DB so it can be loaded next time.
---@return boolean -- Whether the save was successful or not
function storage.indexer.load()
    storage.indexer.isIndexed = false
    print("[items indexer] loading index from disk ...")

    if not fs.exists(storage.indexer.savePath) then
        print("[items indexer] failed to load index: not found.")
        return false
    end

    local file = fs.open(storage.indexer.savePath, "r")

    if not file then
        print("[items indexer] failed to load index: not sure.")
        return false
    end

    storage.indexer.itemTypes = textutils.unserialise(file.readAll() or "") or {}

    print("[items indexer] loaded " .. storage.itemTypesCount() .. " items into index.")

    file.close()
    storage.indexer.isIndexed = true
    return true
end

--#endregion

--- Returns the number of items currently in the inventory.
---@return integer -- The number of items currently in the inventory
function storage.count()
    local count = 0

    for i, item in ipairs(storage:list()) do
        if item ~= nil and item.count ~= nil then
            count = count + item.count
        end
    end

    return count
end

--- Returns the maximum number of items the inventory can hold.
---@return integer -- The maximum number of items the inventory can hold
function storage.maxCount()
    local list = storage:list()
    -- offset with the extra bit that doesn't get indexed
    local remainderCount = storage:size()

    local count = 0

    for i, item in ipairs(list) do
        if item then
            -- if fast lookups are available, use them
            if storage.indexer.itemTypes[item.name] then
                count = count + storage.indexer.itemTypes[item.name].maxCount
            else
                local details = storage.indexer:indexSlot(i)
                if details then
                    count = count + (details.maxCount or storage.indexer.defaultMaxCount) -- fallback
                else
                    count = count + storage.indexer.defaultMaxCount
                end

                sleep(0) -- TODO: potentially not needed
            end
        else
            count = count + storage.indexer.defaultMaxCount
        end
        remainderCount = remainderCount - 1
    end

    return count + (remainderCount * storage.indexer.defaultMaxCount)
end

--- Returns the percentage of storage taken up
---@return integer
function storage.percentage()
    return math.floor((storage:count() / storage.maxCount()) * 100)
end

return storage
