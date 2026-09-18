--- Add typing to monitor

-- require("0.peripheral.monitor")

---@type Monitor | Peripheral
local monitor = peripheral.find("monitor")

---@class Screen: Monitor
local screen = monitor


-- screen.centerOffset = {
--     x = screen.width / 2,
--     y = screen.height / 2,
-- }

--- Writes a piece of text to the center of the screen
--- @param text string
---@param colorFg number
---@param colorBg number
--- @return nil
function screen.write_center(text, colorFg, colorBg)
    local x, y = screen.getCursorPos()
    local width, height = monitor.getSize()
    screen.setCursorPos(math.floor((width - #text) / 2) + 1, y)

    screen.writeColor(text, colorFg, colorBg)
end

--- Write the specified text to the screen
---@param text string the text being printed
---@param colorFg number foreground color.  Use `colors.*` for it.
---@param colorBg number background color.  Use `colors.*` for it.
function screen.writeColor(text, colorFg, colorBg)
    screen.blit(
        text,
        text.rep(colors.toBlit(colorFg), #text),
        text.rep(colors.toBlit(colorBg), #text)
    )
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
