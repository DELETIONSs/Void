local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[[
---==============================================---)
By using this you are going against roblox's policy,
I am NOT at fault if action is taken against you.
    - re_sistance
---==============================================---)
]]
--[[ Safety Functions ]]
local function SafeGetService(name)
    local ok, service = pcall(function()
        return game:GetService(name)
    end)

    local Reference = (cloneref) or function(ref)
        return ref
    end

    return ok and Reference(service) or nil
end
-- Roblox References
local ReplicatedStorage = SafeGetService(ReplicatedStorage)
local RunService = SafeGetService("RunService")
local Players = SafeGetService("Players")
local StarterGui = SafeGetService("StarterGui")
local SoundService = SafeGetService("SoundService")

--// Game Paths
local styles = game.ReplicatedStorage.Styles
local Fighter = styles.Brawler

local FSty, RSty, BSty

local Target = FSty

local AbilityMap = {
    ["H_Distanced"] = "H_Escape",
    ["Rush1"] = "ShuckyDrop"
}


local function AddAllAbilities()
    for i, v in pairs(AbilityMap) do
        local x = brawlerstyle:FindFirstChild(i)

        if x then
            x.Value = v
        else
            local x = Instance.new("StringValue", brawlerstyle)
            x.Value = v
            x.Name = i
        end
    end
end

local function changeValueStrict(obj, valName, newVal, valClass)
    if obj and newVal and valName then
        if not obj:FindFirstChild(valName) then
            local n = Instance.new(valClass)
            n.Name = valName
            n.Parent = obj
        end
        obj[valName].Value = newVal
    end
end

AddAllAbilities()
