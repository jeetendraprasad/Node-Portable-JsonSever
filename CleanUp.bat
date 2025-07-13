set WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

echo %WORKING_FOLDER1%

rmdir /s /q "%WORKING_FOLDER1%\node_modules"
rmdir /s /q "%WORKING_FOLDER1%\node-global"
rmdir /s /q "%WORKING_FOLDER1%\node-local"
rmdir /s /q "%WORKING_FOLDER1%\npm-cache-global"
rmdir /s /q "%WORKING_FOLDER1%\npm-cache-local"

del /q "%WORKING_FOLDER1%\package.json"
del /q "%WORKING_FOLDER1%\package-lock.json"
del /q "%WORKING_FOLDER1%\FirstTimeRunCompleted"
del /q "%WORKING_FOLDER1%\db.json"

pause