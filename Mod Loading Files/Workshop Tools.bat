@echo off
cd game
copy /y "gameinfo_original.gi" "csgo/gameinfo.gi"
cd ../
cls
echo Starting CS:2 Workshop Tools...
start "" "game\bin\win64\csgocfg.exe"
timeout /t 5 /nobreak
exit