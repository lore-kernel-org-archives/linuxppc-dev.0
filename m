From: "labblelabble" <labblelabble@hotmail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: different ramdisk problem? ramdisk is too big?
Date: Mon, 15 Mar 2004 08:43:54 +0800
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <BAY8-DAV361d30vuGsN00028205@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone:
    I made my own RAMDISK.the initial filesystem size is 35M,and be 13M
after imaged and gziped .and I compiled the linux kernel for RAMDISK SIZE
40M.But the following is the problems found in the ramdisk. ANY superman
could give me some adivice ,what wrong with my system?????
    thanks alot!!!!!!]

u-boot>run flash_self
## Booting image at fc000000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    738735 Bytes = 721.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at fe000000 ...
   Image Name:   dmt
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    13716272 Bytes = 13.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0322a000, end 03f3eb30 ... OK
Linux version 2.4.18_mvl30-rpxlite (root@sgj) (gcc version 3.2.1 20020930
(MontaVista)) #1 Sun Mar 14 19:58:18 CST 2004
USB uCode patch installed
rpxfb: allocated 75 pages for frame buffer
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=tty0 console=ttyS0,9600 root=/dev/ram rw
ip=172.16.115.12:172.16.115.5:172.16.115.254:255.255.255.0::eth0:off panic=1
Decrementer Frequency = 180000000/60
Console: colour dummy device 80x25
Calibrating delay loop... 47.82 BogoMIPS
Memory: 49008k available (1268k kernel code, 448k data, 76k init, 0k
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
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications AB.
Console: switching to colour frame buffer device 80x30
fb0: RPX LCD frame buffer device
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG2
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 40960K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5c
loop: loaded (max 8 devices)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
usb.c: new USB bus registered, assigned bus number 1
m8xxhci: part 24, mask 1
m8xxhci: MPC823eB2
hub.c: USB hub found
hub.c: 1 port detected
m8xxhci: initializing done
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver keyboard
usbkbd.c: :USB HID Boot Protocol keyboard driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IP-Config: Complete:
      device=eth0, addr=172.16.115.12, mask=255.255.255.0,
gw=172.16.115.254,
     host=172.16.115.12, domain=, nis-domain=(none),
     bootserver=172.16.115.5, rootserver=172.16.115.5, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 13394k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k init
Usage: ping [-LRUbdfnqrvVaA] [-c count] [-i interval] [-w deadline]
hub.c: USB new device connect on bus1/1, assigned device number 2
            [-p pattern] [-s packetsize] [-t ttl] [-I interface orhub.c: USB
hub found
 address]
            [-M mtu discovery hihub.c: 4 ports detected
nt] [-S sndbuf]
            [ -T timestamp option ] [ -Q tos ] [hop1 ...] destination
Kernel panic: Attempted to kill init!
 <0>Rebooting in 1 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
