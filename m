Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01139FC052A0D411900B00508B9535FC046CE1DA@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: problems about the FEC on my cutomized mpc860 board
Date: Mon, 24 Dec 2001 12:08:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
I used the FEC driver from Wolf's ppc linux as a start point.
The board is a mpc 860 based board. And the PHY on the board doesn't support MDIO.
So I undefined the macro 'CONFIG_USE_MDIO'.
Also there is no link interrupt for the board. So I undefined the 'mii_queue_*' series.
That means the PHY on my board is just a 'transceiver',
But the resulted driver didn't work. When I look thrugh the /proc/interrupts,
the interrupt for FEC ( IRQ 3) is there. I wonder what is the problem?
Below is the output of the start-up information:

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.2 (rolf@icebox) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #162 Mon Dec 24 11:34:03 EST 2001
Boot arguments: root=/dev/ram
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
time_init: decrementer frequency = 187500000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 49.76 BogoMIPS
Memory: 29640k available (904k kernel code, 348k data, 40k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
block: queued sectors max/low 19597kB/6532kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FEC ENET Version 0.2, FEC irq 3, addr 00:10:ec:00:1d:0b
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1237k freed
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 40k init

INIT: version 2.74 booting
We will not activate swap partitions
hostname: Linux823MTP.mcel.mot.com
Remounting root filesystem in read-write mode.
Mounting local filesystems.
Initializing random number generator...

INIT: Entering runlevel: 3
SIOCSIFADDR: No such device
fec: unknown interface: No such device
SIOCSIFNETMASK: No such device
SIOCSIFBRDADDR: No such device
fec: unknown interface: No such device
SIOCADDRT: No such device
Mounting remote filesystems.

Thanks for your suggestions
Rolf Liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
