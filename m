Message-ID: <3E3FA6EC.7744EAE3@elektrobit.ch>
Date: Tue, 4 Feb 2003 12:41:33 +0100
From: Marcel Wattinger <marcel.wattinger@elektrobit.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Latest kernel running on EmbeddedPlanet CLLF
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've started building toolchain & kernel according to Craig Hollabaugh's
book
(my first complete toolchain/kernel build).

Building kernel 2.4.19 did not work at all?!? Now I've tried kernel
2.4.7 which
seems to have a problem with the on-board FEC. Mounting rootfs over eth0
works fine,
using eth1 (FEC) stops (see below). After a few minutes I get "eth1: tx
queue full!".
The onboard LED's for FEC do not flash at all!

My questions:
Which is the latest version combination which works for that board?
(version gcc, version kernel)
Do you have a hint how I get FEC running and mounting rootfs?
Starting the 2.4.19 kernel on the CLLF hangs just after the go command
of the cllf bootloader What could be wrong?


Thanks

Marcel




Linux/PPC load: console=ttyS0,115200 root=/dev/nfs
nfsaddrs=192.168.11.254:192.1
68.11.252:192.168.11.10:255.255.255.0:test:eth1:none
nfsroot=192.168.11.252:/tft
pboot/powerpc-rootfs,rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.7 (root@e10198l) (gcc version 2.95.3 20010315
(release)) #6 Tu
e Feb 4 02:35:14 CET 2003
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/nfs
nfsaddrs=192.168.11.254:
192.168.11.252:192.168.11.10:255.255.255.0:test:eth1:none
nfsroot=192.168.11.252
:/tftpboot/powerpc-rootfs,rw
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.86 BogoMIPS
Memory: 14768k available (920k kernel code, 336k data, 52k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9722kB/3240kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:38:7c
eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:10:ec:80:38:7c
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Complete:
      device=eth1, addr=192.168.11.254, mask=255.255.255.0,
gw=192.168.11.10,
     host=test, domain=, nis-domain=(none),
     bootserver=192.168.11.252, rootserver=192.168.11.252, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.11.252

--
_________________________________________________________
Elektrobit AG
Marcel Wattinger
Rosswiesstrasse 29
CH-8608 Bubikon

Phone :+41 (0)55 253 20 89
Fax   :+41 (0)55 253 20 70
mailto:marcel.wattinger@elektrobit.ch
http://www.elektrobit.ch/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
