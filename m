Message-ID: <001901c28683$83ad5dd0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Error: Oops: kernel access of bad area, sig: 11
Date: Thu, 7 Nov 2002 23:01:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

Earlier I was getting error "EXT2-fs error (device ramdisk(1,0)):
ext2_check_page: bad entry in directory #20: unaligned directory entry -
offset=0, inode=4294967295, rec_len=65535, name_len=255". Now if I change
the ram size from 8MB to 6MB , I am getting different error. Below is the
console output.

Earlier I used to get an error "Warning: unable to open an initial console."
which is not coming after I changed the ram disk size.

Can anyone help me in solving this issue.

Thanking you in advance
Regards
Aman

->
loaded at:     01000000 0124F1BC
zimage at:     01005970 010829EB
initrd at:     01083000 0124B43F
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/ram0 ramdisk_size=6144
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.17_mvl21-ebony (root@hardhat) (gcc version 2.95.3 20010315
(release/MontaVista)) #192 Thu Nov 7 15:39:49 IST 2002
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 ramdisk_size=6144
Warning: real time clock seems stuck!
Calibrating delay loop... 599.65 BogoMIPS
Memory: 125588k available (908k kernel code, 352k data, 68k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Got bad Phy Read, missing MDIO pullup?
eth0: No PHY device found.
removing net dev
eth0: Got bad Phy Read, missing MDIO pullup?
eth0: No PHY device found.
removing net dev
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
RAMDISK GZIP ALLOCATED
GZIP WINDOW ALLOCATED
Freeing initrd memory: 1825k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 68k initFreeing done

We are going to open the serial console
Kernel panic: No init found.  Try passing init= option to kernel.
Oops: kernel access of bad area, sig: 11
NIP: C000E670 XER: 00000000 LR: C000E664 SP: C0397E50 REGS: c0397d90 TRAP:
0800    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0396000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C7B851CC C0397E50 C0396000 00000001 00009030 00000000 C0397E94
C0120000
GPR08: 00000AF0 C0397E90 00000000 0BE22EDF 22F42F24 00000000 00000000
00000FA0
GPR16: 00000000 FFFC37BD 00000000 00000000 00001032 00000005 C0120000
00000000
GPR24: 00000000 0000001D C0110000 00000002 C7B851C8 C0397E88 C0396000
C7B85180
Call backtrace:
C0397E68 C003670C C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8
C000FEA8 C000167C C0003C98
Kernel panic: Attempted to kill init!
Oops: kernel access of bad area, sig: 11
NIP: C000E670 XER: 00000000 LR: C000E664 SP: C0397AE0 REGS: c0397a20 TRAP:
0800    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0396000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C7B851CC C0397AE0 C0396000 00000001 00009030 00000000 C0397B24
C0120000
GPR08: 00000DFA C0397B20 00000000 0BE22EDF 24F42F24 00000000 00000000
00000FA0
GPR16: 00000000 FFFC37BD 00000000 00000000 00001032 C0397D80 00000000
C0001914
GPR24: 00800000 00800000 C0110000 00000002 C7B851C8 C0397B18 C0396000
C7B85180
Call backtrace:
C0397AF8 C003670C C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8
C000FEA8 C0013FE0 C0001AB0 C000ACF8 C000AB7C C0001914 C0397E68
C003670C C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8 C000FEA8
C000167C C0003C98
Kernel panic: Attempted to kill init!
Oops: kernel access of bad area, sig: 11
NIP: C000E670 XER: 00000000 LR: C000E664 SP: C0397770 REGS: c03976b0 TRAP:
0800    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0396000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C7B851CC C0397770 C0396000 00000001 00009030 00000000 C03977B4
C0120000
GPR08: 00001181 C03977B0 00000000 0BE22EDF 24F42F24 00000000 00000000
00000FA0
GPR16: 00000000 FFFC37BD 00000000 00000000 00001032 C0397A10 00000000
C0001914
GPR24: 00800000 00800000 C0110000 00000002 C7B851C8 C03977A8 C0396000
C7B85180
Call backtrace:
C0397788 C003670C C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8
C000FEA8 C0013FE0 C0001AB0 C000ACF8 C000AB7C C0001914 C0397AF8
C003670C C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8 C000FEA8
C0013FE0 C0001AB0 C000ACF8 C000AB7C C0001914 C0397E68 C003670C
C0036A6C C0036AE0 C0036B54 C0036CA0 C0036CE8
Kernel panic: Attempted to kill init!
Oops: kernel access of bad area, sig: 11
NIP: C000E670 XER: 00000000 LR: C000E664 SP: C0397400 REGS: c0397340 TRAP:
0800    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0396000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C7B851CC C0397400 C0396000 00000001 00009030 00000000 C0397444
C0120000
GPR08: 00001566 C0397440 00000000 0BE22EDF 24F42F24 00000000 00000000
00000FA0
GPR16: 00000000 FFFC37BD 00000000 00000000 00001032 C03976A0 00000000
C0001914
GPR24: 00800000 00800000 C0110000 0000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
