#!/usr/bin/env python
# encoding: utf-8

'''
Copyright Siddharth Bharat Purohit, CubePilot Pty. Ltd. 2021
Released under GNU GPL version 3 or later
'''

import os
import sys
import subprocess
import pexpect
sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.realpath(__file__)), "../pydronecan/"))
import dronecan

from dronecan_dsdlc_helpers import *

def compile_test_app(msg_name, build_dir):
    print(bcolors.BOLD + 'Compiling Test App for %s' % msg_name + bcolors.ENDC)
    subprocess.run('cd %s/test/; make -f test_%s.mk' % (build_dir, msg_name), shell=True, check=True)

def run_test(msg, msg_type, build_dir):
    if msg_type:
        msg_full_name = msg.full_name + '_' + msg_type
    else:
        msg_full_name = msg.full_name
    print(bcolors.BOLD + 'Running Test App for %s' % msg_full_name + bcolors.ENDC)
    p = pexpect.spawn('%s/test/%s' % (build_dir, msg_full_name))
    payload = bytearray.fromhex(p.readline().decode('utf-8').strip())
    print("Sample Payload:", payload.hex())
    if len(payload) == 0:
        return
    msg_struct = dronecan.transport.CompoundValue(msg, _mode=msg_type)
    print(msg, msg_struct)
    msg_struct._unpack(dronecan.transport.bits_from_bytes(payload))
    print(msg_struct)
    print(dronecan.transport.bits_from_bytes(payload))
    print(msg_struct._pack())
    #pack the struct
    repacked_payload = bytearray.hex(dronecan.transport.bytes_from_bits(msg_struct._pack()))
    print("Packed Struct:", repacked_payload)
    msg_struct._unpack(dronecan.transport.bits_from_bytes(bytearray.fromhex(repacked_payload)))
    print(msg_struct)
    print(msg_struct._pack())

    if repacked_payload != payload.hex():
        raise Exception("Repacked payload does not match original payload")
    p.sendline(repacked_payload)
    lines = p.readlines()
    stripped_lines = [line.decode('utf-8').strip() for line in lines]
    print(stripped_lines)
    if 'Messages are equal' in stripped_lines:
        return
    else:
        raise Exception("Test failed")

if __name__ == '__main__':
    msg = dronecan.uavcan.equipment.ahrs.MagneticFieldStrength()

    hexstr_data = '9b58afde2a5c4fd43fd8d145c0dd545d13df'
    payload = bytearray.fromhex(hexstr_data)

    msg._unpack(dronecan.transport.bits_from_bytes(payload))
    print(msg)
    payload_bits = msg._pack()
    print(bytearray.hex(dronecan.transport.bytes_from_bits(payload_bits)), hexstr_data)
