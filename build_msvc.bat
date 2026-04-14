@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d D:\C++\qgroundcontrol

REM Fix pip cross-disk move error (WinError 17): set TEMP to same drive as build
set TEMP=D:\C++\qgroundcontrol\build\_tmp
set TMP=D:\C++\qgroundcontrol\build\_tmp
if not exist "%TEMP%" mkdir "%TEMP%"

REM Clear broken pip-dependencies from previous failed install
if exist "build\_deps\mavlink-build\pip-dependencies" rmdir /s /q "build\_deps\mavlink-build\pip-dependencies"

cmake --build build --config Release --parallel

REM Deploy Qt DLLs next to the exe
echo.
echo === Deploying Qt DLLs ===
C:\Qt\6.10.3\msvc2022_64\bin\windeployqt.exe --release --qmldir src build\Release\QGroundControl.exe
