Subject: Bizarre initrd problem on CLLF860T
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Mon, 17 Apr 2000 17:02:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000417070226.92BE33C961@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I'm wondering if anyone could please give me a pointer on the following
problem I'm having: A couple of months ago when I last tried booting one of
our CLLF860T boards with an initrd, it all worked fine -- no drama. Figuring
that this hurdle was conquered, I haven't tried again until today, as we're
happily NFS mounting the root filesystem for development.

Today though, I can't for the life of me work out why the initrd stuff isn't
working. The log messages tell me that it's trying to mount the root filesystem
*twice*, and the second attempt fails with a panic. I've been banging my head
against this all afternoon to no avail; any suggestions?

I'm using Dan's 2.2.13-derived kernel; here are the boot messages:

loaded at:     00200000 0020C580
relocated to:  00100000 0010C580
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     00207000 00266B05
initrd at:     00266B05 00332154
avail ram:     00333000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (greyham@brixi) (gcc version 2.95.2 19991024 (release)) #55
 Mon Apr 17 16:53:24T 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 14352k available (728k kernel code, 452k data, 32k init) [c0000000,c1000
000]
DENTRY hash tas: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.1.1.1
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: FEC ENET Version 0.1, 00:10:ec:00:0d:3b
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline regid.
fec: Phy @ 0x17, type 0x01814401
fec: link down
fec: 100 Mbps, Half-Duplex
Sending BOOTP requests..... OK
IP-Config: Got BOOTP answer from 10.2.2.90, my address is 10.2.0.21
IP-Config: Guessing netmask 255.0.0.0
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem)
VFS: Cannot open root device 00:00
Kernel panic: VFS: Unable to mount root fs on 00:00
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU Emulation
Rebooting in 180 seconds..

Any help greatly appreciated,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
