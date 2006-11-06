Return-Path: <vantranbk@yahoo.com.au>
Received: from web33012.mail.mud.yahoo.com (web33012.mail.mud.yahoo.com
	[209.191.69.127]) by ozlabs.org (Postfix) with SMTP id 00F1767CE4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 01:26:06 +1100 (EST)
Message-ID: <20061106142604.14632.qmail@web33012.mail.mud.yahoo.com>
Date: Tue, 7 Nov 2006 01:26:04 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Ramdisk of ELDK 3.1.1 not run 
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1020816565-1162823164=:13541"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1020816565-1162823164=:13541
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi every one

I had used kernel of ELDK 3.1.1 and Ramdisk of ELDK 4.0 on board MPC8xxL .It run ok but I see it will meet trouble :D
When I use kernel and Ramdisk of ELDK 3.1.1 for MPC8xxL (I only rebuild Kernel use oldconfig and use uRamdisk in source (not rebuild )) but I receive error
////////////////////////////////////////////////////////////////////////////
Bootm 40040000 40400000 ## Booting image at 40040000 ...
   Image Name:   Linux-2.4.25
   Created:      2006-11-06  12:51:51 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    712087 Bytes = 695.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 40400000 ...
   Image Name:   Simple Embedded Linux Framework
   Created:      2005-06-07  12:59:15 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1625993 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00e1f000, end 00fabf89 ... OK
Linux version 2.4.25 (root@main) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-10)) #1 Mon Nov 6 19:50:02 ICT 2006

On node 0 totalpages: 4096

zone(0): 4096 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: 

Decrementer Frequency = 300000000/60

Calibrating delay loop... 79.66 BogoMIPS

Memory: 12912k available (1212k kernel code, 408k data, 56k init, 0k highmem)

Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)

Inode cache hash table entries: 1024 (order: 1, 8192 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)

Page-cache hash table entries: 4096 (order: 2, 16384 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.

CPM UART driver version 0.04

ttyS0 at 0x0280 is on SMC1 using BRG1

ttyS1 at 0x0380 is on SMC2 using BRG2

pty: 256 Unix98 ptys configured

Status LED driver $Revision: 1.0 $ initialized

eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:0e:7b:d2

eth1: FEC ENET Version 0.3, FEC irq 9, with MDIO, MII irq 12, addr 00:d0:93:0e:7b:d3

eth1: no PHY found - interface inoperative

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx

PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)

No card in slot B: PIPR=ff00ff00

TQM8xxL0: Found 2 x16 devices at 0x0 in 32-bit mode

TQM8xxL0: Found 2 x16 devices at 0x400000 in 32-bit mode

 Amd/Fujitsu Extended Query Table at 0x0040

number of CFI chips: 2

cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

TQM flash bank 0: Using static image partition definition

Creating 7 MTD partitions on "TQM8xxL0":

0x00000000-0x00040000 : "u-boot"

0x00040000-0x00100000 : "kernel"

0x00100000-0x00200000 : "user"

0x00200000-0x00400000 : "initrd"

0x00400000-0x00600000 : "cramfs"

0x00600000-0x00800000 : "jffs"

0x00400000-0x00800000 : "big_fs"

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 1024 bind 2048)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1587k freed

VFS: Mounted root (ext2 filesystem).

VFS: Cannot open root device "" or 00:00

Please append a correct "root=" boot option

Kernel panic: VFS: Unable to mount root fs on 00:00

 <0>Rebooting in 180 seconds..
