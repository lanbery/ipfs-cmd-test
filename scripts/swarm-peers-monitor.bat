@echo off
set currentPath=%cd%
set "ts=%time: =0%"
set beginTime=%date:~0,4%-%date:~5,2%-%date:~8,2% %ts:~0,2%:%ts:~3,2%:%ts:~6,2%
set logDate=%date:~0,4%-%date:~5,2%-%date:~8,2%
set logTime=%ts:~0,2%%ts:~3,2%
set logfile=%currentPath%\%logDate%.%logTime%.ipfs.log
set INTERVAL=5
set maxTime=6
set num=0
@echo off
echo %logfile%
echo ------------------- BEGIN : %beginTime% ----------------------------------- >> %logfile%
echo GOPATH: %GOPATH% >> %logfile%
echo "Ã¿¸ô %INTERVAL% Ãë¼ì²â swarm peers" >> %logfile%
echo "µ±Ç° IPFS Node: " >> %logfile%
ipfs id >> %logfile%
set params=%logfile%
start /MIN ipfs.starter.bat %params%
@ping -n 10 127.1 >nul
echo "IPFS START Success." >>  %logfile%
echo ************************************************************************************** >> %logfile%

goto swarmpeers
pause

:swarmpeers
set /a num+=1
set tstag=%date:~0,4%-%date:~5,2%-%date:~8,2% %ts:~0,2%:%ts:~3,2%:%ts:~6,2% %ts% >> %logfile%
echo --------%num% [ %tstag% ] --------------------------- >> %logfile%
ipfs swarm peers >> %logfile%
if %num% equ %maxTime% exit
@ping -n %INTERVAL% 127.1 >nul
goto swarmpeers

