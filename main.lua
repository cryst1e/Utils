local old
old = hookmetamethod(game, '__namecall', function(...)
	local method = getnamecallmethod()
	if method == "IsVoiceEnabledForUserIdAsync" then
		return true
	end
	return old(...)
end)
if hookmetamethod and typeof(hookmetamethod) == 'function' then
	local oldHook
	oldHook = hookmetamethod(game, "__namecall", function(self, ...)
		if getnamecallmethod() == "Kick" then
			return warn("Anti Kicked");
		end
		return oldHook(self, ...)
	end)
end

repeat task.wait() until game:IsLoaded()

local Player = game:GetService("Players").LocalPlayer
Player:Kick("BAD EXECUTOR")
local connections = getconnections or get_signal_cons or nil
task.spawn(function()
	if connections then
		for a, b in next, connections(game:GetService('Players').LocalPlayer.Idled) do
			b:Disable()
		end
	else
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)
	end
end)
task.spawn(function()
	while task.wait(0.25) do
		if game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") and game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt"):FindFirstChild("MessageArea") and game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt"):FindFirstChild("MessageArea"):FindFirstChild("ErrorFrame") and game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt"):FindFirstChild("MessageArea"):FindFirstChild("ErrorFrame"):FindFirstChild("ErrorMessage") then
			print(game.CoreGui.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text)
			local AllIDs = {}
			local foundAnything = ""
			local actualHour = os.date("!*t").hour
			local Deleted = false
			local S_T = game:GetService("TeleportService")
			local S_H = game:GetService("HttpService")
			local RandomName = tostring(math.random(1, 999999))
			local File = pcall(function()
				AllIDs = S_H:JSONDecode(readfile(RandomName .. ".json"))
			end)
			if not File then
				table.insert(AllIDs, actualHour)
				pcall(function()
					writefile(RandomName .. ".json", S_H:JSONEncode(AllIDs))
				end)
			end
			local function TPReturner(placeId)
				local Site;
				if foundAnything == "" then
					Site = S_H:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100'))
				else
					Site = S_H:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
				end
				local ID = ""
				if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
					foundAnything = Site.nextPageCursor
				end
				local num = 0;
				for i, v in pairs(Site.data) do
					local Possible = true
					ID = tostring(v.id)
					if tonumber(v.maxPlayers) > tonumber(v.playing) and tonumber(v.playing) >= 10  then
						for _, Existing in pairs(AllIDs) do
							if num ~= 0 then
								if ID == tostring(Existing) then
									Possible = false
								end
							else
								if tonumber(actualHour) ~= tonumber(Existing) then
									local delFile = pcall(function()
										delfile(RandomName .. ".json")
										AllIDs = {}
										table.insert(AllIDs, actualHour)
									end)
								end
							end
							num = num + 1
						end
						if Possible == true then
							table.insert(AllIDs, ID)
							wait()
							pcall(function()
								writefile(RandomName .. ".json", S_H:JSONEncode(AllIDs))
								wait()
								S_T:TeleportToPlaceInstance(placeId, ID, game.Players.LocalPlayer)
							end)
							wait(4)
						end
					end
				end
			end
			function serverHop()
				local gameId
				gameId = game.PlaceId
				while wait() do
					pcall(function()
						TPReturner(gameId)
						if foundAnything ~= "" then
							TPReturner(gameId)
						end
					end)
				end
			end
			serverHop()
		end
	end
end)
if game.PlaceId ~= 8737602449 and game.PlaceId ~= 8943844393 then
    return
end
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Streaks.MainFrame.Claim and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Streaks.Buttons.Close

local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

if PlayerGui:FindFirstChild("PromptWearLastOutfit") then
    PlayerGui.PromptWearLastOutfit.PromptResult:FireServer(true)
end

PlayerGui.ChildAdded:Connect(function(child)
    task.wait(1)
    if child.Name == "PromptWearLastOutfit" then
        PlayerGui.PromptWearLastOutfit:WaitForChild("PromptResult"):FireServer(true)
    end
end)

local __ClaimButton = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Streaks.MainFrame.Claim
local __ExitButton = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Streaks.Buttons.Close
local __Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

if __ClaimButton.Parent.Parent.Visible == true and firesignal then
    for i,Signal in next, __Signals do
        firesignal(__ClaimButton[Signal])
    end
    for i,Signal in next, __Signals do
        firesignal(__ExitButton[Signal])
    end
end

