-- setup peripherals
if periphemu ~= nil then
    if periphemu.create("left", "monitor") then
        print("[dev env] setup monitor")
    end
    if periphemu.create("right", "chest") then
        print("[dev env] setup storage")
    end
end

-- setup path
local function addShellPath(dir)
    local path = dir
    local shellPath = shell.path()
    local basePath = ":" .. path
    help.setPath(help.path() .. basePath .. "help")
    basePath = basePath .. "programs/"

    shellPath = shellPath .. basePath
    if term.isColor() then
        shellPath = shellPath .. basePath .. "advanced"
    end
    if turtle then
        shellPath = shellPath .. basePath .. "turtle"
    else
        shellPath = shellPath .. basePath .. "rednet"
        shellPath = shellPath .. basePath .. "fun"
        if term.isColor() then
            shellPath = shellPath .. basePath .. "fun/advanced"
        end
    end
    if pocket then
        shellPath = shellPath .. basePath .. "pocket"
    end
    if commands then
        shellPath = shellPath .. basePath .. "command"
    end
    if http then
        shellPath = shellPath .. basePath .. "http"
    end
    shell.setPath(shellPath)
end

addShellPath("src/")
