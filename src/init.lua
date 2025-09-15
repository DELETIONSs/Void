--[[ 
OWNER WARNING
DO NOT USE IF YOU'RE ON YOUR MAIN 
(BAN IS NOT 100% GUARANTEED BUT THERE IS ALWAYS A RISK)
]]
local MainFolder = require(script.Parent)
local SafetyProtocols = require(MainFolder.safetyprotocol.lua)
local function SafeGetService(name)
    local ok, service = pcall(function()
        return game:GetService(name)
    end)

    local Reference = (cloneref) or function(ref) return ref end
    return ok and Reference(service) or nil
end

--// Services
local ReplicatedStorage = SafeGetService("ReplicatedStorage")
local Players = SafeGetService("Players")
local player = Players.LocalPlayer

--// Helpers
local function HexToColor3(hex)
    hex = hex:gsub("#", "")
    return Color3.fromRGB(
        tonumber("0x"..hex:sub(1,2)),
        tonumber("0x"..hex:sub(3,4)),
        tonumber("0x"..hex:sub(5,6))
    )
end

local function SafeSet(folder, propName, value)
    if folder and folder:FindFirstChild(propName) then
        folder[propName].Value = value
    end
end

--// Main Library
local VoidLibrary = {}
VoidLibrary.__index = VoidLibrary

-- Active style reference
VoidLibrary.CurrentStyle = nil

-------------------------------------------------
-- API METHODS
-------------------------------------------------

-- Select which style to edit
function VoidLibrary:SetStyle(styleName)
    local styles = ReplicatedStorage:WaitForChild("Styles")
    local style = styles:FindFirstChild(styleName)
    if not style then
        warn("[VoidLibrary] Style not found:", styleName)
        return
    end
    self.CurrentStyle = style
    print("[VoidLibrary] Active style set to:", styleName)
end

-- Apply general style config
function VoidLibrary:StyleConfig(config)
    local style = self.CurrentStyle
    if not style then return end

    if config.HeatColor then
        SafeSet(style, "Color", HexToColor3(config.HeatColor))
    end

    if config.Name then
        SafeSet(style, "VisualName", config.Name)
    end
end

-- Bulk edit rushes
function VoidLibrary:EditRushes(rushTable)
    local style = self.CurrentStyle
    if not style then return end

    for rushName, move in pairs(rushTable) do
        SafeSet(style, rushName, move)
    end
end

-- Bulk edit strikes
function VoidLibrary:EditStrikes(strikeTable)
    local style = self.CurrentStyle
    if not style then return end

    for strikeName, move in pairs(strikeTable) do
        SafeSet(style, strikeName, move)
    end
end

-------------------------------------------------
-- RETURN
-------------------------------------------------
return setmetatable({}, VoidLibrary)
