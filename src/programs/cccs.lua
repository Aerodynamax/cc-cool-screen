-- load paths
require(settings.get("ghu.base") .. "core/apis/ghu")


-- for dev
if fs.exists("dev_env.lua") then
    require("dev_env")
end

print("starting up ...")

local screen = require("sc.screen")

screen.reset()
screen.clear()
-- screen.setTextScale(5)
screen.writeCenter("screen", colors.white, colors.blue, " ")
screen.flush()
screen.reset()

print("started!")

local storage = require("sc.storage")

while true do
    screen.writeRight("" .. os.date("%a %H:%M:%S"), 1, colors.white, colors.blue)
    screen.reset()

    screen.setCursorPos(1, 3)
    screen.write("storage: " .. storage.totalCount())
end
