Message-ID: <3E944244.14ABBBCB@tataelxsi.co.in>
Date: Wed, 09 Apr 2003 21:24:44 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
Reply-To: shivam@tataelxsi.co.in
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: regarding Linux booting
References: <rt-580-2903.14.1928584236485@lineo.com> <3E769F7F.4188C8CC@tataelxsi.co.in> <3E911AEB.917583CD@tataelxsi.co.in> <3E92058F.1000805@metrowerks.com>
Content-Type: multipart/mixed;
 boundary="------------C47E13E749261E978FD01D37"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------C47E13E749261E978FD01D37
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

This question is about linux booting
why is my board hangs after printing the message
"Freeing unused kernel memory: 48k init"
i have attached complete log in this mail.

I also checked the function init() (linux/init/main.c) it's hanging
in execve("/sbin/init",argv_init,envp_init).

But the strange thing is if i debug through
execve() -> sys_execve() ->do_execve the control comes out of
do_execve() and sys_execve(). but it hangs after that don't know why ?

any hint ?
where is execve() function in LINUX code for PPC based board.

NOTE:
We are booting LINUX on custom board having MPC8260 processor.

regards
shiva
--------------C47E13E749261E978FD01D37
Content-Type: text/plain; charset=us-ascii;
 name="Our_Board.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Our_Board.txt"


## Booting image at 00100000 ...
   Image Name:   Embedix for MPC8260ADS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    517000 Bytes = 504.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
r4: 00000000
Total memory = 64MB; using 256kB for hash table (at c0180000)
Linux version 2.4.1 (root@shiva) (gcc version 2.95.3 20010315 (release)) #22 Mon
 Apr 7 05:50:39 UTC 2003
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsaddrs=10.1.20.250:10.1.40.175
Warning: real time clock seems stuck!
Calibrating delay loop... 87.85 BogoMIPS
Memory: 62636k available (944k kernel code, 476k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
1
2
3
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
MPC8260ADS rev. 0x8
MPC8260ADS sw opt: 0 1 0
old sypcr ffffffc3
new sypcr ffffffc3
hid0 = 0x0000c088
Starting kswapd v1.8
CPM UART driver version 0.01
ttyS00 at 0x8000 is a scc1
ttyS01 at 0x8100 is a scc2
block: queued sectors max/low 41546kB/13848kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
fec: Phy @ 0x0, type 0x001a2205
fec: Phy @ 0x1b, type 0x001a2205
setting half duplex
eth0: FCC ENET Version 0.2, 62:69:74:e5:6d:66 (10 Mbit, Half Duplex)
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
physmap flash device: 800000 at ff800000
cfi_probe()
Physically mapped flash: Found a CFI device at 0x0 in 16 bit mode
Invalid CFI ident structure.

cfi.chipsize is zero. This is bad. cfi.cfiq.DevSize is 0
Doesn't look like sharp flash, 0xffff0808 0xffffffff
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
IP-Config: Guessing netmask 255.0.0.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.1.40.175
Looking up port of RPC 100005/2 on 10.1.40.175
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 48k init

--------------C47E13E749261E978FD01D37--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
