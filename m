Message-ID: <3D4FA9B7.A86AE296@imc-berlin.de>
Date: Tue, 06 Aug 2002 12:49:27 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx and IRQ0 ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

can I use the NMI IRQ0 for something useful or is he always routet to some trap
handler causing the kernel to panic?

bash-2.04# Bad trap at PC: c0005e64, SR: 9032, vector=100    Not tainted
Oops: Exception in kernel mode, sig: 5
NIP: C0005E64 XER: 00000000 LR: C0005E78 SP: C0168F40 REGS: c0168e90 TRAP:
0100    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0166fb0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0168F40 C0166FB0 00000000 00000032 C01F7DE8 C01ECDC4 FFFFFC18
GPR08: C01741C8 C018809C C01F6000 C01742C4 C0166924 1001F30C 00FE6F00 007FFF16
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00FE14C8 00000000 00FA0340 00000001
GPR24: 00000000 00FE97C4 007FFEC0 007FFF16 007FFF00 C0180000 00000000 C0180000
Call backtrace:
C0005E78 C0005E8C C000227C C0178588 C0002138
imcDev_IRQMiscHandler: irq=0				!!!!!!!!
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Rebooting in 180 seconds..

My handler is getting called but then...

Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
