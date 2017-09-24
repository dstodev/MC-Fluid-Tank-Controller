-- OpenComputers Lib
local cm = require("component")
local os = require("os")
local ev = require("event")
local si = require("sides")

-- My Lib
local Trigger = require("lib/schmitt_trigger")

-- Components
local tank = cm.tank_controller
local rs = cm.redstone

-- Configuration
local side_tank = si.east
local side_rs_out = si.south

-- Internal Variables
local fluid_name = tank.getFluidInTank(side_tank)[1]
if fluid_name == nil or fluid_name["name"] == nil then
    fluid_name = "nothing"
else
    fluid_name = fluid_name["name"]
end

-- Callbacks
function left()
    -- print("Left!")
    rs.setOutput(side_rs_out, 15)
end

function right()
    -- print("Right!")
    rs.setOutput(side_rs_out, 0)
end

-- Operation
t = Trigger(40, 60, left, right)

print(tank.getTankLevel(side_tank) / 1000 .. "/" .. tank.getTankCapacity(side_tank) / 1000, "buckets of " .. fluid_name .. " found in tank!")

while ev.pull(1, "interrupted") == nil do
    t:update(tank.getTankLevel(side_tank) / 1000)
end
