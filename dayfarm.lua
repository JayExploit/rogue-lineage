if not game:IsLoaded() then
    game.Loaded:Wait()
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local myPlayer = Players.LocalPlayer
local detectionDistance = 500 -- set the detection distance to 10 studs
local hopping = false
local Started = false
local RogueGroup = 4556484

local function blockplayer()
    game:GetService("StarterGui"):SetCore("PromptBlockPlayer", game.Players:GetChildren()[2])
    wait(0.5)
    game.VirtualInputManager:SendMouseButtonEvent(600, 500, 0, true, game, 0)
    task.wait()
    game.VirtualInputManager:SendMouseButtonEvent(600, 500, 0, false, services, 0)
end

RunService.Heartbeat:Connect(function()
    if not myPlayer.Character and not hasPrinted then
        local start_menu = myPlayer.PlayerGui:WaitForChild("StartMenu", 5)
        firesignal(start_menu:WaitForChild("Choices"):WaitForChild("Play").MouseButton1Click)
        rconsoleprint("starting day farm...")
        hasPrinted = true
        return
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= myPlayer and (player.Character and myPlayer.Character) then
            local distance = (player.Character.Head.Position - myPlayer.Character.Head.Position).magnitude
            if distance <= detectionDistance and not hopping then
                hopping = true
                blockplayer()
                rconsoleprint(player.Name .. " got too close! Server hopping... ")
                myPlayer:Kick("Player Nearby")
                game.TeleportService:Teleport(3016661674)
                break
            end
        end
    end
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player:IsInGroup(RogueGroup) and not hopping then
            hopping = true
            blockplayer()
            rconsoleprint(player.Name .. " Is a moderator! Server hopping... ")
            myPlayer:Kick("Player Nearby")
            game.TeleportService:Teleport(3016661674)
        end
    end
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("Backpack") and character.Backpack:FindFirstChild("Perflora") then
                hopping = true
                blockplayer()
                rconsoleprint(player.Name .. " Is a druid! Server hopping... ")
                myPlayer:Kick("Player Nearby")
                game.TeleportService:Teleport(3016661674)
            end
        end
    end
    
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport("pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/JayExploit/rogue-lineage/main/dayfarm.lua'))() end)")
        end
    end)
end)
