Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010711134520.31259.qmail@web14202.mail.yahoo.com>
Date: Wed, 11 Jul 2001 06:45:20 -0700 (PDT)
From: Brian Boerner <bboerner@yahoo.com>
Subject: libc.so.6: cannot open shared object file: No such file or directory
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


IBM Walnut 405GP. Linux is MontaVista
linuxppc-2.5.405, which looks like a 2.4.2 kernel.

I've searched the archives and either I'm not very
efficient at navigating them, or I couldn't find
anything that helped out.

I did see one post mentioning that you needed a
symbolic link from the hardhat devkit to /. I was a
bit unclear on this and didn't see anything about this
in the mvista cdk documentation. I may have missed it,
anything is possible at this point.

Does anyone have any idea why init is being killed
off? It complains libc.so.6 isn't being found? It's
certainly in the ramdisk. I'm sure folks have run into
this before.

Checking memory address: 02000000
  System RAM check complete

EMAC0 Ethernet Test OK.
Serial Port 2 [S2] test complete - TEST PASSED
ENET Speed is 100 Mbs...
HALF duplex connection
Booting from [ENET] Ethernet     ...
Sending bootp request ...


Loading file "vmlinux.img" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x200000 ...
Initial RAM disk at 0x01db0000 (?  bytes)
Linux version 2.4.2 (bmb@linuxdev) (gcc version 2.95.2
19991030 (2.95.3 prerelease/franzo)) #17 Wed Jul 11
09:37:21 EDT 2001
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
time_init: decrementer frequency = 499999980/60
Warning: real time clock seems stuck!
Calibrating delay loop... 199.47 BogoMIPS
Memory: 28212k available (1052k kernel code, 472k
data, 56k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384
bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 18669kB/6223kB, 64 slots
per queue
RAMDISK driver initialized: 16 RAM disks of 12288K
size 1024 blocksize
loop: enabling 8 loop devices
eth0: PPC405 EMAC 100 Mbs Half duplex MAC
00:04:ac:e3:12:38
RAMDISK: Compressed image found at block 0
Serial driver version 5.02 (2000-08-09) with
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind
2048)
Reset ethernet interfaces
eth0: PPC405 Enet open completed
IP-Config: Incomplete network configuration
information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BMB: handle is null
EXT2-fs warning: checktime reached, running e2fsck is
recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init 4k openfirmware
Kernel panic: Attempted to kill init!
init: error in loading shared libraries: libc.so.6:
cannot open shared object file: No such file or
directory
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
