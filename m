Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <0509218DDAD7D6118055006008F6D5F6A1E39A@postal.viasat.com>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS root woes: No init found
Date: Fri, 6 Dec 2002 17:36:27 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having a problem with NFS mounting the root filesystem. It seems that
init
is not being executed. However, the problem may be with rootpath not being
set.
Should that parameter be set from the kernel command nfsroot=?



## Booting image at 00400000 ...
   Image Name:   Linux-2.4.19-pre6
   Created:      2002-12-06  17:44:09 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    901003 Bytes = 879 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.19-pre6 (cpagnotta@lb-deviant-linux) (gcc version 2.95.4
20010
319 (prerelease/franzo/20011204)) #8 Fri Dec 6 09:28:29 PST 2002
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=/tftpboot/powerpc-rootfs
ip=172.25.59
.11:172.25.59.15::255.255.0.0:vib::off
Calibrating delay loop... 263.78 BogoMIPS
Memory: 127092k available (1524k kernel code, 676k data, 212k init, 0k
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
devfs: v1.12 (20020219) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
ttyS02 at 0xf4100000 (irq = 26) is a ST16650V2
ttyS03 at 0xf4200000 (irq = 26) is a ST16650V2
PPC 405 watchdog driver v0.5
IBM gpio driver version 02.01.21.d
GPIO #0 at 0xc900d700
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type LXT971A (0x001378e2)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes
(simo
n@ncm.com)
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
NFTL driver: nftlcore.c $Revision: 1.85 $, nftlmount.c $Revision: 1.25 $
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Reset ethernet interfaces
eth0: IBM EMAC: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:60:c2:0a:00:1f.
eth0: IBM EMAC: open completed
IP-Config: Complete:
      device=eth0, addr=172.25.59.11, mask=255.255.0.0, gw=255.255.255.255,
     host=vib, domain=, nis-domain=(none),
     bootserver=172.25.59.15, rootserver=172.25.59.15, rootpath=
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.25.59.15
Looking up port of RPC 100005/1 on 172.25.59.15
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 212k init
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..<NULL>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
