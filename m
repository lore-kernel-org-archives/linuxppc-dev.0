Message-ID: <000701c27f86$9a27a5b0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel panic
Date: Wed, 30 Oct 2002 01:36:00 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I am trying to build linux image with ramdisk and download to the PPC 440GP
evalkit. Earlier the filesystem was using nfs mount, now I hv builded a
zImage.initrd with ramdisk.image [I havent compressed the ramdisk image]. To
build the ramdisk, I used the procedure defined by HHL.. I defined the
ramdisk size as 8MB. However when I booted  with the image built. I am
getting a kernel panic error. I have pasted the output below.  One question
, how should we decide about the files to be loaded in ramdisk which will
be needed by  kernel image.

Thanking you in advance.
Regards
Aman


Loading file "zImage.initrd" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x1000000 ...
loaded at:     01000000 018821BC
zimage at:     01005950 0107E2C9
initrd at:     0107F000 0187F000
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/ram ramdisk_size=8192
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.17_mvl21-ebony (root@hardhat) (gcc version 2.95.3 20010315
(release/MontaVista)) #18 Tue Oct 29 19:28:19 IST 2002
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram ramdisk_size=8192
Calibrating delay loop... 599.65 BogoMIPS
Memory: 119264k available (876k kernel code, 344k data, 68k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1b:b5.
eth0: IBM EMAC: open completed
eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1b:b6.
eth1: IBM EMAC: open completed
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.13.242, my address is
192.168.13.246
IP-Config: Complete:
      device=eth0, addr=192.168.13.246, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.13.246, domain=, nis-domain=(none),
     bootserver=192.168.13.242, rootserver=192.168.13.242,
rootpath=/hdb/mountpt
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 8192 blocks [1 disk] into ram disk... done.
Freeing initrd memory: 8192k freed
Kernel panic: VFS: Unable to mount root fs on 01:00
 <0>Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