///////////////////////////////////////////////////////////////////////////
What I miss?May i correct it 
I also build kernel Linux 2.6.11.7 use tosati patch and config ,but when I want this kernel support virtual terminal it hang.May I correct it?
Please help me 
Thanks
LeVan




 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1020816565-1162823164=:13541
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi every one<br><br>I had used kernel of ELDK 3.1.1 and Ramdisk of ELDK 4.0 on board MPC8xxL .It run ok but I see it will meet trouble :D<br>When I use kernel and Ramdisk of ELDK 3.1.1 for MPC8xxL (I only rebuild Kernel use oldconfig and use uRamdisk in source (not rebuild )) but I receive error<br>////////////////////////////////////////////////////////////////////////////<br>Bootm 40040000 40400000 ## Booting image at 40040000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.4.25<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-06&nbsp; 12:51:51 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 712087 Bytes = 695.4 kB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>## Loading RAMDisk Image at 40400000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp;
 Simple Embedded Linux Framework<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2005-06-07&nbsp; 12:59:15 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1625993 Bytes =&nbsp; 1.6 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 00e1f000, end 00fabf89 ... OK<br>Linux version 2.4.25 (root@main) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-10)) #1 Mon Nov 6 19:50:02 ICT 2006<br><br>On node 0 totalpages: 4096<br><br>zone(0): 4096 pages.<br><br>zone(1): 0 pages.<br><br>zone(2): 0 pages.<br><br>Kernel command line: <br><br>Decrementer Frequency = 300000000/60<br><br>Calibrating delay loop... 79.66 BogoMIPS<br><br>Memory: 12912k available (1212k kernel code, 408k data, 56k init, 0k highmem)<br><br>Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)<br><br>Inode cache
 hash table entries: 1024 (order: 1, 8192 bytes)<br><br>Mount cache hash table entries: 512 (order: 0, 4096 bytes)<br><br>Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)<br><br>Page-cache hash table entries: 4096 (order: 2, 16384 bytes)<br><br>POSIX conformance testing by UNIFIX<br><br>Linux NET4.0 for Linux 2.4<br><br>Based upon Swansea University Computer Society NET3.039<br><br>Initializing RT netlink socket<br><br>Starting kswapd<br><br>JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.<br><br>CPM UART driver version 0.04<br><br>ttyS0 at 0x0280 is on SMC1 using BRG1<br><br>ttyS1 at 0x0380 is on SMC2 using BRG2<br><br>pty: 256 Unix98 ptys configured<br><br>Status LED driver $Revision: 1.0 $ initialized<br><br>eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:0e:7b:d2<br><br>eth1: FEC ENET Version 0.3, FEC irq 9, with MDIO, MII irq 12, addr 00:d0:93:0e:7b:d3<br><br>eth1: no PHY found - interface inoperative<br><br>RAMDISK driver initialized: 16 RAM disks of 4096K size
 1024 blocksize<br><br>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4<br><br>ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx<br><br>PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)<br><br>No card in slot B: PIPR=ff00ff00<br><br>TQM8xxL0: Found 2 x16 devices at 0x0 in 32-bit mode<br><br>TQM8xxL0: Found 2 x16 devices at 0x400000 in 32-bit mode<br><br>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br><br>number of CFI chips: 2<br><br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br><br>TQM flash bank 0: Using static image partition definition<br><br>Creating 7 MTD partitions on "TQM8xxL0":<br><br>0x00000000-0x00040000 : "u-boot"<br><br>0x00040000-0x00100000 : "kernel"<br><br>0x00100000-0x00200000 : "user"<br><br>0x00200000-0x00400000 : "initrd"<br><br>0x00400000-0x00600000 : "cramfs"<br><br>0x00600000-0x00800000 : "jffs"<br><br>0x00400000-0x00800000 : "big_fs"<br><br>NET4: Linux TCP/IP 1.0 for
 NET4.0<br><br>IP Protocols: ICMP, UDP, TCP<br><br>IP: routing cache hash table of 512 buckets, 4Kbytes<br><br>TCP: Hash tables configured (established 1024 bind 2048)<br><br>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<br><br>RAMDISK: Compressed image found at block 0<br><br>Freeing initrd memory: 1587k freed<br><br>VFS: Mounted root (ext2 filesystem).<br><br>VFS: Cannot open root device "" or 00:00<br><br>Please append a correct "root=" boot option<br><br>Kernel panic: VFS: Unable to mount root fs on 00:00<br><br>&nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>///////////////////////////////////////////////////////////////////////////<br>What I miss?May i correct it <br>I also build kernel Linux 2.6.11.7 use tosati patch and config ,but when I want this kernel support virtual terminal it hang.May I correct it?<br>Please help me <br>Thanks<br>LeVan<br><br><br><br><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1020816565-1162823164=:13541--
