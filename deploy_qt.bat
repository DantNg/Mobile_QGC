@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d D:\C++\qgroundcontrol
C:\Qt\6.10.3\msvc2022_64\bin\windeployqt.exe --release --qmldir src build\Release\QGroundControl.exe
echo.
echo === Done ===
dir build\Release\Qt6SerialPort*.dll /b 2>nul && echo Qt6SerialPort.dll deployed! || echo WARNING: Qt6SerialPort.dll NOT found!
