Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <F9102D41F595D311ACA7009027DE2C840527B190@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Opps...with ELDK-2.1.0 (ppc_4xx)
Date: Tue, 22 Apr 2003 10:59:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[background]
I've been using the ELDK-2.0.2 with the same kernel (2.4.21) and it has been very stable (uptime of ~4 months). I installed the ELDK-2.1.0 and mounted it (using the same kernel) and I'm observing an "Oops" after several minutes (~10 minutes or so).

I'll be digging through the logs for clues.

----
Oops: Exception in kernel mode, sig: 4
NIP: C000F2DC XER: 00000000 LR: C000F2DC SP: C0170C00 REGS: c0170b50 TRAP: 0700
   Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c016f070[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0x00002e28 acr=   0x9b000000 besr=  0x00000000

GPR00: C000F2DC C0170C00 C016F070 0000001B 00001030 00000001 00000020 C01C0000
GPR08: 00000E4F 00000000 00000000 C0170B20 C0170D98 100B21AC 07FA8300 007FFF9C
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 C0170F30 00000000 00000006
GPR24: C0170D68 C01DBA3C 00000000 C01C0000 0001B9FF C0170C38 00000000 C0170C00
Call backtrace:
C000F2DC C000F1EC C000FCEC C00DC510 C00DC860 C00DCF74 C00DA7A0
C00DB5CC C00DB720 C00DB110 C00DD664 C00DD7E4 C0004F04 C000376C
C00228C8 C0004D04 C0004D2C C00011D0 C0181598 C0000224
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..


Stephen B. Johnson
Senior Applications Engineer - Global Accounts
Artesyn Communication Products
8310 Excelsior Drive
Madison, Wisconsin  53717
(800) 356-9602  [work]
(608) 215-6997  [cell]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
