-- ---@meta
-- ---@class peripheral.monitor
-- local monitor = {}

-- --- Set the scale of this monitor. A larger scale will result in the monitor having a lower resolution, but display text much larger.
-- ---@param scale number The monitor's scale. This must be a multiple of 0.5 between 0.5 and 5.
-- function monitor.setTextScale(scale) end

-- --- Get the monitor's current text scale.
-- ---@return number scale The monitor's current scale.
-- function monitor.getTextScale() end

-- --- Write text at the current cursor position, moving the cursor to the end of the text.<br><br>
-- --- Unlike functions like _G.write and print, this does not wrap the text - it simply copies the text to the current terminal line.
-- ---@param text string The text to write.
-- function monitor.write(text) end

-- --- Move all positions up (or down) by y pixels.<br><br>
-- --- Every pixel in the terminal will be replaced by the line y pixels below it. If y is negative, it will copy pixels from above instead.
-- ---@param y number The number of lines to move up by. This may be a negative number.
-- function monitor.scroll(y) end

-- --- Get the position of the cursor.
-- ---@return number x The x position of the cursor.
-- ---@return number y The y position of the cursor.
-- function monitor.getCursorPos() end

-- --- Set the position of the cursor. Terminal writes will begin from this position.
-- ---@param x number The new x position of the cursor.
-- ---@param y number The new y position of the cursor.
-- function monitor.setCursorPos(x, y) end

-- --- Checks if the cursor is currently blinking.
-- ---@return boolean
-- function monitor.getCursorBlink() end

-- --- Sets whether the cursor should be visible (and blinking) at the current cursor position.
-- ---@param blink boolean Whether the cursor should blink.
-- function monitor.setCursorBlink(blink) end

-- --- Get the size of the terminal.
-- ---@return number width The terminal's width.
-- ---@return number height The terminal's height.
-- function monitor.getSize() end

-- --- Clears the terminal, filling it with the current background colour.
-- function monitor.clear() end

-- --- Clears the line the cursor is currently on, filling it with the current background colour.
-- function monitor.clearLine() end

-- --- Return the colour that new text will be written as.
-- ---@return number colour The current text colour.
-- ---@see colors For a list of colour constants, returned by this function.
-- function monitor.getTextColour() end

-- --- Return the colour that new text will be written as.
-- ---@return number color The current text color.
-- ---@see colors For a list of color constants, returned by this function.
-- function monitor.getTextColor() end

-- --- Set the colour that new text will be written as.
-- ---@param colour number The new text colour.
-- ---@see colors For a list of colour constants, returned by this function.
-- function monitor.setTextColour(colour) end

-- --- Set the colour that new text will be written as.
-- ---@param colour integer The new text colour.
-- ---@see colors For a list of color constants, returned by this function.
-- function monitor.setTextColor(colour) end

-- --- Return the current background colour. This is used when writing text and clearing the terminal.
-- ---@return number colour The current background colour.
-- ---@see colors For a list of colour constants, returned by this function.
-- function monitor.getBackgroundColour() end

-- --- Return the current background color. This is used when writing text and clearing the terminal.
-- ---@return number color The current background color.
-- ---@see colors For a list of color constants, returned by this function.
-- function monitor.getBackgroundColor() end

-- --- Set the current background colour. This is used when writing text and clearing the terminal.
-- ---@param colour number The new background colour.
-- ---@see colors For a list of colour constants.
-- function monitor.setBackgroundColour(colour) end

-- --- Set the current background color. This is used when writing text and clearing the terminal.
-- ---@param colour number The new background color.
-- ---@see colors For a list of color constants.
-- function monitor.setBackgroundColor(colour) end

-- --- Determine if this terminal supports colour.<br><br>
-- --- Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be displayed in greyscale.
-- ---@return boolean -- Whether this terminal supports colour.
-- function monitor.isColour() end

-- --- Determine if this terminal supports color.<br><br>
-- --- Terminals which do not support color will still allow writing colored text/backgrounds, but it will be displayed in greyscale.
-- ---@return boolean -- Whether this terminal supports color.
-- function monitor.isColor() end

