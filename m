From: "Kim, Jin Young" <jykim@ce.cnu.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel stuck when decompress initrd
Date: Wed, 21 Jun 2000 22:15:02 +0900
Message-ID: <NEBBLJBIIKANNNOGGKNDGEKJCAAA.jykim@raonet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to run LINUX 2.3.99 image on SBC8260 boards.

The kernel stopped after showing following messages on console.
I'm really novice to LINUX, so only debugging way is printk.
I found the kernel stopped in flush_window() in drivers/block/rd.c.
It is in the middle of gunzip() procedure.
Any idea?  Something wrong in the sequence?
I'm using vWARE boot rom from EST to boot LINUX.
I tried to boot LINUX from FLASH SIMM on the board(it is 0xe0100000),
but worse than from RAM. it only shows first boot loader messages.

Regards,
Jin
jykim@raonet.com

========================
loaded at:     00400000 0040C274
board data at: 00100000 0010002C
relocated to:  00200100 0020012C
zimage at:     0040D000 0047A105
initrd at:     0047B000 00653A15
avail ram:     00654000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test1-ac21 (jykim@raonet.com) (gcc version 2.95.2 19991024 (release)) #176 ¼ö 6¿ù 21 21:57:00 KST 2000
PowerPC Architecture (id:0x810101)
Boot arguments: root=/dev/ram
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Calibrating delay loop... 166.30 BogoMIPS
Memory: 12824k available (824k kernel code, 464k data, 40k init) [c0000000,c1000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
kmem_create: Poisoning requested, but con given - file lock cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
ttyS03 at 0x8200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: SCC ENET Version 0.1, 08:00:3e:26:15:59
RAMDISK: Compressed image found at block 0

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
