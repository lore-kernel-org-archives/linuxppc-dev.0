Return-Path: <apoorvsangal@gmail.com>
Message-ID: <a7966936050719034139ed2c60@mail.gmail.com>
Date: Tue, 19 Jul 2005 16:11:30 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: vikrant_basotra@satyam.com, nishant_galange@satyam.com,
	apoorv_sangal@satyam.com
Subject: Problem in locating the file system while Linux bootup in 8260
	based board.
Reply-To: apoorv sangal <apoorvsangal@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
           I am porting linux2.4.24(which comes with ELDK) on mpc8260
based custom board.

I am using the JFFS2 flash file system which i had placed in the Flash
memory at 0xFC00_0000, but i couldn't find any variable or macro in
the code which i could set with the base address of the flash file
system.

this is what i am getting on the screen when i tried to bootup the Linux ..=
...
***************************************************************************=
*********
 ## Booting image at 02000000 ...
   Image Name:   2.4.24 MPC8260ADS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    706533 Bytes =3D 690 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb

Linux version 2.4.24-pre2 (satyam@pmcserver) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #10 Tue Jul 19 10:53:10
IST 2005

On node 0 totalpages: 32768

zone(0): 32768 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200 root=3D1f00

Warning: real time clock seems stuck!

Calibrating delay loop... 131.89 BogoMIPS

Memory: 127836k available (1224k kernel code, 404k data, 56k init, 0k highm=
em)

Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode cache hash table entries: 8192 (order: 4, 65536 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)

Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications =
AB.

Inside Chr_dev_init

i2c-core.o: i2c core module version 2.6.1 (20010830)

i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)

CPM UART driver version 0.01

ttyS0 on SMC1 at 0x0000, BRG7

ttyS1 on SMC2 at 0x0040, BRG8

ttyS2 on SCC1 at 0x8000, BRG1

ttyS3 on SCC2 at 0x8100, BRG2

Before return statement

Pty initialisation is complete

PPP generic driver version 2.4.2

PPP Deflate Compression module registered

PPP BSD Compression module registered

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 1024 buckets, 8Kbytes

TCP: Hash tables configured (established 8192 bind 16384)

ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack

ip_tables: (C) 2000-2002 Netfilter core team

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

NET4: Ethernet Bridge 008 for NET4.0

VFS: Cannot open root device "1f00" or 1f:00

Please append a correct "root=3D" boot option

Kernel panic: VFS: Unable to mount root fs on 1f:00

 <0>Rebooting in 180 seconds..
***************************************************************************=
*********

Also i couldn't find any file for the ads8260 board in the
drivers/mtd/maps folder.

can any one please throw some light....
waiting for response


Regards,
Apoorv Sangal
