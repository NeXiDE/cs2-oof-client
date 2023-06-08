local playerLimit = 0

function playerJoined(event)
    playerLimit = playerLimit + 1
    --for k,v in pairs(event) do
        --print( k,v )
    --end
    if playerLimit > 14 then
        --print("Too many players to join server. Kicking joining player...")
        SendToServerConsole("kickid " .. event.userid .. " Server is full!")
    elseif playerLimit == 14 then
        --print("Player joined, Player Count: " .. playerLimit)
    elseif playerLimit < 14 then
        --print("Player joined, Player Count: " .. playerLimit)
    else
        print("Player number is higher then max player. DEBUG THIS!")
    end
end

function playerLeft(event)
    playerLimit = playerLimit - 1
    --print("Player left, Player Count: " .. playerLimit)
end

function newMapFix(event)
    if(ScriptGetRoundsPlayed() == 0) then
        if(ScriptIsWarmupPeriod() == false) then
            print("Player spawned in first round, Player Count: " .. playerLimit)
            playerLimit = playerlimit + 1
        elseif (ScriptIsWarmupPeriod() == true) then
            print("New map started. Not counting players yet")
            playerLimit = 0
        end
    else
        print("We are on round: " .. ScriptGetRoundsPlayed())
    end
end

function Activate()
    ListenToGameEvent("player_connect", playerJoined, nil)
    ListenToGameEvent("player_disconnect", playerLeft, nil)
    ListenToGameEvent("player_spawn", newMapFix, nil)
end

Activate()