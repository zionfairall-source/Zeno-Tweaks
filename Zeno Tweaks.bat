@echo off
setlocal EnableExtensions EnableDelayedExpansion
title ZENO // FORTNITE PERFORMANCE SUITE
mode con: cols=86 lines=34
color 0B

:: ZENO FORTNITE PERFORMANCE SUITE
:: Safe Windows tweaks. No FPS or ping increase is guaranteed.

set "ADMIN=NO"
net session >nul 2>&1 && set "ADMIN=YES"

:HOME
cls
call :BANNER
echo  [ SYSTEM ]  Windows optimisation console
echo  [ ACCESS ]  Administrator: !ADMIN!
echo  [ MODE   ]  Select a module below
echo.
echo  ================================================================
echo                         PERFORMANCE MODULES
echo  ================================================================
echo.
echo    [01]  High Performance power plan
echo    [02]  Enable Windows Game Mode
echo    [03]  Disable Xbox Game DVR
echo    [04]  Disable background game recording
echo    [05]  Best-performance visual effects
echo    [06]  Disable Windows transparency
echo    [07]  Clean user temporary files
echo    [08]  Clean Windows temporary files        [ADMIN]
echo.
echo  ================================================================
echo                            NETWORK TOOLS
echo  ================================================================
echo.
echo    [09]  Flush DNS cache
echo    [10]  Renew network IP address
echo    [11]  Reset Winsock                         [ADMIN]
echo    [12]  Reset TCP/IP                          [ADMIN]
echo.
echo  ================================================================
echo                          SYSTEM SHORTCUTS
echo  ================================================================
echo.
echo    [13]  Manage startup apps
echo    [14]  Fortnite graphics preference
echo    [15]  Restore common Windows settings
echo.
echo    [00]  Exit ZENO
echo.
echo  ----------------------------------------------------------------
set "CHOICE="
set /p "CHOICE=  ZENO  ^> Enter module number: "

if "!CHOICE!"=="1" goto POWER
if "!CHOICE!"=="01" goto POWER
if "!CHOICE!"=="2" goto GAMEMODE
if "!CHOICE!"=="02" goto GAMEMODE
if "!CHOICE!"=="3" goto DVR
if "!CHOICE!"=="03" goto DVR
if "!CHOICE!"=="4" goto CAPTURE
if "!CHOICE!"=="04" goto CAPTURE
if "!CHOICE!"=="5" goto VISUAL
if "!CHOICE!"=="05" goto VISUAL
if "!CHOICE!"=="6" goto TRANSPARENCY
if "!CHOICE!"=="06" goto TRANSPARENCY
if "!CHOICE!"=="7" goto USERTEMP
if "!CHOICE!"=="07" goto USERTEMP
if "!CHOICE!"=="8" goto WINTEMP
if "!CHOICE!"=="08" goto WINTEMP
if "!CHOICE!"=="9" goto DNS
if "!CHOICE!"=="09" goto DNS
if "!CHOICE!"=="10" goto RENEW
if "!CHOICE!"=="11" goto WINSOCK
if "!CHOICE!"=="12" goto TCP
if "!CHOICE!"=="13" goto STARTUP
if "!CHOICE!"=="14" goto GRAPHICS
if "!CHOICE!"=="15" goto RESTORE
if "!CHOICE!"=="0" goto EXIT
if "!CHOICE!"=="00" goto EXIT
echo.
echo  [!] Invalid selection. Choose a number from 00 to 15.
timeout /t 2 >nul
goto HOME

:BANNER
echo.
echo   ZZZZZZZZZZ   EEEEEEEEE   NNNN    NN   OOOOOOOO
echo         ZZ     EE          NNNNN   NN  OO      OO
echo        ZZ      EEEEEEEE    NN NN   NN  OO      OO
echo       ZZ       EE          NN  NN  NN  OO      OO
echo      ZZ        EEEEEEEEE   NN   NNNNN   OOOOOOOO
echo.
echo   ================================================================
echo                 Z E N O   //   F O R T N I T E
echo                    PERFORMANCE  S U I T E
echo   ================================================================
echo.
exit /b

:POWER
call :HEADER "01 // POWER PLAN"
echo  Applying the Windows High Performance power plan...
powercfg /setactive SCHEME_MIN
echo.
echo  [OK] Power plan command completed.
echo  Note: Some PCs may not expose this power plan.
goto DONE

