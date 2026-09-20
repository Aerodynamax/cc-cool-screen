-- load paths
require(settings.get("ghu.base") .. "core/apis/ghu")


-- for dev
if fs.exists("dev_env.lua") then
    require("dev_env")
end

-- table reducing
require("sc.reduce")

local screen = require("sc.screen")

screen.reset()
screen.clear()
screen.setTextScale(5)
screen.writeCenter("Welcome!", colors.white, colors.blue, " ")
screen.flush()
screen.reset()

screen.setCursorPos(1, 2)


local storage = require("sc.storage")
local count = storage.totalCount()

screen.write("storage: " .. count)
