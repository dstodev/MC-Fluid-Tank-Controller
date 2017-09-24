-- OpenComputers Lib
local sh = require("shell")
local fs = require("filesystem")

-- Make library folder
path_lib = sh.resolve("lib") .. "/"
fs.makeDirectory(path_lib)

-- Get external libraries
-- Schmitt trigger
status, error = sh.execute("pastebin get -f 2nvWB7nz " .. path_lib .. "trigger.lua")
if status == false then
  error("Could not retrieve trigger: " .. error)
end

-- (Main) tank controller
status, error = sh.execute("pastebin get -f BPNMffHM " .. path_lib .. "tank_control.lua")
if status == false then
  error("Could not retrieve tank_control: " .. error)
end

status, error = sh.execute("lib/tank_control.lua")
