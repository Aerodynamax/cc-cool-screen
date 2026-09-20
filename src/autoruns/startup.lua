-- auto run changes on update

---@type table
local ghu = require(settings.get("ghu.base") .. "core/apis/ghu")

---@type string
local path = ghu.getRepoPath("Aerodynamax/cc-cool-screen")

-- run
require(path .. "/main")
