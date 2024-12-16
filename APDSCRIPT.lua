-- Script for "PlaceUnit" (executes every 1 second)
spawn(function()
    while true do
        wait(1) -- Wait 1 second for "PlaceUnit"
        
        local success, errorMessage = pcall(function()
            local args = {
                [1] = "PlaceUnit",
                [2] = 96,
                [3] = CFrame.new(-46.88163757324219, 9.432368278503418, -275.0870056152344) * CFrame.Angles(-0, 0, -0),
                [4] = "96#07a1ed30-cca4-4be7-90ef-ca5fcf343952"
            }

            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end)
        
        if not success then
            print("Failed to place unit. Retrying... Error:", errorMessage)
            
            -- Trigger the retry event
            local retryArgs = {
                [1] = "Retry"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(retryArgs))
            wait(2)  -- Wait 2 seconds before retrying
        end
    end
end)

-- Script for "UpgradeUnit" (executes every 1 second)
spawn(function()
    while true do
        wait(1) -- Wait 1 second for "UpgradeUnit"
        
        local success, errorMessage = pcall(function()
            local args = {
                [1] = "UpgradeUnit",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(args))
        end)
        
        if not success then
            print("Failed to upgrade unit. Retrying... Error:", errorMessage)
            
            -- Trigger the retry event
            local retryArgs = {
                [1] = "Retry"
            }
            game:GetService("ReplicatedStorage").Events.Game:FireServer(unpack(retryArgs))
            wait(2)  -- Wait 2 seconds before retrying
        end
    end
end)
