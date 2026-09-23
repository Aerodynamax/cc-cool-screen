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

screen.setCursorLine(screen.height())
screen.writeColor("indexing storage ...", colors.white, colors.black)
screen.writeColor(" (this may take some time ...)", colors.gray, colors.black)
screen.flush()
screen.reset()

function index()
    if not storage then
        return
    end

    parallel.waitForAll(
        storage.index.index,
        function()
            while not storage.index.isIndexed do
                sleep(0)
                screen.setCursorLine(screen.height())
                screen.clearLine()
                screen.write(storage.index.latestLog[#storage.index.latestLog])
            end
        end
    )

    screen.setCursorLine(screen.height())
    screen.clearLine()
end

--#endregion



screen.flush()
screen.reset()

print("started!")

function mainloop()
    parallel.waitForAll(
        function()
            while true do
                screen.writeRight("" .. os.date("%a %H:%M:%S"), 1, colors.white, colors.blue)
                sleep(0)
            end
        end,
        function()
            if not storage then
                return
            end

            -- do indexing
            index()

            while true do
                screen.writeLeft(
                    "storage: " .. storage.count() .. "/" .. storage.maxCount() .. " (" .. (storage.percentage()) .. "%)",
                    3,
                    colors.white,
                    colors.black
                )
                sleep(0) -- yield
            end
        end
    )
end

-- continuously index
parallel.waitForAny(
    mainloop,
    function()
        if not storage then error("No storage") end

        -- continuous indexing
        while true do
            storage.index.index()

            sleep(5)
        end
    end
)
