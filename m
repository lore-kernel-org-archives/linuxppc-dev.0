To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 28 Jun 2001 14:47:24 +0200
From: "karanth karanth" <karanthk@lycos.com>
Message-ID: <CIBMLCKCKHCODAAA@mailcity.com>
Mime-Version: 1.0
Reply-To: karanthk@lycos.com
Subject: kernel panic...........
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hai,
I have been using mpc823 with 2.2.14 kernel, below shows the output message of the kernel panic.

Boot

loaded at	: 00000000 	000141B4
board data at	: 00202344	00202374
zimage at	: 0038A000	0007E0B1
avail ram		: 002141B4	0038A000

Linux/PPC load: console=ttyS0, 19200n8!

Uncompressing Linux...done
hold_residual=00600100
Now booting the kernel
###########################
NIP 00000000 XER: E000B97F LR: C0006564 REGS: c00f7e50 TRAP: 0400
MSR: 08209032 EE: 1 PR: 0 FP:0 ME: 1  IR/DR: 11
TASK = c00f6000[1] 'swapper'  mm->pgd c017f000 Last syscall = -1
last math 00000000

GPR00:	00000078  C00F7F40  C00F6000  00000E00    00000000    00000E000  00000000  C00CE857
GPR08:	00000024  C00D0000  FF002068  C00B3AC8 956DF039   000000000  00000000   00100000
GPR16:	04000000  FF000000   0000006E   00000000    00020000    00202344    00000000   02008000
GPR24:	00200000  00080080    00000000   00600015    00600000    00000000    C00C0000  C00C0000
Call backtrace:
00000000
Instruction DUMP:
kernel panic: kernel access of bad area pc 0 lr c0006564 address 0 tst swapper/1
Rebooting in 180 secound ...
########################
can anybody tell me what could be the reason of the crash.

Thanking you,
kk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
