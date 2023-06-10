@echo off
cd game
copy /y "gameinfo_original.gi" "csgo/gameinfo.gi"
cd ../
cls
echo Starting Counter-Strike: 2...
start "" "game\bin\win64\cs2.exe" -language english -condebug -novid -console -tools
timeout /t 5 /nobreak
exit