Message-ID: <20020408202647.87548.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "Ying Lin" <ylin@mail.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 09 Apr 2002 04:26:47 +0800
Subject: MCP750 cannot type anything to bash
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting linux-2.4.7 to MCP750 board.  It booted fine and got bash prompt.  It cannot take anything I type form serial console.  So, I put agetty to inittab and it passed the command to bash.  Anyone has ideas what's wrong?  BTW, the same thing happened to me when porting to i386 system using serial console.

Thanks in advance.

Ying Lin


The follwoing is boot log.
Copyright Motorola Inc. 1988 - 2000, All Rights Reserved
PPC1 Debugger/Diagnostics Release Version 4.9 - 07/10/00 RM01
COLD Start
Local Memory Found =08000000 (&134217728)
MPU Clock Speed =367Mhz
BUS Clock Speed =67Mhz
Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE
L2Cache:       1024KB, 147Mhz
System Memory: 128MB, ECC Enabled (ECC-Memory Detected)
PPC1-Bug>nbo
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: zImage.initrd.prep
Client IP Address      = 150.21.30.210
Server IP Address      = 150.21.30.212
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage.initrd.prep
Argument File Name     =
Network Boot File load in progress... To abort hit <BREAK>
Bytes Received =&2510476, Bytes Loaded =&2510476
Bytes/Second   =&313809, Elapsed Time =8 Second(s)
Residual-Data Located at: $07F88000
loaded at:     00005400 00017218
relocated to:  00800000 00811E18
board data at: 07F88000 07F8EA0C
relocated to:  0080B30C 00811D18
zimage at:     0000D400 0009B231
relocated to:  00812000 0089FE31
initrd at:     0009B231 0026838B
relocated to:  008A0000 00A6D15A
avail ram:     00400000 00800000
Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Ramsize from residual data was 0 -- Probing for value
Ramsize default to be 32M
Total memory = 32MB; using 128kB for hash table (at c01a0000)
Linux version 2.4.7 (root@plymouth) (gcc version 2.95.3 20010315
(release)) #242PReP architecture
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
time_init: decrementer frequency = 16.666726 MHz
Calibrating delay loop... 732.36 BogoMIPS
Memory: 28636k available (1004k kernel code, 464k data, 100k init, 0k
highmem)  Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI:00:00.0 Resource 4 [ffffff00-ffffffff] is unassigned
PCI: device 00:06.0 has unknown header type 7f, ignoring.
PCI: device 00:07.0 has unknown header type 6f, ignoring.
PCI: device 00:0b.0 has unknown header type 7f, ignoring.
PCI:00:10.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:11.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:12.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:13.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:14.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:15.0 Resource 4 [ffff0000-ffffffff] is unassigned
PCI:00:16.0 Resource 4 [ffff0000-ffffffff] is unassigned
Memory resource not set for host bridge 0
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
PCI:00:00.0: Resource 3: 00fffffc-00ffffff (f=10f)
PCI:00:01.0: Resource 3: 0000fffc-0000ffff (f=10f)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI edttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 18938kB/6312kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1844k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 100k init 4k pmac 4k chrp 4k openfirmware
INIT: version 2.78 booting
INIT: Entering runlevel: 2            Starting Network
SIOCSIFADDR: No such device
eth0: unknown interface: No such device
SIOCSIFNETMASK: No such device
SIOCADDRT: No such device
lo        Link encap:Local Loopback
inet addr:127.0.0.1  Mask:255.0.0.0
UP LOOPBACK RUNNING  MTU:16436  Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
bash-2.04#
(none) login: ls
bin  dev  etc  lib  lost+found  proc  sbin  tmp  usr
bash-2.04#
(none) login: cat /etc/inittab
id:2:initdefault:
l2:2:wait:/etc/init.d/rcS
1:2345:respawn:/bin/bash
2:6:wait:/etc/init.d/umountfs
s0:2345:respawn:/sbin/agetty -h -t 30 ttyS0 9600 vt102
bash-2.04#
(none) login:

--

_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
