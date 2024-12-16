local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Eazy Hub " .. Fluent.Version,
    SubTitle = "by thors",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Fluent Tab Creation
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Merged Toggle for Auto Farm and Auto Replay
local farmingAndReplayEnabled = true  -- Always enabled
local toggle = Tabs.Main:AddToggle("EnableFarmAndReplayToggle", {
    Title = "Enable Auto Farm & Auto Replay",
    Default = farmingAndReplayEnabled
})

-- Set the toggle to always be on (enabled)
toggle:Set(true)

-- Combined script for Auto Farm and Auto Replay
spawn(function()
    while true do
        wait(2) -- Loop every 2 seconds
        if farmingAndReplayEnabled then
            -- Auto Farm: PlaceUnit
            local farmArgs = {
                [1] = "PlaceUnit",
                [2] = 96,
                [3] = CFrame.new(-46.88163757324219, 9.432368278503418, -275.0870056152344) * CFrame.Angles(-0, 0, -0),
                [4] = "96#07a1ed30-cca4-4be7-90ef-ca5fcf343952"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(farmArgs))
            
            -- Auto Upgrade: UpgradeUnit
            local upgradeArgs = {
                [1] = "UpgradeUnit",
                [2] = 1
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(upgradeArgs))

            -- Auto Replay: Retry
            local replayArgs = {
                [1] = "Retry"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(replayArgs))
        end
    end
end)
