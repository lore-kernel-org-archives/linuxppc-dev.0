Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linux booting problem: TASK = c0120490[0] 'swapper' Last syscall: 0
Date: Thu, 25 Mar 2004 16:26:38 +0800
Message-ID: <000001c41242$e4b86dd0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200403250205.i2P25CkY017784@ms.usish.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,

In the process of porting linux to a mpc8250 board, I got a very strange
thing:

On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=1F00 init=/rcinit
Calibrating delay loop... 131.89 BogoMIPS
Oops: kernel access of bad area, sig: 11
NIP: C01513CC XER: 00000000 LR: C015162C SP: C01223F0 REGS: c0122340 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C01AF040, DSISR: 08000000
TASK = c0120490[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: FFFFFFFF C01223F0 C0120490 C0123698 00000000 00000001 C0160000 00000000
GPR08: 00000001 00000040 C01AF000 00000000 24444028 00422100 006D4A0F 20062000
GPR16: 2D808504 00000000 00000002 007FFF00 003FF000 0041A890 004FFC78 008000B4
GPR24: 00000000 00000001 80000000 00000000 00008000 C0160BA8 00000201 C01BC860
Call backtrace:
C0122438 C015162C C014F9C0 C014E724 00003724
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
Rebooting in 180 seconds..Kernel is rebooting.....

===========================================================================

But, I have this kernel run another old mpc8250 board. Everying is OK.

have you met the same problems on porting linux kernel? or could you
give me any suggestions?

Tanks in advance!
John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
