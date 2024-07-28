@echo off
setlocal

:menu
echo ========================================
echo    Formateo Aliaga
echo ========================================
echo.
echo Selecciona una opcion:
echo 1. Instalar programas
echo 2. Optimizaciones
echo 3. Salir
echo.
set /p option=Selecciona una opcion (1/2/3): 

if "%option%"=="1" goto instalar_programas
if "%option%"=="2" goto optimizaciones
if "%option%"=="3" goto salir

echo Opcion no valida. Volviendo al menu...
echo.
goto menu

:instalar_programas
echo ========================================
echo    Instalacion de Programas
echo ========================================
echo.

set "opera_gx_url=https://net.geo.opera.com/opera_gx/stable/windows?utm_source=opera.com"
set "chrome_url=https://dl.google.com/chrome/install/latest/chrome_installer.exe"
set "firefox_url=https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US"
set "brave_url=https://laptop-updates.brave.com/latest/win32"

set "spotify_url=https://download.scdn.co/SpotifySetup.exe"
set "discord_url=https://dl.discordapp.net/distro/app/stable/win/x64/1.0.9154/DiscordSetup.exe"
set "steam_url=https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
set "teamspeak_url=https://files.teamspeak-services.com/releases/client/3.6.2/TeamSpeak3-Client-win64-3.6.2.exe"
set "faceit_url=https://anticheat-client.faceit-cdn.net/FACEITInstaller_64.exe"

set install_browser=0
set install_browser_url=
set install_spotify=0
set install_discord=0
set install_steam=0
set install_teamspeak=0
set install_faceit=0

echo Selecciona un navegador para instalar:
echo 1. Opera GX
echo 2. Google Chrome
echo 3. Firefox
echo 4. Brave
set /p browser_choice=Selecciona una opcion (1/2/3/4): 

if "%browser_choice%"=="1" (
    set install_browser=1
    set "install_browser_url=%opera_gx_url%"
)
if "%browser_choice%"=="2" (
    set install_browser=1
    set "install_browser_url=%chrome_url%"
)
if "%browser_choice%"=="3" (
    set install_browser=1
    set "install_browser_url=%firefox_url%"
)
if "%browser_choice%"=="4" (
    set install_browser=1
    set "install_browser_url=%brave_url%"
)

set /p spotify_choice=Quieres instalar Spotify? (S/N): 
if /i "%spotify_choice%"=="S" (
    set install_spotify=1
)

set /p discord_choice=Quieres instalar Discord? (S/N): 
if /i "%discord_choice%"=="S" (
    set install_discord=1
)

set /p steam_choice=Quieres instalar Steam? (S/N): 
if /i "%steam_choice%"=="S" (
    set install_steam=1
)

set /p teamspeak_choice=Quieres instalar TeamSpeak? (S/N): 
if /i "%teamspeak_choice%"=="S" (
    set install_teamspeak=1
)

set /p faceit_choice=Quieres instalar FACEIT? (S/N): 
if /i "%faceit_choice%"=="S" (
    set install_faceit=1
)

echo.
echo Descargando e instalando programas seleccionados...
echo.

if %install_browser%==1 (
    call :install_program "Navegador" "%install_browser_url%"
)

if %install_spotify%==1 (
    call :install_program "Spotify" "%spotify_url%"
)

if %install_discord%==1 (
    call :install_program "Discord" "%discord_url%"
)

if %install_steam%==1 (
    call :install_program "Steam" "%steam_url%"
)

if %install_teamspeak%==1 (
    call :install_program "TeamSpeak" "%teamspeak_url%"
)

if %install_faceit%==1 (
    call :install_program "FACEIT" "%faceit_url%"
)

echo.
echo Instalaciones completadas.
echo.
pause
goto menu

:optimizaciones
echo ========================================
echo    Optimizaciones
echo ========================================
echo.

set optimize_discord=0
set optimize_spotify=0
set optimize_notifications=0
set optimize_onedrive=0
set optimize_powerplan=0

set /p disable_hw_acceleration_discord=Quieres desactivar la aceleracion por hardware en Discord? (S/N): 
if /i "%disable_hw_acceleration_discord%"=="S" (
    set optimize_discord=1
)

set /p disable_hw_acceleration_spotify=Quieres desactivar la aceleracion por hardware en Spotify? (S/N): 
if /i "%disable_hw_acceleration_spotify%"=="S" (
    set optimize_spotify=1
)

set /p disable_notifications=Quieres desactivar las notificaciones de Windows para todos los programas? (S/N): 
if /i "%disable_notifications%"=="S" (
    set optimize_notifications=1
)

set /p disable_onedrive=Quieres desactivar OneDrive? (S/N): 
if /i "%disable_onedrive%"=="S" (
    set optimize_onedrive=1
)

set /p apply_powerplan=Quieres aplicar el plan de energia recomendado? (S/N): 
if /i "%apply_powerplan%"=="S" (
    set optimize_powerplan=1
)

echo.
echo Aplicando optimizaciones seleccionadas...
echo.

if %optimize_discord%==1 (
    call :disable_hw_acceleration_discord
)

if %optimize_spotify%==1 (
    call :disable_hw_acceleration_spotify
)

if %optimize_notifications%==1 (
    call :disable_notifications
)