-- --[[
-- Writes text to the terminal with the specific foreground and background colours.

-- As with write, the text will be written at the current cursor location, with the cursor moving to the end of the text.

-- textColour and backgroundColour must both be strings the same length as text. All characters represent a single hexadecimal digit, which is converted to one of CC's colours. For instance, "a" corresponds to purple.
-- ]]
-- ---@param text string The text to write.
-- ---@param textColour string The corresponding text colours.
-- ---@param backgroundColour string The corresponding background colours.
-- ---@see colors For a list of colour constants, and their hexadecimal values.
-- function monitor.blit(text, textColour, backgroundColour) end

-- --[[
-- Set the palette for a specific colour.

-- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make colors.red more red by setting its palette to #FF0000. This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
-- ]]
-- ---@param index number The colour whose palette should be changed.
-- ---@param colour number A 24-bit integer representing the RGB value of the colour. For instance the integer 0xFF0000 corresponds to the colour #FF0000.
-- ---@see colors.unpackRGB To convert from the 24-bit format to three separate channels.
-- ---@see colors.packRGB To convert from three separate channels to the 24-bit format.
-- function monitor.setPaletteColour(index, colour) end

-- --[[
-- Set the palette for a specific colour.

-- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make colors.red more red by setting its palette to #FF0000. This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
-- ]]
-- ---@param index number The colour whose palette should be changed.
-- ---@param r number The intensity of the red channel, between 0 and 1.
-- ---@param g number The intensity of the green channel, between 0 and 1.
-- ---@param b number The intensity of the blue channel, between 0 and 1.
-- ---@see colors.unpackRGB To convert from the 24-bit format to three separate channels.
-- ---@see colors.packRGB To convert from three separate channels to the 24-bit format.
-- function monitor.setPaletteColour(index, r, g, b) end

-- --[[
-- Set the palette for a specific color.

-- ComputerCraft's palette system allows you to change how a specific color should be displayed. For instance, you can make colors.red more red by setting its palette to #FF0000. This does now allow you to draw more colors - you are still limited to 16 on the screen at one time - but you can change which colors are used.
-- ]]
-- ---@param index number The color whose palette should be changed.
-- ---@param colour number A 24-bit integer representing the RGB value of the color. For instance the integer 0xFF0000 corresponds to the colour #FF0000.
-- ---@see colors.unpackRGB To convert from the 24-bit format to three separate channels.
-- ---@see colors.packRGB To convert from three separate channels to the 24-bit format.
-- function monitor.setPaletteColor(index, colour) end

-- --[[
-- Set the palette for a specific color.

-- ComputerCraft's palette system allows you to change how a specific color should be displayed. For instance, you can make colors.red more red by setting its palette to #FF0000. This does now allow you to draw more colors - you are still limited to 16 on the screen at one time - but you can change which colors are used.
-- ]]
-- ---@param index number The color whose palette should be changed.
-- ---@param r number The intensity of the red channel, between 0 and 1.
-- ---@param g number The intensity of the green channel, between 0 and 1.
-- ---@param b number The intensity of the blue channel, between 0 and 1.
-- ---@see colors.unpackRGB To convert from the 24-bit format to three separate channels.
-- ---@see colors.packRGB To convert from three separate channels to the 24-bit format.
-- function monitor.setPaletteColor(index, r, g, b) end

-- --- Get the current palette for a specific colour.
-- ---@param colour number The colour whose palette should be fetched.
-- ---@return number r The red channel, will be between 0 and 1.
-- ---@return number g The green channel, will be between 0 and 1.
-- ---@return number b The blue channel, will be between 0 and 1.
-- function monitor.getPaletteColour(colour) end

-- --- Get the current palette for a specific color.
-- ---@param colour number The color whose palette should be fetched.
-- ---@return number r The red channel, will be between 0 and 1.
-- ---@return number g The green channel, will be between 0 and 1.
-- ---@return number b The blue channel, will be between 0 and 1.
-- function monitor.getPaletteColor(colour) end

-- return monitor
