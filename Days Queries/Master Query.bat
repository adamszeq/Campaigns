@ECHO ON
set local enabledelayedexpansion


SET SERVER="azsqlmiprod02.3d2e7db08140.database.windows.net"

@REM SET DB="BI"
SET DB="BI"


@REM SET LOGIN="Spotfire_user"

@REM SET PASSWORD="$p0tfIr3"

SET LOGIN="Operational_Analytics"

SET PASSWORD="February2020!"

sqlcmd -S %SERVER% -d %DB% -U %LOGIN% -P %PASSWORD% -i "C:\\Users\\adamszeq\\Desktop\\Clones\\Campaigns\\SMSCampaign_12_12_22.sql"
@REM sqlcmd -S %SERVER% -U %LOGIN% -P %PASSWORD% -i "\\aafs01.theaa.ie\dataprice\Pricing And Analytics\Home\Git\Home\SMSCampaign_12_12_22.sql"



for %%f in (*.sql) do (

set "dte=%date:/=-%"



    @REM sqlcmd -S %SERVER% -U %LOGIN% -P %PASSWORD% -i %%~f -o "H:\SMS\Automated\%%~nf!dte!.csv" -h -1 -s "," -W 
@REM sqlcmd -S %SERVER% -U %LOGIN% -P %PASSWORD% -i %%~f -o "C:\Users\adamszeq\Desktop\Clones\Campaigns\Days Queries\%%~nf%date:~-4,4%%date:~-7,2%%date:~-10,2%_.csv" -h -1 -s "," -W 
sqlcmd -S %SERVER% -U %LOGIN% -P %PASSWORD% -i %%~f -o "C:\Users\adamszeq\Desktop\Clones\Campaigns\Days Queries\%%~nf%date:/=-%.csv" -h -1 -s "," -W 


)

pause
