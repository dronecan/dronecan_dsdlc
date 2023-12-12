@echo off
@REM Simple test of DSDL compilation for windows
@REM Tested on python 3.12.0

set SCRIPT_DIR=%~dp0
echo %SCRIPT_DIR:~0,-1% 1>NUL 2>NUL
set PYENV="%SCRIPT_DIR%\.pyenv"

@REM Set python executable for your environment here
set PY=python 

@REM Python virtual environment
%PY% -m venv %PYENV%
call %PYENV%\Scripts\activate

@REM Install Python requirements
%PY% -m pip install -r requirements.txt

rmdir /S /Q  %SCRIPT_DIR%\DSDL 1>NUL 2>NUL
git clone https://github.com/DroneCAN/DSDL %SCRIPT_DIR%\DSDL

echo "Testing generation"
%PY% dronecan_dsdlc.py --output %SCRIPT_DIR%\dsdl_generated %SCRIPT_DIR%\DSDL\dronecan %SCRIPT_DIR%\DSDL\uavcan %SCRIPT_DIR%\DSDL\com %SCRIPT_DIR%\DSDL\ardupilot 

