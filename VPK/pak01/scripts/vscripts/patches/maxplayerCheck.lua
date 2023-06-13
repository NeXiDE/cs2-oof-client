local playerCount = 0
local players = Entities:FindAllByClassname("player")
local playerLimit = 12

function PlayerJoined(event)
    --[[for k,v in pairs(event) do
        print( k,v )
    end]]--
    playerCount = playerCount + 1
    if playerCount > playerLimit then
        print("Too many players to join server. Kicking joining player...")
        SendToServerConsole("kickid " .. event.userid .. " Server is full!")
    elseif playerCount == playerLimit then
        print("Player joined, Player Count: " .. playerCount)
    elseif playerCount < playerLimit then
        print("Player joined, Player Count: " .. playerCount)
    elseif playerCount == -1 then
        print("WARNING: Player Counter broke somehow. Trying to fail safe but server restart is recommended!")
        for _  in pairs(players) do playerCount = playerCount + 1 end
        print("Fail Safe reports '" .. playerCount .. "' are on the server")
    else
        print("Player number is higher then max player. DEBUG THIS!")
    end
end

function PlayerLeft(event)
    if event.networkid == "BOT" then
        --print("Player was a bot, don't counter player couter...")
    else
        --print("Player was not a bot, counting down...")
        playerCount = playerCount - 1
        print("Player left, Player Count: " .. playerCount)
    end
end

--[[function RoundStart(event)
    for _  in pairs(players) do playerCount = playerCount + 1 end
    print("New Round. Checking Player Count: " .. playerCount)
end]]--

function DEBUG_PlayerCheck(event)
    print("DEBUG: Current Player Count: " .. playerCount)
end

function Activate()
    ListenToGameEvent("player_connect_full", PlayerJoined, nil)
    ListenToGameEvent("player_disconnect", PlayerLeft, nil)
    --ListenToGameEvent("round_start", RoundStart, nil)
    Convars:RegisterCommand("DEBUG_PrintPlayerCount", DEBUG_PlayerCheck, "Writes all cvars into a the statusConvar.cfg", 0x1000)
end

Activate()