@echo off
setlocal
cd /d "%~dp0"

set "NAME=PCFollow"
set "VER=0.1.11"
set "PROJECT=%~dp0PCFollow\PCFollow.csproj"
set "BUILDOUT=%~dp0build_output"
set "OUT=%~dp0release\PCFollow"
set "LOCAL=Z:\PCFollow\Current"
set "ZIP=%~dp0release\PCFollow_v%VER%.zip"

echo ================================================
echo PC Follow v%VER% ビルド
echo ================================================
echo.

echo [1/5] 復元しています...
dotnet restore "%PROJECT%"
if errorlevel 1 goto :error

echo [2/5] ビルドしています...
if exist "%BUILDOUT%" rmdir /s /q "%BUILDOUT%"
dotnet build "%PROJECT%" -c Release --no-restore -o "%BUILDOUT%"
if errorlevel 1 goto :error
if not exist "%BUILDOUT%\PCFollow.dll" goto :error

echo [3/5] 配布用フォルダーを作成しています...
if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%\images" >nul 2>nul
copy /y "%BUILDOUT%\PCFollow.dll" "%OUT%\PCFollow.dll" >nul
copy /y "%~dp0PCFollow\PCFollow.json" "%OUT%\PCFollow.json" >nul
if exist "%BUILDOUT%\PCFollow.deps.json" copy /y "%BUILDOUT%\PCFollow.deps.json" "%OUT%\PCFollow.deps.json" >nul
copy /y "%~dp0images\icon.png" "%OUT%\images\icon.png" >nul
if not exist "%OUT%\PCFollow.dll" goto :error
if not exist "%OUT%\images\icon.png" goto :error

echo [4/5] ローカルテスト用へ配置しています...
if not exist "%LOCAL%" mkdir "%LOCAL%" >nul 2>nul
if not exist "%LOCAL%\images" mkdir "%LOCAL%\images" >nul 2>nul
copy /y "%OUT%\PCFollow.dll" "%LOCAL%\PCFollow.dll" >nul
copy /y "%OUT%\PCFollow.json" "%LOCAL%\PCFollow.json" >nul
if exist "%OUT%\PCFollow.deps.json" copy /y "%OUT%\PCFollow.deps.json" "%LOCAL%\PCFollow.deps.json" >nul
copy /y "%OUT%\images\icon.png" "%LOCAL%\images\icon.png" >nul
if not exist "%LOCAL%\PCFollow.dll" goto :error
if not exist "%LOCAL%\images\icon.png" goto :error

echo [5/5] 配布ZIPを作成しています...
if not exist "%~dp0release" mkdir "%~dp0release" >nul 2>nul
if exist "%ZIP%" del /q "%ZIP%"
powershell -NoProfile -Command "Compress-Archive -Path '%OUT%\*' -DestinationPath '%ZIP%' -Force"
if errorlevel 1 goto :error
if not exist "%ZIP%" goto :error

echo.
echo [成功] DLL: %LOCAL%\PCFollow.dll
echo [成功] アイコン: %LOCAL%\images\icon.png
echo [成功] 配布ZIP: %ZIP%
echo.
echo ================================================
echo ビルドと配置が正常に完了しました
echo ================================================
pause
exit /b 0

:error
echo.
echo ================================================
echo ビルドまたは配置に失敗しました
echo この画面の内容をそのまま送ってください
echo ================================================
pause
exit /b 1
