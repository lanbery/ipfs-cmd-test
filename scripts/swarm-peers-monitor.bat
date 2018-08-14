@echo off
set currentPath=%cd%
set "ts=%time: =0%"
set beginTime=%date:~0,4%-%date:~5,2%-%date:~8,2% %ts:~0,2%:%ts:~3,2%:%ts:~6,2%
set logDate=%date:~0,4%-%date:~5,2%-%date:~8,2%
set logTime=%ts:~0,2%%ts:~3,2%
set logfile=%currentPath%\%logDate%.%logTime%.ipfs.log
set INTERVAL=6
set maxTime=10
set num=0
@echo off
echo %logfile%
echo ------------------- BEGIN : %beginTime% ----------------------------------- >> %logfile%
echo GOPATH: %GOPATH% >> %logfile%
echo "Ã¿¸ô %INTERVAL% Ãë¼ì²â swarm peers" >> %logfile%
echo "µ±Ç° IPFS Node: " >> %logfile%
ipfs id >> %logfile%
set params=%logfile%
echo "IPFS Starting........" >>  %logfile%
call ipfs.starter.bat

echo %date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2% %time% >> %logfile%
echo "IPFS START Success." >>  %logfile%
@ping -n 10 127.1 >nul
echo ************************************************************************************** >> %logfile%

@echo off
goto swarmpeers
pause

rem Æô¶¯¼à²â
:swarmpeers
set /a num+=1

echo ****** The %num% Times ******
echo --------%num% [ %date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2% %time%  ] --------------------------- >> %logfile%
ipfs swarm peers >> %logfile%
if %num% equ %maxTime% goto shutdown
@ping -n %INTERVAL% 127.1 >nul
goto swarmpeers

rem shutdown 
:shutdown
ipfs shutdown
exit

