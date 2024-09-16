@echo off
setlocal

:menu
echo ========================================
echo    Formateo Aliaga
echo ========================================
echo.
echo Selecciona una opcion:
echo 1. Instalar programas
echo 2. Salir
echo.
set /p option=Selecciona una opcion (1/2): 

if "%option%"=="1" goto instalar_programas
if "%option%"=="2" goto salir

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
set "7zip_url=https://7-zip.org/a/7z2408-x64.exe"
set "lightshot_url=https://app.prntscr.com/build/setup-lightshot.exe"
set "openvpn_url=https://openvpn.net/downloads/openvpn-connect-v3-windows.msi"

set install_browser=0
set install_browser_url= 
set install_spotify=0
set install_discord=0
set install_steamm=0
set install_teamspeak=0
set install_faceit=0
set install_7zip=0
set install_lightshot=0
set install_openvpn=0

echo Selecciona un navegador para instalar:
echo 1. Opera GX
echo 2. Google Chrome
echo 3. Firefox
echo 4. Brave
echo 5. No instalar ningun navegador
set /p browser_choice=Selecciona una opcion (1/2/3/4/5): 

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
if "%browser_choice%"=="5" (
    set install_browser=0
)

set /p spotify_choice=Quieres instalar Spotify? (S/N): 
if /i "%spotify_choice%"=="S" (
    set install_spotify=1
)

set /p discord_choice=Quieres instalar Discord? (S/N): 
if /i "%discord_choice%"=="S" (
    set install_discord=1
)

set /p steamm_choice=Quieres instalar Steamm? (S/N): 
if /i "%steamm_choice%"=="S" (
    set install_steamm=1
)

set /p teamspeak_choice=Quieres instalar TeamSpeak? (S/N): 
if /i "%teamspeak_choice%"=="S" (
    set install_teamspeak=1
)

set /p faceit_choice=Quieres instalar FACEIT? (S/N): 
if /i "%faceit_choice%"=="S" (
    set install_faceit=1
)

set /p 7zip_choice=Quieres instalar 7zip? (S/N): 
if /i "%7zip_choice%"=="S" (
    set install_7zip=1
)

set /p lightshot_choice=Quieres instalar Lightshot? (S/N): 
if /i "%lightshot_choice%"=="S" (
    set install_lightshot=1
)

set /p openvpn_choice=Quieres instalar OpenVPN? (S/N): 
if /i "%openvpn_choice%"=="S" (
    set install_openvpn=1
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

if %install_steamm%==1 (
    call :install_program "Steamm" "%steam_url%"
)

if %install_teamspeak%==1 (
    call :install_program "TeamSpeak" "%teamspeak_url%"
)

if %install_faceit%==1 (
    call :install_program "FACEIT" "%faceit_url%"
)

if %install_7zip%==1 (
    call :install_program "7zip" "%7zip_url%"
)

if %install_lightshot%==1 (
    call :install_program "Lightshot" "%lightshot_url%"
)

if %install_openvpn%==1 (
    call :install_program "OpenVPN" "%openvpn_url%"
)

echo.
echo Instalaciones completadas.
echo.
pause
goto menu

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
