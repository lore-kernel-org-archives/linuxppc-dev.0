Message-ID: <3C2B09FA.93A61537@c-s.fr>
Date: Thu, 27 Dec 2001 12:46:02 +0100
From: "LEROY Christophe" <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: eth0: transmit timed out
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

It seems that the kernel cannot send on ethernet.
(transmit timed out).
What can be the source of such a problem ?

Thanks

C. Leroy



loaded at:     00410000 0041A58C
relocated to:  00300000 0030A58C
zimage at:     00417000 00482CDF
avail ram:     00483000 00800000

Linux/PPC load: nfsroot=/mcrlinux ip=192.168.2.50:192.168.2.51:::::
root=/dev/nfs
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.16 (root@localhost.localdomain) (gcc version 2.95.3
20010315 (release)) #209 jeu déc 27 10:09:34 CET 2001
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: nfsroot=/mcrlinux ip=192.168.2.50:192.168.2.51:::::
root=/dev/nfs
Decrementer Frequency = 150000000/60
Calibrating delay loop... 39.73 BogoMIPS
Memory: 6852k available (848k kernel code, 296k data, 44k init, 0k
highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
block: 64 slots per queue, batch=16
eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:01:00:17
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.2.50, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.2.50, domain=, nis-domain=(none),
     bootserver=192.168.2.51, rootserver=192.168.2.51, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.2.51
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx fa202950 (full) cur_rx fa202910.
dc00 002a 001fde42
dc00 002a 001fdec2
dc00 002a 001fdf42
dc00 002a 001f60d2
dc00 002a 001f6152
dc00 002a 001f61d2
dc00 002a 001f6252
fc00 002a 001f62d2
9000 0000 00168000
9000 0000 00168800
9000 0000 00167000
9000 0000 00167800
9000 0000 00166000
9000 0000 00166800
9000 0000 00165000
b000 0000 00165800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx fa202950 (full) cur_rx fa202910.
dc00 002a 001fde42
dc00 002a 001fdec2
dc00 002a 001fdf42
dc00 002a 001f60d2
dc00 002a 001f6152
dc00 002a 001f61d2
dc00 002a 001f6252
fc00 002a 001f62d2
9000 0000 00168000
9000 0000 00168800
9000 0000 00167000
9000 0000 00167800
9000 0000 00166000
9000 0000 00166800
9000 0000 00165000
b000 0000 00165800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx fa202950 (full) cur_rx fa202910.
dc00 002a 001fde42
dc00 002a 001fdec2
dc00 002a 001fdf42
dc00 002a 001f60d2
dc00 002a 001f6152
dc00 002a 001f61d2
dc00 002a 001f6252
fc00 002a 001f62d2
9000 0000 00168000
9000 0000 00168800
9000 0000 00167000
9000 0000 00167800
9000 0000 00166000
9000 0000 00166800
9000 0000 00165000
b000 0000 00165800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx fa202950 (full) cur_rx fa202910.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
