Return-Path: <rza1@so-logic.co.at>
Received: from webmail.so-logic.net (webmail.so-logic.net [62.99.208.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94AB867B17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 22:56:15 +1000 (EST)
Received: from webmail.so-logic.net (webmail.so-logic.net [62.99.208.151])
	by webmail.so-logic.net (8.12.10/8.12.8) with ESMTP id k5SCEQF7039729
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 14:14:26 +0200 (CEST)
	(envelope-from rza1@so-logic.co.at)
Message-Id: <200606281214.k5SCEQEf039728@webmail.so-logic.net>
From: "Robert Zach" <rza1@so-logic.co.at>
To: linuxppc-embedded@ozlabs.org
Subject: no login prompt with ml403 + uartlite-->major numbers?
Date: Wed, 28 Jun 2006 14:14:26 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello! 

I use the "Standart" ml403 Design with the uartlite instead of the 
uart16550... 

my kernel parameters are:
"console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw" 

It boots correctly, but i got no login prompt!!
getty is started with init.
my inittab looks like:
...
::respawn:/sbin/getty 9600 ttl0
... 

I use devfs. 


Is the inittab entry correct?
Which device is the uartlite in devfs? 

Which major numbers uses the uartlite? 

thanks in advanced!
nice greetings,
Robert Zach 

 


loaded at:     00400000 004CC1E0
board data at: 004C9138 004C9150
relocated to:  0040530C 00405324
zimage at:     004058D1 004C885F
avail ram:     004CD000 04000000 

Linux/PPC load: console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.26 (sem03@escola06) (gcc version 3.4.1) #3 Wed Jun 28 
13:19:30
CEST 2006
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. 
(source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 299.82 BogoMIPS
Memory: 62884k available (1420k kernel code, 400k data, 56k init, 0k 
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Partition check:
xsysacea: p1 p2 p3
System ACE at 0x41800000 mapped to 0xC5000000, irq=28, 500472KB
eth0: using fifo mode.
eth0: No PHY detected.  Assuming a PHY at address 0.
eth0: Xilinx EMAC #0 at 0x40C00000 mapped to 0xC5013000, irq=31
eth0: id 2.0h; block id 7, type 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on System ACE(254,3), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 56k init 

XDS ML403 powerpc linux 2.4.26 Training 

Starting system...
Starting Network
Start syslogd
done.
Start klogd
done.
System Started.
eth0: Link carrier lost.
