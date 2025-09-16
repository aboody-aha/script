@echo off
chcp 65001 >nul
title Windows Deployment Tool - Installer
setlocal

:: تغيير المسار إلى مجلد الملف الحالي
cd /d "%~dp0"

:: التحقق من وجود الملفات الضرورية
if not exist "config.dat" (
    echo ERROR: config.dat not found!
    echo Please make sure config.dat is in the same folder as this script.
    pause
    exit /b 1
)

if not exist "windows\" (
    echo ERROR: windows folder not found!
    echo Please make sure windows folder is in the same folder as this script.
    pause
    exit /b 1
)

:: التحقق من صلاحيات المدير
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb RunAs"
    exit /b
)

:: تشغيل السكربت الأساسي
echo Starting Windows Deployment Tool...
powershell -ExecutionPolicy Bypass -File "%~dp0installer.ps1"

:: إبقاء النافذة مفتوحة بعد الانتهاء
echo.
echo Deployment process completed.
pause