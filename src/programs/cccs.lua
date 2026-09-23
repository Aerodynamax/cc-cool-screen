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

--#region Indexing

local storage = require("sc.storage")

if storage == nil then
    screen.setTextScale(3)
    screen.writeCenter("ERROR: no storage found", colors.red)
end

screen.setCursorPos(1, 3)
screen.writeColor("indexing storage ...", colors.white, colors.black)
screen.setCursorPos(1, 4)
screen.writeColor(" (this may take some time ...)", colors.gray, colors.black)
screen.flush()
screen.reset()

sleep(3)

if storage then
    parallel.waitForAll(
        storage.index.index,
        function()
            while not storage.index.isIndexed do
                sleep(0)
                screen.setCursorPos(1, 3)
                screen.clearLine()
                screen.write(storage.index.latestLog[#storage.index.latestLog])
            end
        end
    )
end

--#endregion



-- remove the (this might take some time) disclaimer
screen.setCursorPos(1, 4)
screen.clearLine()
screen.flush()
screen.reset()

print("started!")

while true do
    screen.writeRight("" .. os.date("%a %H:%M:%S"), 1, colors.white, colors.blue)
    screen.reset()

    screen.setCursorPos(1, 3)
    if storage then
        screen.write("storage: " ..
            storage.count() .. "/" .. storage.maxCount() .. " (" .. (storage.percentage()) .. "%)")
    end

    sleep(0)
end
