From: mac21c@mail.suwon.ac.kr
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Bummer, can't open /dev/tty2
Message-ID: <971667729.39ea7911988cb@www.suwon.ac.kr>
Date: Mon, 16 Oct 2000 12:42:09 +0900
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

When i boot, i get this messag.
I write the initab file and list of /dev/tty?.

This problum hard on me for a week.

please help me...

Is this problum caused the busybox or kernel ??

maybe busybox....??

==================================================================
network Booting from: MPC860, Controller 20, Device 0
Loading: /tftpboot/zImage

Client IP Address      = 192.168.2.200
Server IP Address      = 192.168.2.86
Gateway IP Address     = 192.168.2.254
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /tftpboot/zImage
Argument File Name     =

Bytes Received =&481980, Bytes Loaded =&481980
Bytes/Second   =&240990, Elapsed Time =2 Second(s)
loaded at:     00210000 00203AA4
relocated to:  00100000 000F3AA4
board data at: 003F4558 003F4580
relocated to:  00200100 00200128
zimage at:     00217000 0027480F
avail ram:     00275000 00400000

Linux/PPC load: root=/dev/nfs nfsaddrs=192.168.2.200:192.168.2.86 nfsroot=192.16

8se press Enter to activate this console. error here 01
error here 01 open /dev/tty2
error here 01 open /dev/tty2
.2.86:/tftpboot
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@localhost.localdomain) (gcc version 2.95.2 19991024 (
release)) #18 ¤Ô¤¹¤Ô¤º 10¤Ô¤¹¤Ô¤º 16 11:27:52 KST 2000
Boot arguments: root=/dev/nfs nfsaddrs=192.168.2.200:192.168.2.86 nfsroot=192.16
8.2.86:/tftpboot
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.73 BogoMIPS
Memory: 3056k available (688k kernel code, 316k data, 36k init) [c0000000,c04000
00]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 4096 bhash 4096)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 08:00:3e:26:12:96
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
IP-Config: Guessing netmask 255.255.255.0
Looking up port of RPC 100003/2 on 192.168.2.86
Looking up port of RPC 100005/1 on 192.168.2.86
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 36k init
init started:  BusyBox v0.42 (20001014-1101) multi-call binary

Mounting /proc: done.
Bummer, can't open /dev/tty2

Please press Enter to activate this console.
Bummer, can't open /dev/tty2
Bummer, can't open /dev/tty2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
