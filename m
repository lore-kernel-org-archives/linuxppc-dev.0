Message-Id: <200404260127.UAA32565@lists.linuxppc.org>
Date: Mon, 26 Apr 2004 09:28:18 +0800
From: "jeffy" <leo_guo@jisung.cn>
To: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC Linux painic problem!
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
	I hit on a problem about PPC Linux version 2.4.4 on a MPC855T board.
    The kernel can start up ok normally, but when another PC continous sending UDP packets to it(about 8Mbps) when kernel is starting up, the kernel failed start up and printf the following messages:

.................................
.................................
.................................
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
Oops: kernel access of bad area, sig: 11
NIP: C0095828 XER: C000057F LR: C0097804 SP: C01C7CA0 REGS: c01c7bf0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: BF80F66F, DSISR: 0000000B
TASK = c01c6000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00CC2222 C01C7CA0 C01C6000 C1F713F0 C0A82C60 C0A82C5D 00000000 C1DC3C00
GPR08: 00000002 00000000 00000200 BF80F5F3 FFFFFFFF 1004FCEC 01FDD000 007FFF0D
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 001C7D40 00000000 C0002870
GPR24: 00000180 C00FD5C0 00000800 C1DC3C00 C0A82C5D 00000000 C1F713F0 C0A82C60
Call backtrace:
00000001 C0097804 C008D720 C0013BE4 C00028A0 C000EE10 C0106494
C01066EC C0106EA4 C00FE78C C00FE830 C00023CC C0004D68
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
Rebooting in 180 seconds..

What's the problems? Is it  a bug?
Best Regards!

Jeffy Guo
Bocom Digital Crop. Shanghai, China.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
