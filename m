Message-ID: <000801c216a3$e8fb5160$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel panic:I have no root and I want to scream
Date: Tue, 18 Jun 2002 16:41:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,
      When I boot my linux on fads board, I get a kernel panic:
I have no root and I want to scream, i do not the cause of this
probelm ,I add loop back surport,but can solve this problem!
Has anyone meet this problem ,can you give me some advice?
thank you in advance!



=>bootm 500000 600000
## Booting image at 00500000 ...
   Image Name:   2.4.18
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    557426 Bytes = 544 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00600000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    428 Bytes = 0 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0075b000, end 0075b1ac ... OK
Linux version 2.4.18 (root@gaof.guoguang.com.cn) (gcc version 2.95.2 19991024 (r
elease)) #2 Tue Jun 18 16:18:50 CST 2002
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: boot=/dev/ram
Decrementer Frequency = 180000000/60
console init finished!
alloc bootmem finished!
kmem_cache_init() finished!
Calibrating delay loop... 47.82 BogoMIPS
Memory: 6620k available (1012k kernel code, 364k data, 44k init, 0k highmem)
pgtable_cache_init() run here!
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 2048K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 0k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Kernel panic: I have no root and I want to scream
 <0>Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
