Message-ID: <D96E2AFA0DF3D211B139009027454948037362FE@helios.gnv.tcc.thomson-csf.com>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Running Linux with 2Mo of Ram.
Date: Thu, 12 Jun 2003 17:53:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am trying to run linux on a custom board ( Mpc8xx )
There is only 2Mo of RAM.
I use romfs to save RAM.

I use U-boot to start the kernel.

The kernel starts correctly.
the kernel is launched with init=/bin/sh

The kernel stops to tell me to press enter to activate the console ( to
launch the sh ) and then crash because it is running out of memory.

The question is to know if it is really impossible to make Linux work on
this target or is I have missed something that could explain that there is
no more memory available.

Thanks

Regards

Chris

--------------------------------
U-Boot 0.3.0 (Jun  4 2003 - 16:21:25)

CPU:   XPC860xxZPnnC1 at 38.400 MHz: 4 kB I-Cache 4 kB D-Cache
DRAM:   2 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0

=> setenv bootargs root=/dev/mtdblock/1 ro init=/bin/sh
=> bootm 0x90000
## Booting image at 00090000 ...
   Image Name:   Crisssou Kernel Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    263950 Bytes = 257.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.4 (blinde@Linux) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #96 jeu jun 12 15:35:15 CEST 2003
On node 0 totalpages: 512
zone(0): 512 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/mtdblock/1 ro init=/bin/sh
Decrementer Frequency: 2375000
Calibrating delay loop... 37.78 BogoMIPS
Memory: 1212k available (512k kernel code, 236k data, 32k init, 0k highmem)
Dentry-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
block: queued sectors max/low 709kB/236kB, 64 slots per queue
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
pr4gv3 flash device: 400000 at 4000000
 Amd/Fujitsu Extended Query Table v1.0 at 0x0040
number of JEDEC chips: 1
0: offset=0x0,size=0x8000,blocks=1
1: offset=0x8000,size=0x4000,blocks=2
2: offset=0x10000,size=0x10000,blocks=1
3: offset=0x20000,size=0x20000,blocks=31
Creating 2 MTD partitions on "Physically mapped flash":
0x00000000-0x00100000 : "ppcboot"
0x00100000-0x00400000 : "fs"
physmap flash device: 400000 at 4000000
 Amd/Fujitsu Extended Query Table v1.0 at 0x0040
number of JEDEC chips: 1
0: offset=0x0,size=0x8000,blocks=1
1: offset=0x8000,size=0x4000,blocks=2
2: offset=0x10000,size=0x10000,blocks=1
3: offset=0x20000,size=0x20000,blocks=31

VFS: Mounted root (romfs filesystem) readonly.
Mounted devfs on /dev

Bummer, could not run '/etc/init.d/rcS': No such file or directory
device '/dev/tty4' does not exist.
device '/dev/tty3' does not exist.
device '/dev/tty2' does not exist.

Please press Enter to activate this console.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.
device '/dev/tty2' does not exist.

Out of Memory: Killed process 1 (sh).
__alloc_pages: 0-order allocation failed.
VM: killing process sh
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
