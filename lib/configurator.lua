-- OpenComputers Lib
local cm = require("component")
local os = require("os")

-- My Lib
local EventLoop = require("lib/event_loop")

-- Components
local gpu = cm.gpu

-- Internal Variables
local buttons = {}
local max_x, max_y = gpu.maxResolution()

-- Functions
local function create_button(id, x1, y1, x2, y2, callback)
    gpu.fill(x1, y1, x2 - x1 + 1, y2 - y1 + 1, "█")
    buttons[id] = {}
    buttons[id].x1 = x1
    buttons[id].y1 = y1
    buttons[id].x2 = x2
    buttons[id].y2 = y2
    buttons[id].fn = callback
end

local function button_handler(address, x, y, button, player)
    for k, v in pairs(buttons) do
        if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
            v.fn()
        end
    end
end

-- Set resolution to maximum
gpu.setResolution(max_x, max_y)

-- Clear the screen
gpu.fill(1, 1, max_x, max_y, " ")

-- Create test screen
create_button("one", 2, 2, 6, 6, function () print("Ayy") end)

-- Install button handler
ev = EventLoop()
ev:register("interrupted", function () os.exit() end)
ev:register("touch", button_handler)

-- Run event loop
ev:run()
