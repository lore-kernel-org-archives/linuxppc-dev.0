Date: 30 Aug 2002 11:05:10 -0000
Message-ID: <20020830110510.6798.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Machine Check error in Embedded Planet Board
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am working on WLAN driver for Embedded Planet RPXLITE board on
Hard Hat Linux 2.0.

When i start a ping session of packet size 1400 or above.
Initially it works fine and after responding to around 200
packets, there is a machine check error occuring in function
in_be16().

NIP --- points to the routine where i will be in loop to read the
received data.

Any idea why this is happening??
Is this any problem with Kernel or with Embedded Planet board?

Thanks in Advance,
Naren

Here is the oops message that i get everytime,
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


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
