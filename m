From: Dave Pegler <dwp@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14965.21248.134554.779605@gargle.gargle.HOWL>
Date: Mon, 29 Jan 2001 11:24:48 +0000 (GMT)
To: Leonard Ye <leonardye@xoommail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: is kernel 2.4.0 working for (F)ADS 8xx?
In-Reply-To: <200101271009.CAA30644@xoommail.com>
References: <200101271009.CAA30644@xoommail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Leonard,

Leonard Ye writes:
 >
 > hi,
 >
 > Has anyone get kernel 2.4.0 working for (F)ADS 8xx board?  I need some
 > network features that cannot be supported by kernel 2.2.13.
 >

I managed to get linux-2.4.0-test2-1.2.0-1 working on a FADS with an
860T (E0 silicon). Unfortunately, I can't seem to get it past
requesting a run level :

loaded at:     00200000 0020B1D4
relocated to:  00180000 0018B1D4
board data at: 001801B8 001801D4
relocated to:  00200100 0020011C
zimage at:     00206000 0027665F
avail ram:     00277000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.0-test2 (dan@geefour.netx4.com) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #1
Fri Dec 22 18:27:53 EST 2000
Boot arguments: root=/dev/nfs rw
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.83 BogoMIPS
Memory: 6676k available (864k kernel code, 428k data, 48k init) [c0000000,c0800000]
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
Starting kswapd v1.6
i2c-core.o: i2c core module
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.0.0.19, my address is 10.0.0.12
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 10.0.0.19
Looking up port of RPC 100005/2 on 10.0.0.19
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
tty_io.c: process 1 (swapper) used obsolete /dev/cua - update software to use /dev/ttyS0
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyÿ
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0
INIT: tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0
version 2.77 booti.tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0

Enter runlevel:


Thanks,

Dave.
 > Regards,
 > Leonard Ye
 >
 >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
