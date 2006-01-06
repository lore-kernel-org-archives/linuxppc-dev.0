Return-Path: <maj1224@yahoo.com>
Received: from web33501.mail.mud.yahoo.com (web33501.mail.mud.yahoo.com
	[68.142.206.150]) by ozlabs.org (Postfix) with SMTP id C6D0B689D7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 08:19:04 +1100 (EST)
Message-ID: <20060106211902.77247.qmail@web33501.mail.mud.yahoo.com>
Date: Fri, 6 Jan 2006 13:19:02 -0800 (PST)
From: Matt Jerdonek <maj1224@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Booting from RAM Disk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've got a custom 852T board, similar to an AdderII. 
I've got the board booting linux fine using NFS.  Now
I'm trying to get it to work stand-alone, and I can't
get it to boot from a RAM disk.  I'm using the 2.4.25
kernel from Denx, and the Ramdisk image from the ELDK
(ppc_8xx/images/ramdisk.image.gz).

Below is the output I'm getting.  The "MAJ" tags
indicate printk's that were inserted by me.  If anyone
has a clue to what I'm doing wrong, I'd appreciate it.

Thanks,
-- Matt

loaded at:     00380000 005C1218
board data at: 01FFFEF8 01FFFF48
relocated to:  003852FC 0038534C
zimage at:     00385848 00431C28
initrd at:     00432000 005BD040
avail ram:     005C2000 02000000

Linux/PPC load: root=/dev/ram rw ip=192.168.0.6
console=ttyS0,115200
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.25 (matt@debian) (gcc version 3.3.3
(DENX ELDK 3.1.1 3.3.3-9)) #5 Fri Jan 6 13:58:44 MST
2006
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw ip=192.168.0.6
console=ttyS0,115200
Decrementer Frequency = 186624000/60
Calibrating delay loop... 49.56 BogoMIPS
Memory: 29164k available (1204k kernel code, 364k
data, 56k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768
bytes)
Inode cache hash table entries: 2048 (order: 2, 16384
bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0200 is on SCC3 using BRG2
pty: 256 Unix98 ptys configured
eth0: FEC ENET Version 0.3, FEC irq 3, addr
08:00:3e:28:7a:ba
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind
4096)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.0.6,
mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.0.6, domain=, nis-domain=(none),
     bootserver=255.255.255.255,
rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1580k freed
MAJ: initrd_load returns 1
MAJ: In mount_root
MAJ: devfs_make_root name = ram
MAJ: create_dev returns 0
MAJ: mount_block_root fs_name = jffs2
Kernel panic: VFS: Unable to mount root fs on 01:00
 <0>Rebooting in 180 seconds..                        
     


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 
