@REM automate the process of running file in C:\Users\adamszeq\Desktop\Clones\Campaigns\Days Queries 
@REM and save the output in C:\Users\adamszeq\Desktop\Clones\Campaigns

@echo off
setlocal enabledelayedexpansion
set "path=C:\Users\adamszeq\Desktop\Clones\Campaigns\Days Queries\Day3 Discount Group.sql"
@REM set "output=C:\Users\adamszeq\Desktop\Clones\Campaigns"
@REM set "output=!output!\Day3 Discount Group.txt"

@REM @REM save the output in the same folder as the sql file
@REM set "output=!path!"
@REM @REM save the output in the same folder as the sql file and change the extension to .xlsx
@REM set "output=!output:.sql=.xlsx!"

@REM sqlcmd -S localhost -d master -i "!path!" -o "!output!" -W -s"|" -h-1 -k1 -b

@REM @echo on
@REM echo Done

@REM create a new file with the same name as the sql file and change the extension to .xlsx
@REM copy /b "!path!" "!output!"

@REM @REM save the output in the same folder as the sql file and change the extension to .xlsx
@REM @REM copy /b "!path!" "!output:.sql=.xlsx!"

@REM @REM save the output in the same folder as the sql file and change the extension to .xlsx
@REM @REM copy /b "!path!" "!output:.sql=.xlsx!"

@REM @REM save the output in the same folder as the sql file and change the extension to .xlsx
pause



