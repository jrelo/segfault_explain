#! /usr/bin/env python
scale = 16 
num_of_bits = 4
var = raw_input("Segfault error number?: ")
my_bindata = bin(int(var, scale))[2:].zfill(num_of_bits)
print my_bindata
my_hexdata = int(var)
print "protection fault" if my_hexdata&1 != 0 else "no page found" 
print "write access" if my_hexdata&2 != 0 else "read access"
print "user-mode access" if my_hexdata&4 != 0 else "kernel-mode access"
print "reserved bit" if my_hexdata&8 != 0 else " "
print "fault was an instruction fetch" if my_hexdata&16 != 0 else " "