if %optimize_onedrive%==1 (
    call :disable_onedrive
)

if %optimize_powerplan%==1 (
    call :apply_powerplan
)

echo.
echo Optimizacion completada.
echo.
pause
goto menu

:disable_hw_acceleration_discord
echo Cerrando Discord si esta en ejecucion...
taskkill /F /IM Discord.exe

echo Desactivando aceleracion por hardware en Discord...
set discord_settings_file=%APPDATA%\discord\settings.json

echo Verificando archivo de configuracion de Discord en %discord_settings_file%
if exist "%discord_settings_file%" (
    powershell -Command "(Get-Content -Path '%discord_settings_file%') -replace '\"enableHardwareAcceleration\":true', '\"enableHardwareAcceleration\":false' | Set-Content -Path '%discord_settings_file%'"
    echo Aceleracion por hardware desactivada.
) else (
    echo El archivo de configuracion de Discord no se encontro.
)

goto :eof

:disable_hw_acceleration_spotify
echo Cerrando Spotify si esta en ejecucion...
taskkill /F /IM Spotify.exe

echo Desactivando aceleracion por hardware en Spotify...
set spotify_settings_file=%APPDATA%\Spotify\prefs

echo Verificando archivo de configuracion de Spotify en %spotify_settings_file%
if not exist "%spotify_settings_file%" (
    echo Archivo de configuracion de Spotify no encontrado, creando archivo.
    echo ui.hardware_acceleration=false > "%spotify_settings_file%"
) else (
    echo Archivo de configuracion de Spotify encontrado.
    powershell -Command "if (-not (Select-String -Path '%spotify_settings_file%' -Pattern 'ui.hardware_acceleration=false')) { Add-Content -Path '%spotify_settings_file%' -Value 'ui.hardware_acceleration=false' }"
)

echo Aceleracion por hardware desactivada.
goto :eof

:disable_notifications
echo Desactivando notificaciones de Windows para todos los programas...
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Value 0"
echo Notificaciones de Windows desactivadas.
goto :eof

:disable_onedrive
echo Desactivando OneDrive...
echo Kill OneDrive process
taskkill /F /IM "OneDrive.exe"
taskkill /F /IM "explorer.exe"

echo Remove OneDrive
if exist "%systemroot%\System32\OneDriveSetup.exe" (
    "%systemroot%\System32\OneDriveSetup.exe" /uninstall
)
if exist "%systemroot%\SysWOW64\OneDriveSetup.exe" (
    "%systemroot%\SysWOW64\OneDriveSetup.exe" /uninstall
)

echo Removing OneDrive leftovers
rmdir /S /Q "%localappdata%\Microsoft\OneDrive"
rmdir /S /Q "%programdata%\Microsoft OneDrive"
rmdir /S /Q "%systemdrive%\OneDriveTemp"

echo Check if directory is empty before removing
dir /b "%userprofile%\OneDrive" >nul 2>nul
if errorlevel 1 (
    rmdir /S /Q "%userprofile%\OneDrive"
)

echo Disable OneDrive via Group Policies
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f

echo Remove Onedrive from explorer sidebar
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f

echo Removing run hook for new users
reg load HKU\Default "C:\Users\Default\NTUSER.DAT"
reg delete "HKU\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload HKU\Default

echo Removing startmenu entry
del "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /Q

echo Removing scheduled task
schtasks /Delete /TN "OneDrive*" /F

echo Restarting explorer
start explorer.exe

echo Waiting for explorer to complete loading
timeout /T 10
echo OneDrive desactivado.
goto :eof

:apply_powerplan
echo Aplicando plan de energia recomendado...
set powerplan_url=https://files.aliaga.lol/Khorvie.pow
powershell -Command "Start-BitsTransfer -Source '%powerplan_url%' -Destination '%temp%\Khorvie.pow'"
powercfg -import "%temp%\Khorvie.pow"
for /f "tokens=4 delims= " %%i in ('powercfg /list ^| findstr /i "Khorvie''s PowerPlan"') do (
    echo GUID encontrado: %%i
    set KhorvieGUID=%%i
)
set KhorvieGUID=%KhorvieGUID: =%
echo GUID limpio: %KhorvieGUID%
powercfg /setactive %KhorvieGUID%
if %errorlevel% neq 0 (
    echo Error al cambiar al plan de energía Khorvie.
    pause
    exit /b
)
echo Plan de energia Khorvie activado.
for /f "skip=2 tokens=4 delims= " %%i in ('powercfg /list') do (
    if not "%%i"=="%KhorvieGUID%" (
        echo Eliminando el plan de energía: %%i
        powercfg /delete %%i
        if %errorlevel% neq 0 (
            echo Error al eliminar el plan de energía: %%i
        )
    )
)
del "%temp%\Khorvie.pow"
echo Archivo Khorvie.pow eliminado.
echo Plan de energia recomendado aplicado.
goto :eof

:install_program
set "program_name=%~1"
set "program_url=%~2"
echo Descargando e instalando %program_name%...
powershell -Command "Start-BitsTransfer -Source '%program_url%' -Destination '%temp%\%program_name%.exe'"
start /wait "" "%temp%\%program_name%.exe"
del "%temp%\%program_name%.exe"
echo %program_name% instalado.
goto :eof

:salir
exit