@REM: https://monsterlessons-academy.com/posts/create-a-rest-api-with-json-server

set WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

echo %WORKING_FOLDER1%

SET NODE_FOLDER=node-v22.17.0-win-x64
SET NODE_FOLDER_ZIP=node-v22.17.0-win-x64.zip
SET FIRST_TIME_RUN_FILE=FirstTimeRunCompleted
set "file=db.json"


SET PATH="%WORKING_FOLDER1%\%NODE_FOLDER%"
SET PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0\;"%WORKING_FOLDER1%\node_modules\.bin"


if not exist "%WORKING_FOLDER1%\%FIRST_TIME_RUN_FILE%" (
	powershell -noprofile -executionpolicy remotesigned -command " Expand-Archive -Path '%WORKING_FOLDER1%\%NODE_FOLDER_ZIP%' -DestinationPath '%WORKING_FOLDER1%\' "
)

node -v

if not exist "%WORKING_FOLDER1%\%FIRST_TIME_RUN_FILE%" (
	mkdir "%WORKING_FOLDER1%/npm-cache-global"
	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set cache '%WORKING_FOLDER1%/npm-cache-global' --global "

	mkdir "%WORKING_FOLDER1%/node-global"
	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set prefix '%WORKING_FOLDER1%/node-global' --global "

	mkdir "%WORKING_FOLDER1%/npm-cache-local"
	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set cache '%WORKING_FOLDER1%/npm-cache-local' "

	mkdir "%WORKING_FOLDER1%/node-local"
	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set prefix '%WORKING_FOLDER1%/node-local' "
	
	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm install json-server "

	powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm install json-server-auth "
	
	
	
)

powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm pkg set scripts.start='json-server --watch db.json --port 3001 -m ./node_modules/json-server-auth' "


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
		echo   ]
		echo }
	) > "%file%"

	echo JSON content written to %file%
)




SET PATH=%PATH%;"%WORKING_FOLDER1%\node_modules\.bin"

echo 1 > "%WORKING_FOLDER1%\%FIRST_TIME_RUN_FILE%"

npm start

#json-server --watch db.json --port 3001
#-m ./node_modules/json-server-auth

