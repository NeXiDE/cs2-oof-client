require "libs.functions"
require "libs.timers"

local admins = {
    "[U:1:372278503]", -- NeXi2k
    "[U:1:53526696]",  -- Gh0st
    "[U:1:14399780]",  -- BaT420
}

local duration = 0.1
local adminTable = {}
local filePrecached = 0


function SaveAdminID(event)
    for _, id in ipairs(admins) do
        if(id == event.networkid) then
            table.insert(adminTable, event.userid)
        end
    end
end

function OnRoundStart(event)
    Clientcmd = Entities:FindByClassname(nil, "point_clientcommand")

    if Clientcmd == nil then
        Clientcmd = SpawnEntityFromTableSynchronous("point_clientcommand", { targetname = "vscript_clientcommand" })
    end
end

function PrintAdminTable(event)
    print("Current Admin Table:")
    DeepPrintTable(adminTable)
end

function PlayerModelTest(event)
    if filePrecached == 1 then
        SendToServerConsole("sv_cheats 1")
        SendToServerConsole("script_reload_code server_stuff/precacheModelScript.lua")
        SendToServerConsole("sv_cheats 0")
    end
    SetModel_ActiveTimer = Timers:CreateTimer({
		endTime = duration,
		callback = function()
			SetAdminModel(event)
			return duration
		end
	})
end

function SetAdminModel(event)
    for _, id in ipairs(adminTable) do
        if(id == event.userid) then
            local hPlayer = EHandleToHScript(event.userid_pawn)
            if (hPlayer:GetTeam() == 2) then
                print("Found Admin. Changing his player model")
                hPlayer:SetModel("characters/models/tm_leet/tm_leet_variantk.vmdl")
                DoEntFireByInstanceHandle(Clientcmd, "command", "slot5", 0.11, hPlayer, hPlayer)
            elseif (hPlayer:GetTeam() == 3) then
                print("Found Admin. Changing his player model")
                hPlayer:SetModel("characters/models/ctm_fbi/ctm_fbi_varianta.vmdl")
                DoEntFireByInstanceHandle(Clientcmd, "command", "slot3", 0.11, hPlayer, hPlayer)
            end
        else
            -- Do nothing
        end
    end
    Timers:RemoveTimers()
end

ListenToGameEvent("player_spawn", PlayerModelTest, nil)
ListenToGameEvent("round_start", OnRoundStart, nil)
ListenToGameEvent("player_connect", SaveAdminID, nil)
Convars:RegisterCommand("PrintAdminTable", PrintAdminTable, "Command from adminPlayerModel.lua: Prints the Admin Table - DEBUG COMMAND", 0x1000)