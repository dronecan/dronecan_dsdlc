@echo off
@REM Simple test of DSDL compilation for windows
@REM Tested on python 3.12.0

@REM Set python executable for your environment here
set PY=python 

@REM Python virtual environment
%PY% -m venv .venv
call .venv/Scripts/activate

@REM Install Python requirements
%PY% -m pip install -r ../requirements.txt

git clone https://github.com/DroneCAN/DSDL

echo "Testing generation"
%PY% ../dronecan_dsdlc.py --output dsdl_generated DSDL/dronecan DSDL/uavcan DSDL/com DSDL/ardupilot 

@REM Python virtual environment
call .venv/Scripts/deactivate
