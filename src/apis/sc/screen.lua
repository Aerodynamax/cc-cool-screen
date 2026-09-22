---@type ccTweaked.peripherals.Monitor|unknown
local monitor = peripheral.find("monitor")

-- nil check (for lua-ls)
if not monitor then
    return monitor
end

---@class Screen: ccTweaked.peripherals.Monitor
local screen = monitor


--- Writes a piece of text to the center of the screen.
--- @param text string the text being printed
--- @param colorFg number foreground color, use `colors.*` for it
--- @param colorBg number background color, use `colors.*` for it
--- @param padSidesWith? string A 1 char thing that will be added to both sides of the text so the color fills the whole row, leave out to not do means it won't do that
function screen.writeCenter(text, colorFg, colorBg, padSidesWith)
    local x, y = screen.getCursorPos()
    local width, height = monitor.getSize()

    -- since the text will overrite it anyway
    if padSidesWith ~= nil then
        -- get only first char
        padSidesWith = string.sub(padSidesWith, 1, 2)
        screen.setCursorPos(1, y)

        screen.writeColor(
            string.rep(padSidesWith, width),
            colorFg,
            colorBg
        )

        -- add spaces to both sides of text so it has a gap between padding and text
        text = " " .. text .. " "
    end


    screen.setCursorPos(math.floor((width - #text) / 2) + 1, y)
    screen.writeColor(text, colorFg, colorBg)
end

--- Writes a piece of text to the right of the screen.
--- @param text string the text being printed
--- @param y integer the y position of the text
--- @param colorFg number foreground color, use `colors.*` for it
--- @param colorBg number background color, use `colors.*` for it
function screen.writeRight(text, y, colorFg, colorBg)
    local width, height = monitor.getSize()

    screen.setCursorPos(width - #text, y)

    screen.writeColor(text, colorFg, colorBg)
end

--- Write the specified text to the screen.
--- @param text string the text being printed
--- @param colorFg number foreground color, use `colors.*` for it
--- @param colorBg number background color, use `colors.*` for it
function screen.writeColor(text, colorFg, colorBg)
    screen.blit(
        text,
        text.rep(colors.toBlit(colorFg), #text),
        text.rep(colors.toBlit(colorBg), #text)
    )
end

--- Resets the color & cursor pos & scale of the screen.  <br>**DOES NOT CLEAR THE SCREEN.**
function screen.reset()
    -- screen.clear()
    screen.setBackgroundColor(colors.black)
    screen.setTextColor(colors.white)
    screen.setTextScale(1)
    screen.setCursorPos(1, 1)
end

--- Updates the screen. (e.g. apply background colour changes without needing to print text)
function screen.flush()
    screen.write("")
end

return screen
