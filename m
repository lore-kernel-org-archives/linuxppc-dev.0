From: Ruedi.Hofer@ascom.ch
Date: Tue, 24 Oct 2000 16:27:32 +0100 (CED)
Subject: SBC8260, kernel 2.4.0-test8, initrd
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G2X009AGV5CS2@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_54iBy9ObHGhKYOFeY3WKKA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_54iBy9ObHGhKYOFeY3WKKA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi,

I try to boot linux 2.4.0test8 on my sbc8260 with an initrd.

make zImage.initrd generates the appropriate file which I load
into my memory.

Unfortunately, I get the strange error below...

Any ideas???

\Ruedi




Starting at 0x400000...

CPU/CPM/BUS: 198/132/66 Mhz

Ethernet (in decimal): 0:160:30:1:4:5

loaded at:     00400000 0040B274
board data at: 00FFFFC0 00FFFFEC
relocated to:  00200100 0020012C
zimage at:     0040B274 00480312
initrd at:     00480312 00481408
avail ram:     00482000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test8 (root@linux01) (gcc version 2.95.2 19991030 (2.95.3 pr
erelease/franzo)) #27 Tue Oct 24 15:12:45 CEST 2000
Boot arguments: root=/dev/ram
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 14760k available (884k kernel code, 388k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.7
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: SCC ENET Version 0.1, 00:a0:1e:01:04:05
eth1: FCC ENET Version 0.2, 00:a0:1e:41:04:05
fec: Phy @ 0x1, type 0x010fd04b
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194300k freed
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.1.20.2, my address is 10.1.20.1
ip_conntrack (128 buckets, 1024 max)
kmem_create: Forcing size word alignment - nfs_fh
Kernel panic: VFS: Unable to mount root fs on 01:00
Rebooting in 180 seconds..

--Boundary_(ID_54iBy9ObHGhKYOFeY3WKKA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
