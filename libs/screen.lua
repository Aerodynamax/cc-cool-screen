--- Add typing to monitor

-- require("0.peripheral.monitor")

--- @type peripheral.monitor
local monitor = peripheral.find("monitor")

---@class Screen: peripheral.monitor
local screen = monitor


-- screen.centerOffset = {
--     x = screen.width / 2,
--     y = screen.height / 2,
-- }

--- Writes a piece of text to the center of the screen
--- @param text string
--- @return nil
function screen.write_center(text)
    local x, y = screen.getCursorPos()
    local width, height = monitor.getSize()
    screen.setCursorPos(math.floor((width - #text) / 2) + 1, y)
    screen.write(text)
end

--- Clears the screen and resets the cursor pos
function screen.reset()
    screen.clear()
    screen.setCursorPos(1, 1)
end

--- Updates the screen. (e.g. apply background colour changes without needing to print text)
function screen.flush()
    screen.write("")
end

return screen
