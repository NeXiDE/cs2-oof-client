@echo off
goto reload
:reload
echo Starting Counter-Strike: 2 Server...
start /wait game\bin\win64\cs2.exe -dedicated -console -condebug +mapgroup mg_cs2 +map de_mirage +serverconfigfile serverconfig.cfg
echo Server Has Crashed %time% %date% >> log.txt
timeout 3
goto reload