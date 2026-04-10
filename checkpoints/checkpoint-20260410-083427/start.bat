@echo off
title HL-HH ES Strategy Server
echo.
echo  HL-HH ES Futures Strategy
echo  Starting local server...
echo.

:: Check for Python 3
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo  Python found. Serving on http://localhost:8888
    echo  Press Ctrl+C to stop.
    echo.
    timeout /t 1 /nobreak >nul
    start "" http://localhost:8888
    python -m http.server 8888
    goto end
)

:: Check for Python via py launcher
py --version >nul 2>&1
if %errorlevel% == 0 (
    echo  Python found (py launcher). Serving on http://localhost:8888
    echo  Press Ctrl+C to stop.
    echo.
    timeout /t 1 /nobreak >nul
    start "" http://localhost:8888
    py -m http.server 8888
    goto end
)

:: Check for Node.js
node --version >nul 2>&1
if %errorlevel% == 0 (
    echo  Node.js found. Serving on http://localhost:8888
    echo  Press Ctrl+C to stop.
    echo.
    timeout /t 1 /nobreak >nul
    start "" http://localhost:8888
    npx serve . -l 8888
    goto end
)

:: Nothing found
echo  ERROR: Python or Node.js is required to run the local server.
echo.
echo  Install Python from: https://www.python.org/downloads/
echo  (Check "Add Python to PATH" during install)
echo.
echo  Or install Node.js from: https://nodejs.org/
echo.
pause

:end
