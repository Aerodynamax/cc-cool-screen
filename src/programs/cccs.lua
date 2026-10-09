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
screen.writeCenter("overview", colors.white, colors.blue, " ")

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

    -- don't waste time if it doesn't need to be wasted
    if storage.indexer.load() then
        screen.reset()
        screen.clearLineY(screen.height())
        return
    end

    parallel.waitForAll(
        storage.indexer.index,
        function()
            while not storage.indexer.isIndexed do
                screen.clearLineY(screen.height())
                screen.write(storage.indexer.latestLog[#storage.indexer.latestLog])
                sleep(0)
            end
        end
    )
    sleep(0)
    screen.reset()
    screen.clearLineY(screen.height())
end

--#endregion



screen.flush()
screen.reset()

print("started!")

function mainloop()
    parallel.waitForAll(
        function()
            while true do
                screen.writeCenter("overview", colors.white, colors.blue, " ")
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
                screen.clearLineY(3)
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

        sleep(0) -- wait for it to start
        -- wait for initial displayed indexing to happen
        while not storage.indexer.isIndexed do
            sleep(1)
        end

        print("[item indexer] continuous indexing started.")
        -- continuous indexing
        while true do
            sleep(5)
            storage.indexer.index()
        end
    end
)
