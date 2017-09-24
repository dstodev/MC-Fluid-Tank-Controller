-- OpenComputers Lib
local sh = require("shell")
local fs = require("filesystem")

-- Make library folder
local path_lib = sh.resolve("lib") .. "/"
fs.makeDirectory(path_lib)

-- Config
local URL = "https://raw.githubusercontent.com/dstodev/MC-Fluid-Tank-Controller/master/lib/"

function getlib(file)
  local status, error = sh.execute("wget " .. URL .. file .. " " .. path_lib .. " " .. file)
  if status == false then
    error("Could not retrieve " .. file)
  end
end

-- Get external libraries
-- Schmitt trigger
getlib("schmitt_trigger.lua")
-- Tank controller
getlib("tank_control.lua")
-- Screen configurator
getlib("configurator.lua")

local status, error = sh.execute("lib/tank_control.lua")
