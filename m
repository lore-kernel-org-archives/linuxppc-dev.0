Date: 22 Aug 2002 06:29:54 -0000
Message-ID: <20020822062954.18098.qmail@webmail8.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Embedded Planet 
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have my WLAN driver running on Embedded Planet board with
HardHat Linux.

But when i send a ping of size more than 1000 bytes, there is
crash everytime after successful req/reply of about 250packets.

Here is the oops message i got,

Machine check in kernel mode.
Caused by (from SRR1=9032): Unknown values in msr
Oops: machine check, sig: 7
NIP: C56784CC XER: C000197F LR: C567849C SP: C0129E20 REGS:
c0129d70 TRAP: 0200
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0128010[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000498 C0129E20 C0128010 00000000 8000001C 000002C1
00000000 C3CA8800
GPR08: 80000036 00000100 00000498 00003637 35F33F93 1001B8DC
FF76FFDF BFBBFE7F
GPR16: FFFFFDFF BFFFFFFF FFEFFFFF FFFFFEFF 00001032 00129EF0
00000000 00000036
GPR24: 00000018 00000000 000005D8 C3F87604 C3CA8C98 C3F87400
8000001C 0000001C
Call backtrace:
C567849C C5676A78 C5674D94 C0003904 C0003A30 C0002810 C0003F84
C0003F98 C01367C0 C00021E4
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing
Rebooting in 180 seconds..

any idea why there is a crash?.

thanks in advance for all inputs,

Naren


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
