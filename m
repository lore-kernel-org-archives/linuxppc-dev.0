Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Thu, 29 Jul 2004 16:37:48 +0800
From: "hu" <hl76@263.net>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Software FPU Emulation
Mime-Version: 1.0
Content-Type: text/plain
Message-Id: <20040729083532.57B4F2F7B5@smtp.263.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


1)environment
Linux kernel 2.4.4-rthal5
ppcboot 1.1.5
MPC823 board

2)I'm running a device driver which read data from touchpanel, sometimes
I get message like that:
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C000BC0C XER: C000206F LR: C000BC0C SP: C019FF60 REGS: c019feb0 TRAP: 1000
MSR: 00009032
TASK = c019dff0[0] 'swapper' Last syscall: 120
......
Call backtrace
C000BC0C C0003EE4 C0003EFC C01BA750 C00021E4

3)I check in System.map
C000BC0C 	Schedule
C0003EE4 	Letext(idled)
C0003EFC	cpu_idle
C01BA750	start_kernel
C00021E4	start_here

4)I dont know how can I do, from messages above, I cant see any clue to solve.

John Hu
hl76@263.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
