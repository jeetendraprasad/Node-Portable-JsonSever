set WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

echo %WORKING_FOLDER1%

SET NODE_FOLDER=node-v22.17.0-win-x64
SET NODE_FOLDER_ZIP=node-v22.17.0-win-x64.zip

SET PATH="%WORKING_FOLDER1%\%NODE_FOLDER%"
SET PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0\;"%WORKING_FOLDER1%\node_modules\.bin"


powershell -noprofile -executionpolicy remotesigned -command " Expand-Archive -Path '%WORKING_FOLDER1%\%NODE_FOLDER_ZIP%' -DestinationPath '%WORKING_FOLDER1%\' "



node -v

mkdir "%WORKING_FOLDER1%/npm-cache-global"
powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set cache '%WORKING_FOLDER1%/npm-cache-global' --global "

mkdir "%WORKING_FOLDER1%/node-global"
powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set prefix '%WORKING_FOLDER1%/node-global' --global "

mkdir "%WORKING_FOLDER1%/npm-cache-local"
powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set cache '%WORKING_FOLDER1%/npm-cache-local' "

mkdir "%WORKING_FOLDER1%/node-local"
powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm config set prefix '%WORKING_FOLDER1%/node-local' "

#start cmd

#exit 0

@REM ADDITIONAL STEPS INSIDE NEW COMMAND PROMPT WINDOW

powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm install json-server "

powershell -noprofile -executionpolicy remotesigned -command " & %NODE_FOLDER%\npm install json-server-auth "

@echo off
setlocal enableDelayedExpansion

rem Set the output file name
set "file=db.json"

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


SET PATH=%PATH%;"%WORKING_FOLDER1%\node_modules\.bin"

json-server --watch db.json --port 3001
#-m ./node_modules/json-server-auth
