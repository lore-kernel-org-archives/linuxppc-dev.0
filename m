Reply-To: <kamarajp@future.futsoft.com>
From: "Kamaraj P" <kamarajp@future.futsoft.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kenal Panic
Date: Wed, 19 Mar 2003 11:56:25 +0530
Message-Id: <000801c2ede0$78f56300$3c06140a@future.futsoft.com>
MIME-Version: 1.0
In-Reply-To: <20030312130214.A7123@reric.net>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am getting this Kernel Panic message when I invoke ping flood from MPC8xx
.
How can I troubleshoot this message.

Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C00292BC XER: C0001D7F LR: C00292BC SP: C3A07BC0 REGS: c3a07b10 TRAP:
1000
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3a06000[114] 'ping' Last syscall: 102
last math 00000000 last altivec 00000000
GPR00: C00292BC C3A07BC0 C3A06000 0000001B 00001032 00000001 00000001
00000000
GPR08: 00000000 C0130000 0000001F C3A07B00 55F33F93 1001B8DC 00000000
100AE410
GPR16: 10010000 10010000 10010000 10010000 00001032 03A07D00 00000000
C012A1A0
GPR24: 00000120 C3A07D10 C012A1A0 00000007 00000007 C3A07C08 C012A1A0
C01790C0
Call backtrace:
C00292BC C00297A0 C5645BDC C564555C C5643524 C563E21C C0003904
C0003A30 C0002810 C00151D0 C0018B48 C0015028 C0014ED4 C0014C54
C000285C 10010000 7FFFFCE8 10001664 0FED9DBC 00000000
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing
Rebooting in 180 seconds..


Can any one knows ??

Thanks in advance
Kamaraj.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
