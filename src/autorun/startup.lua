-- load paths
if settings.get("ghu.base") ~= nil then
    print("getting paths")
    shell.run("startup")
    -- require(settings.get("ghu.base") .. "core/apis/ghu")
end


-- auto run changes on update
shell.openTab("cccs")
-- shell.run("cc-cs")
