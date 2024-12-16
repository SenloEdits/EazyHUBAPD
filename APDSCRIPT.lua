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

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Define the toggle
local farmingEnabled = false -- Initialize toggle state

local Toggle = Tabs.Main:AddToggle("MyToggle", {
    Title = "Enable farm",
    Default = false
})

-- Listen for toggle state changes
Toggle:OnChanged(function(value)
    farmingEnabled = value -- Update toggle state
    print("Toggle changed:", farmingEnabled)
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

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Auto Replay", Default = false })

Toggle:OnChanged(function()
    if Toggle.Value then
        while Toggle.Value do
            local args = {
                [1] = "Retry"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
            wait(2)
        end
    end
end)