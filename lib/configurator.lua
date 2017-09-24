-- OpenComputers Lib
local cm = require("component")
local ev = require("event")

-- Components
local gpu = cm.gpu

-- Internal Variables
local buttons = {}
local max_x, max_y = gpu.maxResolution()

-- Functions
local function create_button(id, x1, y1, x2, y2, callback)
    gpu.fill(x1, y1, x2 - x1, y2 - y1, "█")
    buttons.id = id
    buttons.id.x1 = x1
    buttons.id.y1 = y1
    buttons.id.x2 = x2
    buttons.id.y2 = y2
    buttons.id.fn = callback
end

-- Set resolution to maximum
gpu.setResolution(max_x, max_y)

-- Clear the screen
gpu.fill(1, 1, max_x, max_y, " ")

-- Create test screen
create_button("one", 2, 2, 6, 6, function () print("Ayy") end)

while ev.pull(1, "interrupted") == nil do
    for k, v in pairs(buttons) do

    end
end


