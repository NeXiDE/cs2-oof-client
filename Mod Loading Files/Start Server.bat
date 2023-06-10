@echo off
cd game
copy /y "gameinfo_modded.gi" "csgo/gameinfo.gi"
cd ../
cls
echo Starting Counter-Strike: 2 Server...
start "" "game\bin\win64\cs2.exe" -dedicated -console -condebug +mapgroup mg_cs2 +map de_dust2
timeout /t 5 /nobreak
exit