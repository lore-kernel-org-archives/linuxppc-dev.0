Date: Sat, 14 Feb 2004 03:37:14 +0800
Message-Id: <200402140337.AA249168064@actinium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Arun Kumar" <arunkumar@actinium.org>
Reply-To: <arunkumar@actinium.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I could not get able to build the kernel due to this error as it was
stucking up for the console How can i resolve this.

But I do have /dev/console configured on my PC with 622 permissions and
5 1 as MAjor,Minor numbers for the character special file.

I used ELDK for the kernel.

IAD852T Boot Loader ROM for Linux, Version 0.1.0
Copyright(C) 2000,2001,2002 from Motorola
***************    ESDL   BEIJING   ***************
Build time: Tue Feb 10 17:08:56 MYT 2004
load from 0x281c118 to 0x400000, size=0x92328

Starting at: 0x400000

loaded at:     00400000 004961E4
board data at: 00011270 0001128C
relocated to:  003F0100 003F011C
zimage at:     004054D0 004910E6
initrd at:     004910E6 004910F2
avail ram:     004D2000 02000000

Linux/PPC load: root=/dev/nfs rw nfsroot=192.168.1.206:/ppcroot ip=192.168.1.43:
::::eth0:off
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.2_hhl20 (yewcc@yewcc.actinium) (gcc version 2.95.4 20010319 (p
rerelease/franzo/20011204)) #18 Tue Feb 10 17:08:31 MYT 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.206:/ppcroot ip=192.168.
1.43:::::eth0:off
Decrementer Frequency = 187500000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 49.56 BogoMIPS
Memory: 30548k available (1100k kernel code, 464k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
block: queued sectors max/low 20224kB/6741kB, 64 slots per queue
eth0: CPM ENET Version 0.2 on SCC4, 08:00:3e:58:15:60
eth1: FEC ENET Version 0.2, FEC irq 3, addr 08:00:3e:d8:15:60
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Physically mapped flash: Found 2 x16 CFI devices at location 0 in 16 bit mode
 Amd/Fujitsu Extended Query Table v1.1 at 0x0040
Physically mapped flash: Swapping erase regions for broken CFI table.
number of CFI chips: 1
mtd: Giving out device 0 to primary boot loader partition
mtd: Giving out device 1 to RSU partition 1
mtd: Giving out device 2 to CFG main partition
mtd: Giving out device 3 to CFG secondary partition
mtd: Giving out device 4 to RSU partition 2
CPM SPI Driver: $Revision: 1.1 $ wg@denx.de
rxbuf = 0xc01a0118 tx_buf = 0xc01a0108
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
IP-Config: Guessing netmask 255.255.255.0
ip_conntrack (256 buckets, 2048 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.206
Looking up port of RPC 100005/2 on 192.168.1.206
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init 4k openfirmware
Warning: unable to open an initial console.

It is coming here and stucking up how can I resolve this please tell me
in detail.

Thanks in advance,
Arunkumar.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
