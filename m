Message-ID: <389E2E66.F8DCDB66@m2tech.co.nz>
Date: Mon, 07 Feb 2000 15:31:03 +1300
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: question regarding shared library loading..
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello people..

here is my latest progress with the 4xx , and i am wondering if anyone
knows what the process of loading shared libraries inside ld.so.1
involves..

-------------
Linux version 2.3.42 (root@zone.m2) (gcc version egcs-2.91.66 19990314
(egcs-1.0
On node 0 totalpages: 00000400
zone(0): 1024 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 66.56 BogoMIPS
Memory: 2612k available (780k kernel code, 576k data, 44k init)
[c0000000,c0400000]
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
Starting kswapd v1.6
Serial driver version 4.92 (2000-1-27) with no serial options enabled
ttyS00 at 0xf3000000 (irq = 28) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: National DP83902AV at 00:04:ac:e3:09:c6, found at 0xc1000000,
using IRQ 27.
Looking up port of RPC 100003/2 on 10.0.0.240
Looking up port of RPC 100005/1 on 10.0.0.240
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 44k init
init: error in loading shared libraries libtermcap.so.2: cannot map file
data: No such device.
--------------

the nfs data shows it loading my bin/sh, loading in the ld.so.1,
searching and finding the libtermcap.so.2 and then hanging.. is this to
do with my serial console?? (which is so far working sweet??)

any help greatly appreciated!

cheers
ben


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
