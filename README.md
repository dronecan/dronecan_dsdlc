# DroneCAN DSDL Code Generator

This project contains tools to generate C code for packing DroneCAN messages.

## Dependencies
* `pip install -r requirements.txt` 

## How To Use

To generate C code please ensure that you have these cloned alongside this project. 
```
https://github.com/dronecan/pydronecan 
https://github.com/dronecan/DSDL 
https://github.com/dronecan/libcanard 
```

Then run the following command:
```
python dronecan_dsdlc/dronecan_dsdlc.py -O <output directory> <list of namespace dirs>
# e.g. python dronecan_dsdlc/dronecan_dsdlc.py -O dsdlc_generated libraries/AP_UAVCAN/dsdl/ardupilot DSDL/uavcan
```

To run the test simply execute the following command

```
python dronecan_dsdlc/dronecan_dsdlc.py -O <output directory> <list of namespace dirs> --run-test
```

Some tests are available in the './tests' folder. Run them to test your environment.

```
# Windows
cd tests
./test_windows.cmd

```
