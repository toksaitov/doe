#!/bin/sh

# Start QEMU
qemu -s -S -kernel kernel &

# Start GDB
if [ `uname` == 'Darwin' ] ; then i386-elf-gdb ; else gdb ; fi

