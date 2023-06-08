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

function Activate()
    ListenToGameEvent("player_connect", playerJoined, nil)
    ListenToGameEvent("player_disconnect", playerLeft, nil)
end

Activate()