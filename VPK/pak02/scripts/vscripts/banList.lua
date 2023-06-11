local bannedPlayers = {
    "[U:1:372278500]", -- Example how to add a banned player
}

local banlistCount = 0

function PrintBanList()
    banlistCount = 0
    for _, id in ipairs(bannedPlayers) do
        banlistCount = banlistCount + 1
    end
    if banlistCount == 1 then
        print("Found " .. banlistCount .. " banned player in script.")
    else
        print("Found " .. banlistCount .. " banned players in script.")
    end
end

function CheckBanList(event)
    if GetMapName() == "<empty>" then
        print("We are in the menu, don't do anything!")
    else
        for _, id in ipairs(bannedPlayers) do
            if(id == event.networkid) then
                SendToServerConsole("kickid " .. event.userid .. " You have been banned from this server!")
            else
                -- Do nothing. Player is not on ban list
            end
        end
    end
end

function ReloadBanList()
    SendToServerConsole("sv_cheats 1")
    SendToServerConsole("script_reload_code banList.lua")
    SendToServerConsole("sv_cheats 0")
    print("Reloaded Ban List!")
end

function Activate()
    ListenToGameEvent("player_connect", CheckBanList, nil)
    Convars:RegisterCommand("ReloadBanList", ReloadBanList, "Writes all cvars into a the statusConvar.cfg", 0x1000)
end

Activate()
PrintBanList()