#!/bin/bash
# simple test of DSDL compilation for linux
# Tested on python 3.11.4

set -e
set -x

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PYENV=$SCRIPT_DIR/.pyenv

# Set python executable for your environment here
PY=python3

# Python virtual environment
$PY -m venv $PYENV
source $PYENV/bin/activate

# test compiler on linux
$PY -m pip install -r requirements.txt
rm -rf $SCRIPT_DIR/DSDL

git clone https://github.com/DroneCAN/DSDL $SCRIPT_DIR/DSDL

echo "Testing generation"
$PY dronecan_dsdlc.py --output $SCRIPT_DIR/dsdl_generated $SCRIPT_DIR/DSDL/dronecan $SCRIPT_DIR/DSDL/uavcan $SCRIPT_DIR/DSDL/com tests/DSDL/ardupilot 
