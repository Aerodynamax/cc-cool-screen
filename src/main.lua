require(settings.get("ghu.base") .. "core/apis/ghu")


-- for dev (currently not working :sob:)
require("dev_env")

-- table reducing
require("reduce")

local screen = require("screen")

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
