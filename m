Message-ID: <79A8E184F948A54C9BA8A3DDB7DE6E2813C308@SELTATOR>
From: Andreani Luca <landreani@seltatel.it>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: problems with ramdisk (RAMDISK: Compressed image found at block 0
	)
Date: Wed, 5 Feb 2003 10:08:04 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello list,

I'm developing a system based on the Motorola Sandpoint III with HardHat
linux 2.0.
Till now I used the nfs on my pc without any problems.
Now I need to use a ramdisk, I created it but it doesn't start and the
booting process is interrupted.
Below you can find the output from my console. Any idea?

Thanks

Luca Andreani

Linux/PPC load: console=ttyS0,9600 console=tty
nfsroot=192.168.1.1:/opt/VGWRouter/ifs ip=192.168.1.2  console=ttyS0,9600
root=/dev/ram mem=62M
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.17_mvl21-sandpoint (root@localhost.localdomain) (gcc
version 2.95.3 20010315 (release/MontaVista)) #18 Tue Feb 4 17:17:20 CET
2003
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty
nfsroot=192.168.1.1:/opt/VGWRouter/ifs ip=192.168.1.2  console=ttyS0,9600
root=/dev/ram mem=62M
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
OpenPIC timer frequency is 100.000000 MHz
time_init: decrementer frequency = 24.752778 MHz
Calibrating delay loop... 197.83 BogoMIPS
Memory: 23644k available (1160k kernel code, 460k data, 212k init, 0k
highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
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
ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
ttyS01 at 0xfe0002f8 (irq = 3) is a 16550A
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 25600K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller on PCI bus 00 dev 59
W82C105: chipset revision 5
W82C105: 100% native mode on irq 16
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings: hdc:DMA, hdd:DMA
loop: loaded (max 8 devices)
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.13, Oct 19, 2001  Jeff
Garzik, Tjeerd Mulder)
eth0: NatSemi DP8381[56] at 0xc300d000, 08:00:17:0b:65:e0, IRQ 21.
eth0: Transceiver status 0x7869 advertising 05e1.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
HDLC support module revision 1.08
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
GRE over IPv4 tunneling driver
eth0: link is back. Enabling watchdog.
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.1.2, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.1.2, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
ip_conntrack (256 buckets, 2048 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
