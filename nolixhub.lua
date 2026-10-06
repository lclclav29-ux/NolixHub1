-- [[ NOLIX HUB - Advanced Admin Panel ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

if CoreGui:FindFirstChild("NolixHubAdmin") then
    CoreGui.NolixHubAdmin:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NolixHubAdmin"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 540, 0, 360)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 80)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Шапка
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🛡️ Nolix Hub | Admin Panel"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -33, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Боковая панель категорий
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 130, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sideLayout = Instance.new("UIListLayout")
sideLayout.Parent = sidebar
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 4)

-- Контейнер под Вкладки
local pagesFolder = Instance.new("Folder")
pagesFolder.Name = "Pages"
pagesFolder.Parent = mainFrame

local activePage = nil

local function createTab(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -145, 1, -50)
    page.Position = UDim2.new(0, 140, 0, 45)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.Visible = false
    page.Parent = pagesFolder

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = page
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 8)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 32)
    tabBtn.Position = UDim2.new(0, 5, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 13
    tabBtn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabBtn

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pagesFolder:GetChildren()) do
            p.Visible = false
        end
        for _, b in pairs(sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                b.TextColor3 = Color3.fromRGB(180, 180, 200)
            end
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    if not activePage then
        activePage = page
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    return page
end

local function createButton(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.Parent = page

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- === ВКЛАДКИ И КНОПКИ ===

-- 1. Вкладка "Player"
local playerTab = createTab("👤 Player")

createButton(playerTab, "⚡ Speed Boost (50)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end)

createButton(playerTab, "🚶 Normal Speed (16)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

createButton(playerTab, "🦘 High Jump (120)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 120
    end
end)

local noclipEnabled = false
createButton(playerTab, "👻 Noclip (Сквозь стены)", function()
    noclipEnabled = not noclipEnabled
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 2. Вкладка "Visuals"
local visualsTab = createTab("👁️ Visuals")

createButton(visualsTab, "💡 Fullbright (Подсветка карты)", function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
end)

createButton(visualsTab, "🎯 ESP Players (Подсветка игроков)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and not p.Character:FindFirstChild("AdminHighlight") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "AdminHighlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = p.Character
        end
    end
end)

-- 3. Вкладка "World"
local worldTab = createTab("🌐 World")

createButton(worldTab, "☀️ Установить День", function()
    Lighting.ClockTime = 12
end)

createButton(worldTab, "🌙 Установить Ночь", function()
    Lighting.ClockTime = 0
end)

-- Логика перетаскивания
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
