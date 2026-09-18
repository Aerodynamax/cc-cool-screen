-- TODO: remove this for prod
require("libs.dev_env")

-- table reducing
require("libs.reduce")

local screen = require("libs.screen")

-- ---@type inventory|Peripheral
-- local storage = peripheral.find("chest")

screen.reset()
screen.clear()
screen.setTextScale(5)
screen.writeCenter("Welcome!", colors.white, colors.blue, " ")
screen.flush()

screen.setCursorPos(1, 2)
screen.setCursorBlink(false)
-- screen.flush()
