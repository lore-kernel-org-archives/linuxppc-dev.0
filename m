Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCE8E@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem during NFS mounting
Date: Thu, 26 Jul 2001 08:37:15 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'v tried to mount root on an NFS server.
Everything seems to be OK, but sometimes I get an error FEC ERROR 4f200000.
After this happens, I'm not able to get the ethernet working.

I'm using the 2.4.4 Kernel downloaded form denx.

Here is the output including the error messages at the end.

## Booting image at 40100000 ...
   Image Name:   2.4.4 for initrd on COM660
   Created:      2001-07-26  12:09:15 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    553832 Bytes = 540 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.4 (root@ran-248-123.ran.harris.com) (gcc version 2.95.2 199910
24 (release)) #57 Thu Jul 26 14:02:04 CEST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=137.237.248.123:/LinuxPPC nfsaddrs
=172.16.0.10:137.237.248.123:172.16.0.1:255.255.0.0:COM660::off
172.16.0.10:137.237.248.123:172.16.0.1:255.255.0.0:COM660::off
IP-Config: Parameter #0: `172.16.0.10'
IP-Config: Parameter #1: `137.237.248.123'
IP-Config: Parameter #2: `172.16.0.1'
IP-Config: Parameter #3: `255.255.0.0'
IP-Config: Parameter #4: `COM660'
IP-Config: Parameter #6: `off'
Decrementer Frequency: 3125000
Calibrating delay loop... 49.86 BogoMIPS
Memory: 14532k available (1064k kernel code, 432k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9573kB/3191kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FEC ENET Version 0.2, FEC irq 3, addr 00:d0:26:00:47:05
eth0: Phy @ 0x1, type DP83846 (0x20005c20)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Entered.
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: Opened eth0 (able=0)
IP-Config: device=eth0, local=ac10000a, server=89edf87b, boot=89edf87b, gw=ac100
001, mask=ffff0000
IP-Config: host=COM660, domain=(none), path=`'
ip_conntrack (128 buckets, 1024 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 137.237.248.123
Looking up port of RPC 100005/2 on 137.237.248.123
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init

FEC ERROR 4f200000
FEC ENET: rcv is not +last
nfs: server 137.237.248.123 not responding, still trying
nfs: server 137.237.248.123 not responding, still trying
FEC ERROR 41200000
FEC ENET: rcv is not +last
nfs: task 19 can't get a request slot
nfs: task 20 can't get a request slot
nfs: task 21 can't get a request slot
nfs: task 22 can't get a request slot
nfs: task 23 can't get a request slot


Thank you for your help,
Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
