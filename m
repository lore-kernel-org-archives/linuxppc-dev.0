Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 436B7DE0F3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 16:00:09 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n07505RE012008
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 23:00:06 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Export cacheable_memzero as its now used in a driver
Date: Tue,  6 Jan 2009 23:00:05 -0600
Message-Id: <1231304405-15315-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale PowerPC specific gianfar driver (gig-e) uses
cacheable_memzero for performance reasons we need to export
the symbol to allow the driver to be built as a module.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/ppc_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index dcec132..c8b27bb 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -165,6 +165,7 @@ EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(cacheable_memcpy);
+EXPORT_SYMBOL(cacheable_memzero);
 #endif
 
 #ifdef CONFIG_PPC32
-- 
1.5.6.5
