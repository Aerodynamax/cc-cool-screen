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

screen.setCursorPos(1, 3)
screen.writeColor("indexing storage ...", colors.white, colors.black)
screen.setCursorPos(1, 4)
screen.writeColor(" (this may take some time)", colors.gray, colors.black)
screen.flush()
screen.reset()

print("started!")

local storage = require("sc.storage")

-- remove the (this might take some time) disclaimer
screen.setCursorPos(1, 4)
screen.clearLine()
screen.flush()
screen.reset()


while true do
    screen.writeRight("" .. os.date("%a %H:%M:%S"), 1, colors.white, colors.blue)
    screen.reset()

    screen.setCursorPos(1, 3)
    screen.write("storage: " .. storage.count() .. "/" .. storage.maxCount() .. " (" .. (storage.percentage()) .. "%)")
end
