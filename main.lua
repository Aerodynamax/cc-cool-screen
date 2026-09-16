-- TODO: remove this for prod
require("libs.dev_env")

-- table reducing
require("libs.reduce")

local screen = require("libs.screen")
-- storage = peripheral.find("chest")
-- print(screen.write_center())

screen.reset()
screen.setTextScale(5)
screen.write_center("Welcome!")
screen.flush()

-- screen.setTextScale(1)
screen.setCursorPos(1, 2)
screen.setCursorBlink(false)
-- screen.flush()
