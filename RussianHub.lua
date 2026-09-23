-- Russian Hub UI
-- Самостоятельное русское меню для Roblox.
-- Это интерфейс-шаблон: кнопки не выполняют читерские/эксплойт-функции.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RussianHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(620, 390)
main.Position = UDim2.new(0.5, -310, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "РУССКИЙ HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = main

local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(0, 145, 1, -55)
tabs.Position = UDim2.fromOffset(10, 50)
tabs.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
tabs.BorderSizePixel = 0
tabs.Parent = main

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabs

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -170, 1, -60)
content.Position = UDim2.fromOffset(160, 55)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 10)
    end)

    pages[name] = page
    return page
end

local function addButton(page, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 42)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    button.TextColor3 = Color3.fromRGB(235, 235, 235)
    button.Text = text
    button.TextSize = 16
    button.Font = Enum.Font.Gotham
    button.AutoButtonColor = true
    button.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then
            callback(button)
        end
    end)

    return button
end

local function addToggle(page, text)
    local enabled = false

    local button = addButton(page, text .. ": ВЫКЛ", function(b)
        enabled = not enabled
        b.Text = text .. ": " .. (enabled and "ВКЛ" or "ВЫКЛ")
    end)

    return button
end

local function addTab(name, page)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -12, 0, 38)
    button.Position = UDim2.fromOffset(6, 0)
    button.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    button.TextColor3 = Color3.fromRGB(235, 235, 235)
    button.Text = name
    button.TextSize = 15
    button.Font = Enum.Font.GothamMedium
    button.Parent = tabs

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = button

    button.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do
            p.Visible = false
        end
        page.Visible = true
    end)
end

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 6)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Top
tabLayout.Parent = tabs

-- Страницы
local farm = createPage("Фарм")
addToggle(farm, "Авто-фарм")
addToggle(farm, "Автосбор")
addToggle(farm, "Автоматическое действие")
addButton(farm, "Запустить", function()
    print("Запуск выбранной функции")
end)
addButton(farm, "Остановить", function()
    print("Остановка выбранной функции")
end)

local playerPage = createPage("Игрок")
addToggle(playerPage, "Быстрая скорость")
addToggle(playerPage, "Высокий прыжок")
addToggle(playerPage, "Бессмертие (шаблон)")
addButton(playerPage, "Обновить персонажа", function()
    if player.Character then
        player.Character:BreakJoints()
    end
end)

local predictor = createPage("Предиктор")
addToggle(predictor, "Предсказание движения")
addToggle(predictor, "Предсказание позиции")
addButton(predictor, "Сбросить настройки", function()
    print("Настройки предиктора сброшены")
end)

local progress = createPage("Прогресс")
addToggle(progress, "Автоматическое сохранение")
addButton(progress, "Показать прогресс", function()
    print("Прогресс открыт")
end)
addButton(progress, "Сбросить прогресс", function()
    print("Прогресс сброшен")
end)

local server = createPage("Сервер")
addButton(server, "Переподключиться", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)
addButton(server, "Обновить список серверов", function()
    print("Список серверов обновлён")
end)

local misc = createPage("Разное")
addToggle(misc, "Уведомления")
addToggle(misc, "Автоматический запуск")
addButton(misc, "Закрыть меню", function()
    gui:Destroy()
end)

addTab("Фарм", farm)
addTab("Игрок", playerPage)
addTab("Предиктор", predictor)
addTab("Прогресс", progress)
addTab("Сервер", server)
addTab("Разное", misc)

farm.Visible = true

-- Перемещение окна мышью/тачем
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
