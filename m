Return-Path: <tglx@linutronix.de>
Received: from tglx.tec.linutronix.de (pD953A967.dip.t-dialin.net
	[217.83.169.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1CF12BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jan 2005 23:26:05 +1100 (EST)
Date: Sun, 9 Jan 2005 13:25:43 +0100
From: tglx@linutronix.de
Message-ID: <20050109132529.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain
To: trini@kernel.crashing.org
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-mm2] Remove duplicate define (PPC)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The MMCR0_PMXE is already defined in reg.h, so no need to redefine it here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 perfmon.c |    1 -
 1 files changed, 1 deletion(-)
---
Index: 2.6.10-mm2/arch/ppc/kernel/perfmon.c
===================================================================
--- 2.6.10-mm2/arch/ppc/kernel/perfmon.c	(revision 141)
+++ 2.6.10-mm2/arch/ppc/kernel/perfmon.c	(working copy)
@@ -47,7 +47,6 @@
 
 #else
 /* Ensure exceptions are disabled */
-#define MMCR0_PMXE      (1UL << (31 - 5))
 
 static void dummy_perf(struct pt_regs *regs)
 {