:GAMEMODE
call :HEADER "02 // GAME MODE"
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
echo.
echo  [OK] Windows Game Mode enabled for this account.
goto DONE

:DVR
call :HEADER "03 // GAME DVR"
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
echo.
echo  [OK] Game DVR capture disabled for this account.
goto DONE

:CAPTURE
call :HEADER "04 // BACKGROUND CAPTURE"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AudioCaptureEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v HistoricalCaptureEnabled /t REG_DWORD /d 0 /f
echo.
echo  [OK] Background game recording disabled for this account.
goto DONE

:VISUAL
call :HEADER "05 // VISUAL EFFECTS"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
echo.
echo  [OK] Windows visual effects set to best performance.
echo  Sign out and back in if the change is not immediate.
goto DONE

:TRANSPARENCY
call :HEADER "06 // TRANSPARENCY"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
echo.
echo  [OK] Transparency disabled.
goto DONE

:USERTEMP
call :HEADER "07 // USER TEMP CLEANER"
echo  Removing temporary files from your user TEMP folder...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1
echo.
echo  [OK] Cleanup finished. Files currently in use were skipped.
goto DONE

:WINTEMP
call :HEADER "08 // WINDOWS TEMP CLEANER"
if "!ADMIN!"=="NO" (
    echo  [!] Run ZENO as Administrator to use this module.
    goto DONE
)
echo  Removing temporary files from the Windows TEMP folder...
del /f /s /q "%WINDIR%\Temp\*" >nul 2>&1
for /d %%D in ("%WINDIR%\Temp\*") do rd /s /q "%%D" >nul 2>&1
echo.
echo  [OK] Cleanup finished. Files currently in use were skipped.
goto DONE

:DNS
call :HEADER "09 // DNS REFRESH"
ipconfig /flushdns
echo.
echo  [OK] DNS resolver cache flushed.
echo  This may fix stale lookups; it does not normally reduce Fortnite ping.
goto DONE

:RENEW
call :HEADER "10 // NETWORK RENEW"
echo  Your connection may briefly disconnect during this operation.
ipconfig /release
ipconfig /renew
echo.
echo  [OK] Network address renewal attempted.
goto DONE

:WINSOCK
call :HEADER "11 // WINSOCK RESET"
if "!ADMIN!"=="NO" (
    echo  [!] Run ZENO as Administrator to use this module.
    goto DONE
)
netsh winsock reset
echo.
echo  [OK] Winsock reset requested. Restart Windows to apply it.
goto DONE

:TCP
call :HEADER "12 // TCP/IP RESET"
if "!ADMIN!"=="NO" (
    echo  [!] Run ZENO as Administrator to use this module.
    goto DONE
)
netsh int ip reset
echo.
echo  [OK] TCP/IP reset requested. Restart Windows to apply it.
goto DONE

:STARTUP
call :HEADER "13 // STARTUP MANAGER"
start "" ms-settings:startupapps
echo  [OK] Startup Apps settings opened.
echo  Disable only apps you recognise and do not need.
goto DONE

:GRAPHICS
call :HEADER "14 // FORTNITE GRAPHICS"
start "" ms-settings:display-graphics
echo  [OK] Graphics settings opened.
echo  Add Fortnite, choose Options, then High performance if available.
goto DONE

:RESTORE
call :HEADER "15 // RESTORE DEFAULTS"
echo  Restoring common Windows gaming settings...
powercfg /setactive SCHEME_BALANCED
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AudioCaptureEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v HistoricalCaptureEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
echo.
echo  [OK] Common settings restored.
echo  Note: This does not undo network resets or recover deleted temp files.
goto DONE

:HEADER
cls
call :BANNER
echo   ---------------------------------------------------------------
echo     MODULE: %~1
echo   ---------------------------------------------------------------
echo.
exit /b

:DONE
echo.
echo   ---------------------------------------------------------------
echo     MODULE COMPLETE  //  Review any messages above.
echo   ---------------------------------------------------------------
echo.
pause
goto HOME

:EXIT
cls
call :BANNER
echo   Thanks for using ZENO Performance Suite.
echo.
timeout /t 2 >nul
exit /b
