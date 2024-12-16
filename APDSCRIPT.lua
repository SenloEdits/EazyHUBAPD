local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Create the Window for Fluent GUI
local Window = Fluent:CreateWindow({
    Title = "Eazy Hub " .. Fluent.Version,
    SubTitle = "by thors",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when there's no MinimizeKeybind
})

-- Fluent Tab Creation
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Initialize the farmingEnabled state
local farmingEnabled = false
local autoReplayEnabled = false
local autoSellEnabled = false

-- Define the farming toggle
local farmingToggle = Tabs.Main:AddToggle("MyToggle", {
    Title = "Enable farm",
    Default = farmingEnabled -- Set the default state from saved state
})

-- Listen for toggle state changes
farmingToggle:OnChanged(function(value)
    farmingEnabled = value -- Update toggle state
    print("Farming Toggle changed:", farmingEnabled)
end)

-- Script for "PlaceUnit"
spawn(function()
    while true do
        wait(2) -- Loop every 2 seconds
        if farmingEnabled then
            local args = {
                [1] = "PlaceUnit",
                [2] = 96,
                [3] = CFrame.new(-46.88163757324219, 9.432368278503418, -275.0870056152344) * CFrame.Angles(-0, 0, -0),
                [4] = "96#07a1ed30-cca4-4be7-90ef-ca5fcf343952"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end
    end
end)

-- Script for "UpgradeUnit"
spawn(function()
    while true do
        wait(1) -- Loop every 1 second
        if farmingEnabled then
            local args = {
                [1] = "UpgradeUnit",
                [2] = 1
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end
    end
end)

-- Auto Replay Toggle
local autoReplayToggle = Tabs.Main:AddToggle("MyToggle", { Title = "Auto Replay", Default = autoReplayEnabled })

autoReplayToggle:OnChanged(function(value)
    autoReplayEnabled = value
    print("Auto Replay Toggle changed:", autoReplayEnabled)

    if autoReplayEnabled then
        while autoReplayEnabled do
            local args = { [1] = "Retry" }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
            wait(2)
        end
    end
end)

-- Auto Sell Toggle
local autoSellToggle = Tabs.Main:AddToggle("MyToggle", { Title = "Auto Sell after 10 minutes", Default = autoSellEnabled })

local function autoSell()
    while autoSellEnabled do
        local args = {
            [1] = "SellUnit",
            [2] = 1
        }

        game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))

        -- Wait for 10 minutes (600 seconds)
        wait(600)
    end
end

-- Listen for Auto Sell toggle state changes
autoSellToggle:OnChanged(function(value)
    autoSellEnabled = value
    print("Auto Sell toggled:", autoSellEnabled)

    if autoSellEnabled then
        task.spawn(autoSell) -- Start auto-sell functionality
    end
end)
