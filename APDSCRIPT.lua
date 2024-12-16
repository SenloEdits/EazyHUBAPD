local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Eazy Hub " .. Fluent.Version,
    SubTitle = "by thors",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local savedState = SaveManager:Load("EazyHubState", { farmingEnabled = false, autoReplayEnabled = false, autoSellEnabled = false })

local farmingEnabled = savedState.farmingEnabled
local autoReplayEnabled = savedState.autoReplayEnabled
local autoSellEnabled = savedState.autoSellEnabled

local farmingToggle = Tabs.Main:AddToggle("FarmingToggle", {
    Title = "Enable farm",
    Default = farmingEnabled
})

farmingToggle:OnChanged(function(value)
    farmingEnabled = value
    SaveManager:Save("EazyHubState", { farmingEnabled = farmingEnabled, autoReplayEnabled = autoReplayEnabled, autoSellEnabled = autoSellEnabled })
    print("Farming Toggle changed:", farmingEnabled)
end)

spawn(function()
    while true do
        wait(2)
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

spawn(function()
    while true do
        wait(1)
        if farmingEnabled then
            local args = {
                [1] = "UpgradeUnit",
                [2] = 1
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end
    end
end)

local autoReplayToggle = Tabs.Main:AddToggle("AutoReplayToggle", { Title = "Auto Replay", Default = autoReplayEnabled })

autoReplayToggle:OnChanged(function(value)
    autoReplayEnabled = value
    SaveManager:Save("EazyHubState", { farmingEnabled = farmingEnabled, autoReplayEnabled = autoReplayEnabled, autoSellEnabled = autoSellEnabled })

    if autoReplayEnabled then
        while autoReplayEnabled do
            local args = { [1] = "Retry" }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
            wait(2)
        end
    end
end)

local autoSellToggle = Tabs.Main:AddToggle("AutoSellToggle", { Title = "Auto Sell after 10 minutes", Default = autoSellEnabled })

local function autoSell()
    while autoSellEnabled do
        local args = {
            [1] = "SellUnit",
            [2] = 1
        }
        game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        wait(600)
    end
end

autoSellToggle:OnChanged(function(value)
    autoSellEnabled = value
    SaveManager:Save("EazyHubState", { farmingEnabled = farmingEnabled, autoReplayEnabled = autoReplayEnabled, autoSellEnabled = autoSellEnabled })
    if autoSellEnabled then
        autoSell()
    end
end)
