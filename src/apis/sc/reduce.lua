---Reduces an array
---@param list any[] An array
---@param fn function The reduction predicate
---@param init any The initial accumulator value
---@return any -- The final value of the accumulator
table.reduce = function(list, fn, init)
    local acc = init
    for k, v in ipairs(list) do
        if 1 == k and not init then
            acc = v
        else
            acc = fn(acc, v)
        end
    end
    return acc
end
