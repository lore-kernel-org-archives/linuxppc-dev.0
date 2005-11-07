Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 308FE6868B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 06:49:18 +1100 (EST)
Date: Mon, 7 Nov 2005 12:49:17 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20051107124917.C1671@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix perf_irq extern on e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add an extern reference to perf_irq on e500.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
index 16adde6..ff1bdc2 100644
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -888,6 +888,8 @@ void altivec_assist_exception(struct pt_
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_E500
+extern perf_irq_t perf_irq;
+
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
