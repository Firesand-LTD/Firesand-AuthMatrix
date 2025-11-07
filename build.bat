@echo off
REM Build script for AuthMatrix executable

echo ====================================
echo Building AuthMatrix Executable
echo ====================================
echo.

echo Checking Python installation...
python --version
if %errorlevel% neq 0 (
    echo ERROR: Python not found!
    exit /b 1
)

echo.
echo Installing/upgrading build dependencies...
python -m pip install --upgrade pip
pip install pyinstaller

echo.
echo Building executable with PyInstaller...
pyinstaller AuthMatrix.spec

if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    exit /b 1
)

echo.
echo ====================================
echo Build completed successfully!
echo ====================================
echo.
echo Executable location: dist\AuthMatrix.exe
echo.
echo You can now run: dist\AuthMatrix.exe
echo.

pause
