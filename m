Message-ID: <002b01bee8a2$78d4a3a0$67c13ec3@everyone>
From: "Neil Blackwood" <nb@terrafix.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: BOOT PROBLEMS WITH KERNEL 2.2.5 FOR MBX821
Date: Tue, 17 Aug 1999 12:20:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have  download  and built kernel 2.2.5 for MBX821 from the embeded ftp
site , but am now having problems with the kernel booting.

I have used mbx_defconfig, is this correct?

The following is a printout of the boot sequence, can anyone help, or at
least point me in the right direction as regards debugging.


Copyright Motorola Inc. 1988-1998, All Rights Reserved

MBX Debugger/Diagnostics Release Version 1.4 - 04/01/98 RM01
COLD Start

Local Memory Found =01000000 (&16777216)

MPU Clock Speed =40Mhz

WARNING: Keyboard Not Connected

WARNING: Low Battery Status - On_Board Battery

EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /sys/mbxroot/zImage

Client IP Address      = 192.168.1.11
Server IP Address      = 192.168.1.10
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /sys/mbxroot/zImage
Argument File Name     =

Bytes Received =&522979, Bytes Loaded =&522979
Bytes/Second   =&174326, Elapsed Time =3 Second(s)
loaded at:     00210000 001FD0D0
relocated to:  00100000 000ED0D0
board data at: 00FF4558 00FF4580
relocated to:  00200100 00200128
zimage at:     00217000 0027E052
avail ram:     0027F000 00FF5000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.5 (root@mbxdev) (gcc version egcs-2.91.60 19981201
(egcs-1.1.1 release)) #29 Mon Aug 16 14:33:56 GMT 1999
Boot arguments: root=/dev/nfs
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.83 BogoMIPS
Memory: 15144k available (728k kernel code, 468k data, 44k init)
[c0000000,c1000000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
NIP: 00000000 XER: 00000000 LR: C00E3D68 REGS: c013ddf0 TRAP: 0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c013c000[1] 'swapper' mm->pgd c00cb000 Last syscall: 120
last math 00000000
GPR00: 00000000 C013DEA0 C013C000 00000000 C00C5F29 C00D79C0 C00F4918
00000000
GPR08: 00000000 C00E0000 00000000 C0100000 5CC38473 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00FF4558 00000000
00000000
GPR24: 00000000 00000000 00000000 0020000D 00000005 C00F4858 00000001
C00F46D0
Call backtrace:
C00F4858 C00E3AF0 C00E3B5C C00E2AB8 C00DD760 C0002A04 C0006B28
Instruction DUMP:
Kernel panic: kernel access of bad area pc 0 lr c00e3d68 address 0 tsk
swapper/1
Rebooting in 180 seconds..
------------------------------------------------------
www.terrafix.co.uk

Terrafix Ltd
23c Newfield Industrial Estate
Tunstall, Stoke on Trent
Staffordshire, UK, ST6 5PD

+44 1782 577015, +44 1782 835667 (fax)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
