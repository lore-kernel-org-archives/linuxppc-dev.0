Message-ID: <003301c0528f$d22d29b0$69f001dc@r44089-d1.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: kernel BUG at sched.c:656
Date: Mon, 20 Nov 2000 09:18:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I built the linux-2.4.0-test1 kernel on x86 platform,
the powerpc-linux-gcc version is 2.95.2,
the target board is MPC8260ADS-L2C board from Motorola.

What do this trace information mean?
Has the root file system mounted on RAM disk?

Thanks.

==========================================

Starting at: 0x400000

loaded at:     00400000 005C1274
board data at: 0001126C 00011290
relocated to:  003F0100 003F0124
zimage at:     0040A120 0047A8BF
initrd at:     0047A8BF 005BCE98
avail ram:     005FD000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test1 (sjzhu@Linux586.mcel.mot.com) (gcc version 2.95.2
1990
Boot arguments: root=/dev/ram
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Calibrating delay loop... 6.20 BogoMIPS
Memory: 13452k available (888k kernel code, 392k data, 36k init)
[c0000000,c100]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0xttyS03 at 0x8100 is a SCC
ttyS04 at 0x8200 is a SCC
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194301k freed
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem).
bad magic 0 (should be c045b2e0, creator 0), wq bug, forcing oops.
kernel BUG at sched.c:656!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
