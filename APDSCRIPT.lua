-- Script for "PlaceUnit" (executes every 1 second)
spawn(function()
    while true do
        local success, errorMessage = pcall(function()
            local args = {
                [1] = "PlaceUnit",
                [2] = 96,
                [3] = CFrame.new(-46.88163757324219, 9.432368278503418, -275.0870056152344) * CFrame.Angles(-0, 0, -0),
                [4] = "96#07a1ed30-cca4-4be7-90ef-ca5fcf343952"
            }

            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end)

        -- After every attempt, trigger the "Retry" event and wait 2 seconds
        local retryArgs = {
            [1] = "Retry"
        }
        game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(retryArgs))
        wait(2)  -- Wait 2 seconds before retrying the action again

        if not success then
            print("Failed to place unit. Error:", errorMessage)
        else
            print("Successfully placed unit.")
        end

        wait(1) -- Retry every second
    end
end)

-- Script for "UpgradeUnit" (executes every 1 second)
spawn(function()
    while true do
        local success, errorMessage = pcall(function()
            local args = {
                [1] = "UpgradeUnit",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end)

        -- After every attempt, trigger the "Retry" event and wait 2 seconds
        local retryArgs = {
            [1] = "Retry"
        }
        game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(retryArgs))
        wait(2)  -- Wait 2 seconds before retrying the action again

        if not success then
            print("Failed to upgrade unit. Error:", errorMessage)
        else
            print("Successfully upgraded unit.")
        end

        wait(1) -- Retry every second
    end
end)
