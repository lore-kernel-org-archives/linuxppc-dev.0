Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B827@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: No bash prompt
Date: Wed, 12 Apr 2000 13:51:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

A got a similar problem as described by LiuTao, my custom MPC823 board won't
display the bash prompt at start up. Is there anybody who got a solution to
this problem?

I tried like LiuTao to define "SERIAL_DEBUG_INTR" in uart.c, and I got the
same result: Lots of "THRE...rs_interrupt_single(0, 2)...end." on the
console.
I have successfully used the ramdisk image on a RPXL board, so that should
be ok.

Here are the console messages:

loaded at:     00200000 0020B1F0
relocated to:  00100000 0010B1F0
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     00206000 002383D8
initrd at:     002383D8 002B2E77
avail ram:     002B3000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@LinuxDriverPC.infocom.dk) (gcc version 2.95.2
19991024 (release)) #74 Wed Apr 12 12:41:36 CEST 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.66 BogoMIPS
Memory: 7032k available (376k kernel code, 268k data, 24k init)
[c0000000,c0800000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: Compressed image found at block 0
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
THRE...rs_interrupt_single(0, 2)...end.
THRE...rs_interrupt_single(0, 2)...end.
THRE...rs_interrupt_single(0, 2)...end.


Hope someone can help.
Kim Jorgensen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
