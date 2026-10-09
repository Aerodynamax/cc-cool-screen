---@type ccTweaked.peripherals.Inventory[]
local inventories = {
    ---@diagnostic disable-next-line: assign-type-mismatch
    peripheral.find(
        "inventory",
        function(name, wrapped)
            return peripheral.hasType(wrapped, "inventory") or false
        end
    )
}

for i, inventory in pairs(inventories) do
    print("Size: " .. inventory.size())
end

function Account:new(o)
    o = o or {} -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end
