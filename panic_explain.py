#! /usr/bin/env python
#read kerncodes;kerncode=$(echo "${kerncodes}"|perl -pe 's/\s//g;s/([a-f0-9]{2})/\\x$1/g;s/^(.*)</\(\?\<\=$1\)/;s/>(.*)/\(\?\=$1\)/'); LC_ALL=C grep -roPba $kerncode /lib/modules/$(uname -r)/kernel/ ; LC_ALL=C grep -oPba $kerncode /boot/vmlinux-$(uname -r)
scale = 16 
num_of_bits = 4
var = raw_input("Kernel panic error number?: ")
my_bindata = bin(int(var, scale))[2:].zfill(num_of_bits)
print my_bindata
my_hexdata = int(var)
print "protection fault" if my_hexdata&1 != 0 else "no page found" 
print "write access" if my_hexdata&2 != 0 else "read or execute access"
print "user-mode access" if my_hexdata&4 != 0 else "kernel-mode access"
print "instruction fetch" if my_hexdata&8 != 0 else "not instruction fetch "
