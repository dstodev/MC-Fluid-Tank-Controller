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
local function create_button(id, callback, x1, y1, x2, y2, bg_color, fg_color, label)
    -- Save color settings
    local bg = gpu.getBackground()
    local fg = gpu.getForeground()

    -- Set default parameters
    bg_color = bg_color or 0xFFFFFF
    fg_color = fg_color or 0x000000

    -- Draw button
    gpu.setBackground(bg_color)
    gpu.fill(x1, y1, x2 - x1 + 1, y2 - y1 + 1, " ")

    -- Draw label
    if label then
        gpu.setForeground(fg_color)
        gpu.set(x1 + (x2 - x1) / 2 - #label / 2, y1 + (y2 - y1) / 2, label)
    end

    -- Restore color settings
    gpu.setBackground(bg)
    gpu.setForeground(fg)

    -- Record information for button handler
    buttons[id] = {}
    buttons[id].x1 = x1
    buttons[id].y1 = y1
    buttons[id].x2 = x2
    buttons[id].y2 = y2
    buttons[id].fn = callback
end

local function button_handler(_, address, x, y, button, player)
    for k, v in pairs(buttons) do
        if button == 0 and x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
            v.fn()
        end
    end
end

-- Set resolution to maximum
gpu.setResolution(max_x, max_y)

-- Set to maximum color depth
gpu.setDepth(gpu.maxDepth())

-- Clear the screen
gpu.fill(1, 1, max_x, max_y, " ")

-- Create test screen
create_button("one", function () gpu.set(8, 4, "Ayy") end, 3, 2, max_x - 2, max_y / 4 - 2, 0x4020FF, 0xFFFFFF, "Begin!")

-- Install button handler
ev = EventLoop()
ev:register("interrupted", function (loop) loop:stop() end)
ev:register("touch", button_handler)

-- Run event loop
ev:run()
