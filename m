Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "James Bates" <jbates@paradise.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ELDK on MPC8260ADS board, Machine check in kernel
Date: Thu, 11 Dec 2003 12:50:47 -0000
Message-ID: <OJEPIMKHOKJAJIDJLJBNMEIMCAAA.jbates@paradise.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Reply-To: jbates@paradise.co.uk
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am trying to get linux running on my standard MPC8260ADS board but I have
hit a dead end.
I am getting a "Machine check in kernel mode." error about the time that
ramdisks are setup.
I am using the linuxppc_2_4_devel eldk which I checked out this week and
u-boot 0.4.0. I have added the boot output at the end of this message for
those that are interested. I have also attempted to make some sense of the
backtrace from the System.map

Any ideas would be greatly appreciated.

Regards,

James Bates

## Booting image at 00100000 ...
   Image Name:   Linux-2.4.23
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    576640 Bytes = 563.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.23 (root@builder) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #15 Thu Dec 11 12:00:03 GMT3On node 0
totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Warning: real time clock seems stuck!
Calibrating delay loop... 88.67 BogoMIPS
Memory: 14712k available (1048k kernel code, 360k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2 at 0x8100, BRG1
pty: 256 Unix98 ptys configured
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C0141DF8 XER: 20000000 LR: C0141DAC SP: C01B5F00 REGS: c01b5e50 TRAP:
0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01b4000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000080 C01B5F00 C01B4000 C01B7400 00000000 00000000 00000004
0000001E
GPR08: C0147A98 800B0000 C0140000 FF010004 84004042 05505F9B 00FF9000
007FFF10
GPR16: C00A22D8 C00A1A38 C00A1B78 C00A21E8 C00A2208 C00A2214 C00A2218
00000000
GPR24: C0110000 C0110000 C012EBFC C01B747C FFFFFFFF C012EBD0 C01B7400
F0011320
Call backtrace:
C0141DAC C014186C C0140BD4 C0140C10 C0142384 C0140474 C01385A4
C01385EC C00039D0 C0008478
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

C0141DAC
C014186C
C0140BD4
C0140C10
C0142384
C0140474
C01385A4
C01385EC
C00039D0
C0008478

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
