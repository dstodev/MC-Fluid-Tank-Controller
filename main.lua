-- OpenComputers Lib
local sh = require("shell")
local fs = require("filesystem")

-- Make library folder
local PATH_LIB = sh.resolve("lib") .. "/"
fs.makeDirectory(PATH_LIB)

-- Config
local URL = "https://raw.githubusercontent.com/dstodev/MC-Fluid-Tank-Controller/master/lib/"

local function getlib(file)
    local status, error = sh.execute("wget -f " .. URL .. file .. " " .. PATH_LIB .. file)
    if status == false then
        error("Could not retrieve " .. file .. "!")
    end
end

-- Get external libraries
getlib("schmitt_trigger.lua")
getlib("tank_control.lua")
getlib("configurator.lua")

-- Start the program
local status, config = sh.execute("lib/configurator.lua")
local status, error = sh.execute("lib/tank_control.lua")
