-- PHONGNAT | Steal an Egg - UI demo
-- For a Roblox Studio experience you own.
-- This file creates a draggable menu with Home, Settings, resize, border color,
-- hide/reopen, and placeholder Egg Information / Pet Collection buttons.
-- It does not automate stealing, target, or attacking other players.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicate menus if the script is run again.
local oldGui = playerGui:FindFirstChild("PHONGNAT")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "PHONGNAT"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.fromOffset(280, 270)
main.Position = UDim2.new(0.5, -140, 0.5, -135)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 195, 60)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -48, 0, 42)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "PHONGNAT"
title.TextColor3 = stroke.Color
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.new(1, -20, 0, 24)
status.Position = UDim2.new(0, 10, 1, -28)
status.BackgroundTransparency = 1
status.Text = "Status: Ready"
status.TextColor3 = Color3.fromRGB(150, 220, 160)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = main

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -38, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(190, 55, 65)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 15
close.Parent = main
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

local reopen = Instance.new("TextButton")
reopen.Name = "OpenPHONGNAT"
reopen.Size = UDim2.fromOffset(130, 36)
reopen.Position = UDim2.new(0, 12, 0.5, 0)
reopen.BackgroundColor3 = Color3.fromRGB(255, 195, 60)
reopen.Text = "OPEN PHONGNAT"
reopen.TextColor3 = Color3.fromRGB(25, 25, 25)
reopen.Font = Enum.Font.GothamBold
reopen.TextSize = 12
reopen.Visible = false
reopen.Parent = gui
Instance.new("UICorner", reopen).CornerRadius = UDim.new(0, 8)

local content = Instance.new("Frame")
content.Name = "Buttons"
content.Position = UDim2.fromOffset(0, 44)
content.Size = UDim2.new(1, 0, 1, -76)
content.BackgroundTransparency = 1
content.Parent = main

local function clearButtons()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
end

local function makeButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 34)
    button.Position = UDim2.fromOffset(10, y)
    button.BackgroundColor3 = Color3.fromRGB(48, 52, 70)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 13
    button.AutoButtonColor = true
    button.Parent = content
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.MouseButton1Click:Connect(callback)
    return button
end

local showHome
local showSettings

showHome = function()
    clearButtons()

    makeButton("Egg Information", 4, function()
        status.Text = "Status: Egg Information (demo)"
    end)

    makeButton("Pet Collection", 44, function()
        status.Text = "Status: Pet Collection (demo)"
    end)

    makeButton("Settings", 84, function()
        showSettings()
    end)
end

showSettings = function()
    clearButtons()

    makeButton("Resize: Small / Large", 4, function()
        if main.Size.X.Offset == 280 then
            main.Size = UDim2.fromOffset(340, 300)
            status.Text = "Status: Large menu"
        else
            main.Size = UDim2.fromOffset(280, 270)
            status.Text = "Status: Small menu"
        end
    end)

    makeButton("Change Border Color", 44, function()
        if stroke.Color == Color3.fromRGB(255, 195, 60) then
            stroke.Color = Color3.fromRGB(70, 220, 140)
        else
            stroke.Color = Color3.fromRGB(255, 195, 60)
        end
        title.TextColor3 = stroke.Color
        status.Text = "Status: Border color changed"
    end)

    makeButton("Hide Menu", 84, function()
        main.Visible = false
        reopen.Visible = true
    end)

    makeButton("Back", 124, function()
        showHome()
        status.Text = "Status: Home"
    end)
end

close.MouseButton1Click:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
    main.Visible = true
    reopen.Visible = false
end)

showHome()
print("PHONGNAT menu loaded.")
