Message-ID: <399D3FFE.ABA834F3@dgt-lab.com.pl>
Date: Fri, 18 Aug 2000 15:54:06 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: FADS problem
References: <200008171219.OAA03846@denx.local.net>
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


without ADI connector my FADS works a little bit better:

now sash displays info and hangs


......................................................................
entry 0x100000, phoff 0x34, shoff 0x72ad8
phnum 0x1, shnum 0x9
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x5308, p_memsz 0xb1d8
Loading at 0x10c000
Size 474019
463 blocks
Starting 0x11c000
loaded at:     0011C000 001271D8
Relocated to:  00100000 0010B1D8
Board Data at: 00BF0000 00BF001C
relocated to:  00200100 0020011C
Boot args at:  00200000 00200200
zimage at:     00122000 0017EA9B
avail ram:     0017F000 00C00000

Linux/PPC load:
Uncompressing Linux... done.
Now booting the kernel
Linux version 2.2.13 (root@cpiz_0) (gcc version 2.95.2 19991024
(release)) #16 Fri Aug 18 15:25:
34 CEST 2000
Boot arguments: root=/dev/nfs rw nfsaddrs=192.168.6.204:192.168.6.43
nfsroot=192.168.6.43:/LinuxPPC/root init=/bin/sh
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 11156k available (696k kernel code, 404k data, 32k init)
[c0000000,c0c00000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
IP-Config: Guessing netmask 255.255.255.0

<<<<<<<<<<now eth0 works (i can ping 192.168.6.204!)

Looking up port of RPC 100003/2 on 192.168.6.43
Looking up port of RPC 100005/1 on 192.168.6.43
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 32k init
Stand-alone shell (version 3.4)

Usage: sash [-a] [-q] [-c command] [-p prompt]

<<<<<<<<<<now it hangs (even ping dosen't work)

what is wrong?


--
* * * * * * * * * * * * *
* per pedes ad astra !  *
* * * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
