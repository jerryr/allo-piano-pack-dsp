#!/bin/bash
import struct
import sys
magic = 0xE0
infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], "wb")
outfile.write(struct.pack("B", magic))
while True:
    line = infile.readline()
    if not line:
        break
    if line.startswith('#'):
        continue
    if line.startswith('w'):
        elems = line.split()
        (addr, offset, value) = (int(elems[1], base=16), int(elems[2], base=16), int(elems[3], base=16))
        #print("address = %d, offset = %d, value = %d" % (addr, offset, value))
        b = struct.pack("BBB", addr, offset, value)
        outfile.write(b)
    if line.startswith(">"):
        # offset = offset + 1
        # elems = line.split()
        # value = int(elems[1], base=16) 
        offset=1 #Hacky!
        value=0
        b = struct.pack("BBB", addr, offset, value)
        outfile.write(b)


infile.close()
outfile.close()
