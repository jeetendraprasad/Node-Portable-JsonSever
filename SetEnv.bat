@REM: https://monsterlessons-academy.com/posts/create-a-rest-api-with-json-server

set WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

echo %WORKING_FOLDER1%

SET NODE_FOLDER=node-v22.17.0-win-x64
SET NODE_FOLDER_ZIP=node-v22.17.0-win-x64.zip
SET FIRST_TIME_RUN_FILE=FirstTimeRunCompleted
set "file=db.json"
set "ps_test_script=TestScript.ps1"


SET PATH="%WORKING_FOLDER1%\%NODE_FOLDER%"
SET PATH=%PATH%;"%WORKING_FOLDER1%\node_modules\.bin"
SET PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0\;


if not exist "%WORKING_FOLDER1%\%NODE_FOLDER%\" (
	powershell -noprofile -executionpolicy remotesigned -command " Expand-Archive -Path '%WORKING_FOLDER1%\%NODE_FOLDER_ZIP%' -DestinationPath '%WORKING_FOLDER1%\' "
)

node -v

#start cmd

if not exist "%WORKING_FOLDER1%\%FIRST_TIME_RUN_FILE%" (

	mkdir "%WORKING_FOLDER1%\USERHOME"
	# NOTE NO double quotes in USERHOME
	set HOME=%WORKING_FOLDER1%\USERHOME


	mkdir "%WORKING_FOLDER1%\USERCACHE\"
	mkdir "%WORKING_FOLDER1%\USER-PREFIX"

	
	@REM %ComSpec% /C npm install --save-dev json-server json-server-auth
	
	%ComSpec% /C npm install json-server@0.17.4
	
	%ComSpec% /C npm install json-server-auth

	%ComSpec% /C npm pkg set scripts.start="json-server-auth --watch db.json --port 3001"

	%ComSpec% /C npm install
)

%ComSpec% /C npm config get cache
%ComSpec% /C npm config set cache "%WORKING_FOLDER1%\USERCACHE"

%ComSpec% /C npm config get prefix
%ComSpec% /C npm config set prefix "%WORKING_FOLDER1%\USER-PREFIX"


#start cmd

#exit 0


if not exist "%WORKING_FOLDER1%\%file%" (

	@echo off
	setlocal enableDelayedExpansion

	rem Set the output file name
	

	rem Write the JSON content to the file
	(
		echo {
		echo   "posts": [
		echo     { "id": 1, "title": "json-server" },
		echo     { "id": 2, "title": "node js" }
		echo   ],
		echo   "users": []
		echo }
	) > "%file%"

	echo JSON content written to %file%
)




echo 1 > "%WORKING_FOLDER1%\%FIRST_TIME_RUN_FILE%"

start %ComSpec% /k " npm start "

powershell -noprofile -command " Start-Sleep -s 15 "

powershell -noprofile -executionpolicy remotesigned -file "%WORKING_FOLDER1%\%ps_test_script%"
pause

@REM start cmd