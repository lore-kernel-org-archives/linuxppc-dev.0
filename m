Message-ID: <A109131318C4D1119AC20060088DECE330F4C0@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Software Emulation Panic, 
Date: Thu, 22 Jun 2000 15:20:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I get a kernel panic I see:

NIP: 00001FFC XER: 8000FF7F LR: 00000988 REGS: c0e87c90 TRAP: 1000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0e86000[7] 'rc.sysinit' mm->pgd c0e8b000 Last syscall: 67
last math 00000000
GPR00: 00000000 C0E87D40 C0E86000 C0E87D50 0189EE34 C0133404 C0E88278
C0E8B000
GPR08: C00DA634 00FBA9E1 00FBA9E1 00FBA9E1 3555F593 018A31D0 00000000
00000D08
GPR16: 000000C1 01005000 0100A400 00300008 00001032 00E87D40 C00162F0
00009032
GPR24: 0189EE34 C0E88278 C0615760 00FBA8A1 C0FBA000 C0E86000 C0F5F000
C0132510
Call backtrace:
C0E87DF0 C0016204 C0016A98 C0009098 C0002544 018A4490 300E88A4
0180C6D4 0180C5D8 01803250 01802B64 01801D80
Instruction DUMP:


If the NIP = 00001FFC, then where is that? That is in the middle of
"Trap_1f" according to the System.map.

In the call backtrace, how do I know what addresses such as 018a4490 or
300e88a4 fall? System.map only has C000000++?



Please be patient with me. I am still learning. I really need to figure out
what is going on here. I come from the world of 8051 assembly programmed
into ROM. Memory management, task switching, and embedded operating systems
are new to me.


Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
