From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel hangs
Date: Thu, 1 Apr 2004 18:12:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404011812.23943.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

i 've problems to find out the reason of this error message:

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
=> bootm 100000
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.24-pre2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    571408 Bytes = 558 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (marco@linux) (gcc-Version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #11 Do Apr 1 14:55:27 CEST 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.55.1:/opt/eldk/ppc_82xx
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 30984k available (1008k kernel code, 328k data, 52k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2 at 0x8100, BRG1
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C012B260 XER: 20000000 LR: C012B21C SP: C01E9EE0 REGS: c01e9e30 TRAP: 0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01e8000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 38800001 C01E9EE0 C01E8000 C1F97200 00000001 00000000 C0107A4C 00000000
GPR08: 00000008 00000080 F0010C1C F8000004 84008044 FFFFDFFD 01FFE000 007FFF3C
GPR16: 00000000 00000001 007FFF00 01FF8CC4 C00A3614 C00A2A2C C00A2390 C00A21EC
GPR24: C00A3180 C00A2A4C 00000000 C0100000 C011B8DC C011B8DC C1F97200 F0011320
Call backtrace:
C012B21C C012ABDC C0129CE0 C0129D1C C012B76C C0129864 C0122634
C0122678 C00039D0 C0008318
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..
//////////////////////////////////////////////////////////////////////////////


My system is a MPC8275 based PQ2FADS-board. U-Boot 1.0.2 is running on it. Toolchain ELDK 3.0.
The base board in the kernel menuconfig is the MPC8260ADS. I read in the user manuals of both MPC8260ADS and PQ2FADS. Their base adresses of immr and bcsr are identical.
The FCC MDIO support was changed for the PQ2board.
Where are the problems?
TEA signal of my ppc ?? I've greped the traps.c in arch/ppc/kernel of the denx linuxppc_devel kerneltree. RAM Problems ??


What do you know about this message ??

Thanks in advance

Marco



---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
