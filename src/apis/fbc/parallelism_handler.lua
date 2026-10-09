-- FROM: https://github.com/Fatboychummy-CC/Libraries/blob/main/parallelism_handler.lua

--- Parallelism handler: parallelizes certain peripheral calls.
local function newParallelismHandler()
    ---@class ParallelismHandler
    local parallelismHandler = {
        tasks = {},
        limit = 128,
        n = 0
    }

    --- Add a task to the parallelism handler.
    --- This method respects the task limit, and will execute the tasks if the limit is reached.
    ---@param task function The task to add.
    ---@param ... any The arguments to pass to the task
    function parallelismHandler:addTask(task, ...)
        self.n = self.n + 1
        self.tasks[self.n] = {
            task = task,
            args = table.pack(...),
        }

        if self.n >= self.limit then
            self:execute()
        end
    end

    --- Add a task to the parallelism handler, does not execute if the limit is reached.
    ---@param task function The task to add.
    ---@param ... any The arguments to pass to the task
    function parallelismHandler:addTaskNoExec(task, ...)
        self.n = self.n + 1
        self.tasks[self.n] = {
            task = task,
            args = table.pack(...),
        }
    end

    --- Execute all tasks in parallel.
    function parallelismHandler:execute()
        local _tasks = {}
        local _results = {}
        for i, task in ipairs(self.tasks) do
            _tasks[i] = function()
                _results[i] = task.task(table.unpack(task.args, 1, task.args.n))
            end
        end

        parallel.waitForAll(table.unpack(_tasks))
        self.tasks = {}
        self.n = 0
        return _results
    end

    return parallelismHandler
end

return newParallelismHandler
