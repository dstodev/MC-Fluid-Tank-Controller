local Trigger = {}
Trigger.__index = Trigger

setmetatable(Trigger, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function Trigger.new(left, right, left_callback, right_callback)
    local self = {}

    setmetatable(self, Trigger)

    self._left = left
    self._right = right
    self._position = 0
    self._state = -1

    self._left_callback = left_callback
    self._right_callback = right_callback

    return self
end

function Trigger:increment(value)
    self._position = self._position + value
    self:_manage_state()
end

function Trigger:decrement(value)
    self._position = self._position - value
    self:_manage_state()
end

function Trigger:update(value)
    self._position = value
    self:_manage_state()
end

function Trigger:_manage_state()
    if (self._state == 0 or self._state == -1) and self._position > self._right then
        self._right_callback()
        self._state = 1
    elseif (self._state == 1 or self._state == -1) and self._position < self._left then
        self._left_callback()
        self._state = 0
    end
end

return Trigger
