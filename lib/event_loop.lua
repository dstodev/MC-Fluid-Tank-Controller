-- OpenComputers Lib
ev = require("event")

-- Event Loop
local EventLoop = {}
EventLoop.__index = EventLoop

setmetatable(EventLoop, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function EventLoop.new()
    local self = {}

    setmetatable(self, EventLoop)

    self._events = {}
    self._running = false

    return self
end

function EventLoop:run()
    print("in run")

    self._running = true

    while self._running do
        self:_handle(ev.pull())
    end
end

function EventLoop:register(event, callback)
    print("in register")
    self._events[event] = callback
end

function EventLoop:_handle(event, ...)
    if event and self._events[event] then
        self._events[event](...)
    end
end

return EventLoop
