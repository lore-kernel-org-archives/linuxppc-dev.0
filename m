Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "aa aaa" <linux_powerpc@hotmail.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: how to solve the problem!!
Date: Sun, 23 May 2004 09:15:02 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY13-F27y1LuihVliK00020d6e@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have created jffs2 ,run flash_self:
the message is flowing:ot>run flash_self
Unknown command 'root=/dev/mtdblock3' - try 'help'
## Booting image at ff080000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    715065 Bytes = 698.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.18_mvl30-rpxlite (root@localhost.localdomain) (gcc
version 3.2.1 20020930 (MontaVista)) #1  Áù 5ÔÂ 22 19:44:39 CST 2004
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/mtdblock3
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 62828k available (1244k kernel code, 368k data, 52k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
Journalled Block Device driver loaded
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications AB.
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5b
loop: loaded (max 8 devices)
RPX Lite or CLLF flash device: 1000000 at ff000000
 Amd/Fujitsu Extended Query Table v1.2 at 0x0040
number of CFI chips: 1
Creating 3 MTD partitions on "RPX":
0x00000000-0x00080000 : "UBOOT partition"
0x00080000-0x00200000 : "KERNEL partition"
0x00200000-0x01000000 : "JFFS2  partition"
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
jffs_scan_flash(): Did not find even a single chunk of free space. This is
BAD!
jffs_scan_falsh():Free size accounting screwed
jfffs_scan_flash():free_chunk_size1 == 0xe00000, free_chunk_size2 == 0x0,
fmc->free_size == 0x0
JFFS: Failed to mount device 1f:03.
jffs2_scan_empty(): Empty block at 0x0000fffc ends at 0x00010000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0001fffc ends at 0x00020000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0002ffec ends at 0x00030000 (with
0x1985e001)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0004ff90 ends at 0x00050000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0005fffc ends at 0x00060000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0006fffc ends at 0x00070000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0008fffc ends at 0x00090000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0009fffc ends at 0x000a0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x000afffc ends at 0x000b0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x000cfffc ends at 0x000d0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x000dfffc ends at 0x000e0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x000efffc ends at 0x000f0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0010fffc ends at 0x00110000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0011fffc ends at 0x00120000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0012fffc ends at 0x00130000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0014fffc ends at 0x00150000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x0019fffc ends at 0x001a0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x001afffc ends at 0x001b0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x001cfffc ends at 0x001d0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x001dfffc ends at 0x001e0000 (with
0x1985e002)! Marking dirty
jffs2_scan_empty(): Empty block at 0x001efffc ends at 0x001f0000 (with
0x1985e002)! Marking dirty
VFS: Mounted root (jffs2 filesystem) readonly.
Freeing unused kernel memory: 52k init
Warning: unable to open an initial console.

This is why?

Best regards!!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
